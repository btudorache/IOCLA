%include "io.mac"

ASCII_ONE equ 49
BIG_LETTER_LOWER_LIMIT equ 64
FIRST_ASCII_DIGIT equ 48

section .data
	sequence_len DD 0 

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex
    mov dword [sequence_len], ecx     ; mutarea length-ului in variabila counter pentru a parcurge literele crescator
    xor ebx, ebx

    mov ax, cx
    mov ecx, 4
    div cl     ; in bl vom avea un counter care incepe de la 4 si se duce la 1. Valoarea initiala din bl depinde de restul impartirii la 4 a lungimii stringului
    cmp ah, 0 
    jz move_4

    mov bl, ah
    jmp skip_if
move_4:
	mov bl, 4

skip_if:

    mov al, 0
    mov edi, 0
    xor ecx, ecx

loop_sequence:     ; loop_ul principal
	cmp byte [esi + ecx], ASCII_ONE     ; daca byte-ul verificat este 1, il adaugam la secventa de cate 4 byte
	jnz check_fourth_tick               ; daca byte-ul nu este unu, se verifica direct daca ne aflam la finalul unei secvente de cate 4

	; Aici are loc creearea valorii in hexazecimal byte cu byte, in functie de valoarea din bl, iar rezultatul se pune in al
	; Ne folosim temporar de registrii ebx si ecx pentru a face mutarile
	push ebx
	dec bl

	push ecx
	mov cl, bl
	push ebx
	mov bl, 1
	shl bl, cl     ; shiftam valoarea cu numarul de biti din acel counter de la 4 la 1
	add al, bl     ; adunam rezultatul in registrul al
	pop ebx
	pop ecx

	pop ebx


check_fourth_tick:     ; se verifica daca ajungem la finalul unei secvente de cate 4 byte. 
	dec bl
	cmp byte bl, 0
	jnz check_loop

	cmp al, 10     ; verificam daca secventa are valoarea insumata peste 10 sau sub 10
	jl not_letter 

letter:
	add al, BIG_LETTER_LOWER_LIMIT
	sub al, 9
	jmp move_sequence
not_letter:     ; prelucrarea daca secventa este mai mica de 10
	add al, FIRST_ASCII_DIGIT

move_sequence:        ; prelucrarea daca secventa este mai mare sau egala cu 10
	mov byte [edx + edi], al

	mov bl, 4     ; refacerea secventei de cate 4
	inc edi		  ; incrementarea indexului pentru string-ul in hexazecimal
	xor eax, eax  ; curatarea valorii din al

check_loop:
	inc ecx
	cmp dword [sequence_len], ecx
	jnz loop_sequence

	mov byte [edx + edi], 10     ; punerea la finalul stringului unui \n
	inc edi
	mov byte [edx + edi], 0      ; terminarea stringului cu \0
	
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY