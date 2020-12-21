%include "io.mac"

BIG_LETTER_START equ 64
BIG_LETTER_LIMIT equ 91
FIRST_BIG_LETTER equ 65

SMALL_LETTER_START equ 96
SMALL_LETTER_LIMIT equ 123
FIRST_SMALL_LETTER equ 97

section .data
	counter DB 0 

section .text
	global vigenere
	extern printf

vigenere:
	;; DO NOT MODIFY
	push    ebp
	mov     ebp, esp
	pusha

	mov     edx, [ebp + 8]      ; ciphertext
	mov     esi, [ebp + 12]     ; plaintext
	mov     ecx, [ebp + 16]     ; plaintext_len
	mov     edi, [ebp + 20]     ; key
	mov     ebx, [ebp + 24]     ; key_len
	;; DO NOT MODIFY

	;; TODO: Implement the Vigenere cipher
	mov dword [counter], ecx     ; mutarea length-ului in variabila counter pentru a parcurge literele crescator
	xor ecx, ecx     ; in ecx va fi indexul string-ului dat ca input, incepand de la 0
	xor eax, eax     ; in eax va fi indexul cheii, incepand de la 0

loop_letters:
	
check_big_letter:     ; Procesam octetii numai daca sunt litere
	cmp byte [esi + ecx], BIG_LETTER_START
	jbe check_small_letter
	cmp byte [esi + ecx], BIG_LETTER_LIMIT
	jae check_small_letter

	jmp move_letter

check_small_letter:     ; Procesam octetii numai daca sunt litere
	cmp byte [esi + ecx], SMALL_LETTER_START
	jbe not_letter
	cmp byte [esi + ecx], SMALL_LETTER_LIMIT
	jae not_letter

move_letter:     ; aplicam cheia si mutam rezultatul in cyphertext. Ne folosim temporar de registrul ebx pentru a aplica mutarea
	push ebx
	xor ebx, ebx
	mov bl, byte [esi + ecx]
	add bl, byte [edi + eax]
	sub bl, FIRST_BIG_LETTER
	mov byte [edx + ecx], bl
	pop ebx
	inc eax     ; tinem cont de indexul cheii, pe care il incrementam

check_passed_limit:     ; verificam daca, dupa aplicarea cheii, byte-ul nu mai e intre intervalele pentru litere mici si litere mari
	cmp byte [edx + ecx], SMALL_LETTER_LIMIT
	jae rotate
	cmp byte [edx + ecx], SMALL_LETTER_START
	jae check_key_index
	cmp byte [edx + ecx], BIG_LETTER_LIMIT
	jae rotate

	jmp check_key_index

rotate:     ; se aplica rotatii (se scade 26) pana cand octetul se va afla intr-unul din intervalele corecte
	sub byte [edx + ecx], 26
	jmp check_passed_limit

check_key_index:     ; aici verificam daca indexul cheii devine egal cu lungimea cheii. In caz afirmativ, se parcurge cheia iar de la 0.
	cmp eax, ebx
	jnz check_loop
	xor eax, eax
	jmp check_loop

not_letter:		; octetii care nu sunt litere nu vor fi cifrati. Ne folosim temporar de registrul ebx pentru a face mutarea
	push ebx
	xor ebx, ebx
	mov bl, byte [esi + ecx]
	mov byte [edx + ecx], bl
	pop ebx

check_loop:
	
	inc ecx
	cmp dword [counter], ecx
	jnz loop_letters

	;; DO NOT MODIFY
	popa
	leave
	ret
	;; DO NOT MODIFY