ASCII_FIRST_DIGIT equ 48
ASCII_LAST_DIGIT equ 57
PLUS_SIGN equ 43
MINUS_SIGN equ 45
MULTIPLY_SIGN equ 42
DIVISION_SIGN equ 47

section .data
    delim DB " ", 0
    is_signed DB 0

section .text

extern strtok
extern printf
extern strdup
extern malloc

global create_tree
global iocla_atoi

iocla_atoi:
	enter 0, 0
	push ebx
 	
 	xor eax, eax
 	xor ecx, ecx
    mov ebx, dword [ebp + 8]

check_if_negative: ; verificam daca stringul primit este asociat unui numar negativ
    cmp byte [ebx], MINUS_SIGN
    jnz loop_letters

	mov edi, is_signed ; setam flag-ul is_signed 
	mov byte [edi], 1
	inc ecx 

loop_letters: ; verificarea fiecarei litere pe rand pentru a forma int-ul
	mov edx, 10	; inmultesc eax cu 10
	mul edx

	xor edx, edx
	mov byte dl, [ebx + ecx] ; adaug litera in eax
	add eax, edx
	sub eax, ASCII_FIRST_DIGIT

	inc ecx,
    cmp byte [ebx + ecx], 0 
    jnz loop_letters

prelucrate_if_negative: ; daca numarul este negativ, inmultim rezultatul din eax cu -1
    mov ecx, is_signed
    cmp byte [ecx], 1
    jnz leave_iocla_atoi

	mov ecx, -1
	mul ecx

leave_iocla_atoi:
	mov ebx, is_signed
	mov byte [ebx], 0

    pop ebx
   	leave
    ret


create_tree: ; 
    enter 0, 0
    push ebx

    mov ebx, dword [ebp + 8] ; punem expresia in forma prefixata in ebx

    ; functia add_tree_node primeste ca parametru cate un token
    ; si folosim strtok pentru a lua tokenii rand pe rand
    push delim
    push ebx
    call strtok
    add esp, 8

    ; apelam functia recursiva care construieste arborele
    push eax
    call add_tree_node
    add esp, 4

    pop ebx
    leave
    ret

; functia care construieste recursiv arborele
; primeste ca parametru un token din expresie
add_tree_node:
	enter 0, 0
	push ebx

allocate_node:
	mov ebx, [ebp + 8]
	push 12
	call malloc ; folosim malloc pentru a aloca memorie
	add esp, 4
	mov ecx, eax ; punem adresa nodului alocat in ecx

	push ecx
	push ebx
	call strdup ; folosim strdup pentru a crea un deepcopy al tokenului
	add esp, 4
	pop ecx

	; asociem fiecarui camp din nod valoarea corecta
	mov [ecx], eax
	mov dword [ecx + 4], 0
	mov dword [ecx + 8], 0

	; verificam daca tokenul primit ca parametru este operand sau operator
	cmp byte [ebx], PLUS_SIGN
	je operator_branch

	; daca tokenul este '-', verificam daca nu cumva
	; tokenul primit este un numar negativ
	cmp byte [ebx], MINUS_SIGN
	jne continue_sign_check
	cmp byte [ebx + 1], 0
	je operator_branch

continue_sign_check:
	cmp byte [ebx], MULTIPLY_SIGN
	je operator_branch
	cmp byte [ebx], DIVISION_SIGN
	jne leave ; daca tokenul este un operand, iesim din functie si intoarcem adresa de inceput a nodului

; daca tokenul este un operator, apelam functia recursiva pentru a construi
; cate un nod nou pentru fiul din dreapta si fiul din stanga
operator_branch:
	push ecx
	push delim
	push 0
	call strtok ; obtinem un token nou cu strtok 
	add esp, 8

	push eax
	call add_tree_node ; apelam functia recursiva
	add esp, 4
	pop ecx
	mov dword [ecx + 4], eax

; acelasi lucru se intampla si pentru nodul din dreapta
	push ecx
	push delim
	push 0
	call strtok
	add esp, 8

	push eax
	call add_tree_node
	add esp, 4
	pop ecx	
	mov dword [ecx + 8], eax

leave:
	mov eax, ecx ; asezam valoarea de return (adresa nodului nou construit) in eax

	pop ebx
	leave
	ret