%include "io.mac"

section .data
	haystack_len DD 0 
	needle_len DD 0

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr
    mov eax, ecx
    sub eax, edx     ; o sa verificam doar literele care se incadreaza in haystack_len - needle_len
    mov dword [haystack_len], eax     ; mutarea haystack_length-ului in variabila counter pentru a parcurge literele crescator
    mov dword [needle_len], edx       ; mutarea needle_length-ului in variabila counter pentru a parcurge literele crescator
    xor ecx, ecx
    xor edx, edx
    xor eax, eax

loop_haystack:     ; primul loop, de la 0 la haystack_len - needle_len
	xor edx, edx
	push ecx	   ; ne folosim de ecx si in primul loop, si pentru a verifica daca literele din haystack si needle sunt egale, de aceea pastram valoarea
loop_needle:	   ; al doilea loop, aici cautam 'acul' in 'carul cu fan'
	mov al, byte [esi + ecx]
	
	cmp al, [ebx + edx]
	jnz break_needle_loop     ; daca nu gasim needle, trecem la urmatoarea iteratie din primul loop

	inc edx
	inc ecx
	cmp dword [needle_len], edx
	jnz loop_needle     ; daca cele doua litere sunt egale, cautam in continuare
	jmp found           ; daca am gasit string-ul, sarim la found

break_needle_loop:     ; continuarea loop-ului principal
	pop ecx
	inc ecx
	cmp dword [haystack_len], ecx
	jnz loop_haystack
	jmp not_found

found:     ; se muta indexul de inceput al lui needle in in edi si se termina executia
	pop ecx
	mov [edi], ecx
	jmp finish

not_found:     ; daca nu se gaseste needle, se intoarce lungimea haystack-ului + 1
	mov ecx, [haystack_len]     ; variabila haystack_len contine de fapt haystack_len - needle_len
	add ecx, [needle_len]
	inc ecx
	mov [edi], ecx

finish:

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
