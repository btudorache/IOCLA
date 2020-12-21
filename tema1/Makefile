# compiler setup
CC=gcc
CFLAGS=-Wall -Wextra -std=c99

# define targets
TARGETS=tema1

build: $(TARGETS)

tema1: tema1.c
	$(CC) $(CFLAGS) tema1.c -o tema1

pack:
	zip -FSr 324CA_TudoracheBogdanMihai_IOCLA_Tema1.zip README *.c *.h *.pdf 

run: tema1.c
	./tema1

clean:
	rm -f $(TARGETS)
