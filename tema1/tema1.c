#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>

#define MINIMUM_SIGNED_INT_VALUE -2147483648
#define MAX_STRING_LENGTH 1000000

static int write_stdout(const char *token, int length) {
	int rc;
	int bytes_written = 0;

	do {
		rc = write(1, token + bytes_written, length - bytes_written);
		if (rc < 0)
			return rc;

		bytes_written += rc;
	} while (bytes_written < length);

	return bytes_written;
}

/*
Codificarea parametrilor:
	0 if no parameter
	1 for d
	2 for u
	3 for c
	4 for x
	5 for s
	6 for double %
*/
int check_for_parameter(const char* str, int pos) {
	if (str[pos] == '%' && str[pos + 1] == 'd') {
		return 1;
	} else if (str[pos] == '%' && str[pos + 1] == 'u') {
		return 2;
	} else if (str[pos] == '%' && str[pos + 1] == 'c') {
		return 3;
	} else if (str[pos] == '%' && str[pos + 1] == 'x') {
		return 4;
	} else if (str[pos] == '%' && str[pos + 1] == 's') {
		return 5;
	} else if (str[pos] == '%' && str[pos + 1] == '%') {
		return 6;
	} else {
		return 0;
	}
}

int count_parameters(const char* str) {
	int num_parameters = 0;
	for (int i = 0; i < (int) strlen(str) - 1; i++) {
		if (check_for_parameter(str, i)) {
			num_parameters += 1;
			i++;
		}
	}
	return num_parameters;
}

int** get_positions(const char* str, int num_parameters) {;
	int** positions = malloc(num_parameters * sizeof(*positions));
	for (int i = 0; i < num_parameters; i++) {
		positions[i] = malloc(2 * sizeof(**positions));
	}

	int pos = 0;
	for (int i = 0; i < (int) strlen(str) - 1; i++) {
		if(check_for_parameter(str, i)) {
			positions[pos][0] = i;
			positions[pos++][1] = check_for_parameter(str, i);
			i++;
		}
	}
	return positions;
}

void free_matrix(int **array, int rows) {
	for (int i = 0; i < rows; i++) {
		free(array[i]);
	}
	free(array);
}

int count_digits(int integer) {
	int num_digits = 0;
	while (integer) {
		integer /= 10;
		num_digits += 1;
	}
	return num_digits;
}

int count_digits_hex(unsigned int integer) {
	int num_digits = 0;
	while (integer) {
		integer /= 16;
		num_digits += 1;
	}
	return num_digits;
}

void reverse_string(char* str) {
	int len = strlen(str);
	for (int i = 0; i < len / 2; i++) {
		unsigned char aux = str[i];
		str[i] = str[len - 1 - i];
		str[len - 1 - i] = aux;
	}
}

// codificarea cifrelor in hexazecimal
char get_hex_char(int digit) {
	if (digit == 10) {
		return 'a';
	} else if (digit == 11) {
		return 'b';
	} else if (digit == 12) {
		return 'c';
	} else if (digit == 13) {
		return 'd';
	} else if (digit == 14) {
		return 'e';
	} else if (digit == 15) {
		return 'f';
	} else {
		return '0' + digit;
	}
}

char* parse_signed_integer(int integer) {
	char *parsed_signed_integer = calloc(count_digits(integer) + 1, sizeof(*parsed_signed_integer));
	int negative = 0;

	unsigned int integer_copy = 0;
	// daca bit-ul de semn este 1 (numarul negativ), se transforma numarul in pozitiv
	if ((integer & (1 << 31)) == (1 << 31)) {
		// caz limita cand are loc overflow (cred) daca incerc sa transform numarul in pozitiv ca in celelalte situatii
		if (integer == MINIMUM_SIGNED_INT_VALUE) {
			integer_copy = (unsigned int) integer;
		} else {
			integer_copy = -integer;
		}
		strcat(parsed_signed_integer, "-");
		negative = 1;
	} else {
		integer_copy = integer;
	}

	while(integer_copy) {
		char last_digit_string[] = {integer_copy % 10 + '0', '\0'};
		strcat(parsed_signed_integer, last_digit_string);
		integer_copy /= 10;
	}

	if (negative) {
		reverse_string(parsed_signed_integer + 1);
	} else {
		reverse_string(parsed_signed_integer);
	}
	return parsed_signed_integer;
}

char* parse_unsigned_integer(unsigned int integer) {
	char *parsed_unsigned_integer = calloc(count_digits(integer) + 1, sizeof(*parsed_unsigned_integer));

	while(integer) {
		char last_digit_string[] = {integer % 10 + '0', '\0'};
		strcat(parsed_unsigned_integer, last_digit_string);
		integer /= 10;
	}

	reverse_string(parsed_unsigned_integer);
	return parsed_unsigned_integer;
}

char* parse_char(int c) {
	char *parsed_char = calloc(2, sizeof(*parsed_char));
	parsed_char[0] = (char) c;

	return parsed_char;
}

char* parse_string(char* str) {
	char* parsed_string = calloc(strlen(str) + 1, sizeof(*parsed_string));
	strcpy(parsed_string, str);

	return parsed_string;
}

char* parse_unsigned_hex(unsigned int integer) {
	char *str = calloc(count_digits_hex(integer) + 1, sizeof(*str));

	while(integer) {
		char last_digit_string[] = {get_hex_char(integer % 16), '\0'};
		strcat(str, last_digit_string);
		integer /= 16;
	}
	reverse_string(str);
	return str;
}

char* parse_double_percent() {
	char *parsed_double_percent = calloc(2, sizeof(*parsed_double_percent));
	parsed_double_percent[0] = '%';
	return parsed_double_percent;
}


int iocla_printf(const char *format, ...) {
	va_list args;
	int num_parameters = count_parameters(format);

	if (num_parameters) {
		int **positions = get_positions(format, num_parameters);

		va_start(args, format);

		char new_string[MAX_STRING_LENGTH] = "";
		char* parsed_parameter = NULL;
		int string_pointer = 0;
		int buffer_size = 0;

		for (int i = 0; i < num_parameters; i++) {

			if (i == 0) {
				buffer_size = positions[0][0];
			} else {
				buffer_size = positions[i][0] - positions[i - 1][0] - 2;
			}
			strncat(new_string, format + string_pointer, buffer_size);

			if (positions[i][1] == 1) {
				parsed_parameter = parse_signed_integer(va_arg(args, int));
			} else if (positions[i][1] == 2) {
				parsed_parameter = parse_unsigned_integer(va_arg(args, unsigned int));
			} else if (positions[i][1] == 3) {
				parsed_parameter = parse_char(va_arg(args, int));
			} else if (positions[i][1] == 4) {
				parsed_parameter = parse_unsigned_hex(va_arg(args, unsigned int));
			} else if (positions[i][1] == 5) {
				parsed_parameter = parse_string(va_arg(args, char*));
			} else if (positions[i][1] == 6) {
				parsed_parameter = parse_double_percent();
			}
			strcat(new_string, parsed_parameter);
			free(parsed_parameter);

			string_pointer = positions[i][0] + 2;

		}
		buffer_size = strlen(format) - positions[num_parameters - 1][0] - 2;
		strncat(new_string, format + string_pointer, buffer_size);
		va_end(args);
		
		write_stdout(new_string, strlen(new_string));

		free_matrix(positions, num_parameters);
		return strlen(new_string);

	} else {
		write_stdout(format, strlen(format));
		return strlen(format);
	}
}
