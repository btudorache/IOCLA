%include "io.mac"

BIG_LETTER_START equ 64
BIG_LETTER_LIMIT equ 91
FIRST_BIG_LETTER equ 65

SMALL_LETTER_START equ 96
SMALL_LETTER_LIMIT equ 123
FIRST_SMALL_LETTER equ 97

section .text
    global caesar
    extern printf


caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher
    mov ebx, 1
loop_letters:       ; loop-ul care trece prin fiecare litera din plaintext

check_big_letter:     ; in acest label se verifica daca litera este 'mare', adica daca este intre 64 si 91 in codul ASCII
    cmp byte [esi + ecx - 1], BIG_LETTER_START
    jbe check_small_letter
    cmp byte [esi + ecx - 1], BIG_LETTER_LIMIT
    jae check_small_letter

    add [esi + ecx - 1], edi     ; aplicarea cheii
    cmp byte [esi + ecx - 1], BIG_LETTER_LIMIT     ; daca dupa aplicarea cheii se depaseste intervalul [64, 91], aplicam 'rotatiile'
    jae passed_big_letter_limit ;

    mov al, byte [esi + ecx - 1]     ; mutarea byte-ului cifrat in string-ul ciphertext
    mov [edx + ecx - 1], al
    jmp end_loop

passed_big_letter_limit:     ; se aplica 'rotatii' (se scade 26) pana cand byte-ul ajunge in intervalul [64, 91]
    mov al, byte [esi + ecx - 1]
    sub al, BIG_LETTER_LIMIT
    add al, FIRST_BIG_LETTER
    mov byte [esi + ecx - 1], al

    cmp byte [esi + ecx - 1], BIG_LETTER_LIMIT
    jae passed_big_letter_limit

   	mov byte [edx + ecx - 1], al     ; mutarea byte-ului cifrat in string-ul ciphertext
    jmp end_loop

check_small_letter:     ; toate operatiile pentru literele mici sunt exact aceleasi ca si pentru literele mari
	cmp byte [esi + ecx - 1], SMALL_LETTER_START
    jbe not_letter
    cmp byte [esi + ecx - 1], SMALL_LETTER_LIMIT
    jae not_letter

    add [esi + ecx - 1], edi
    cmp byte [esi + ecx - 1], SMALL_LETTER_LIMIT
    jae passed_small_letter_limit

    mov al, byte [esi + ecx - 1] 
    mov [edx + ecx - 1], al
    jmp end_loop

passed_small_letter_limit:
	mov al, byte [esi + ecx - 1]
    sub al, SMALL_LETTER_LIMIT
    add al, FIRST_SMALL_LETTER
    mov byte [esi + ecx - 1], al

    cmp byte [esi + ecx - 1], SMALL_LETTER_LIMIT
    jae passed_small_letter_limit

    mov byte [edx + ecx - 1], al
    jmp end_loop

not_letter:     ; octetii care nu sunt litere nu vor fi cifrati
	mov al, byte [esi + ecx - 1]
	mov byte [edx + ecx - 1], al

end_loop:
    dec ecx
    jnz loop_letters
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY