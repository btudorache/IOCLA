%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher
loop_letters:
	mov al, [esi + ecx - 1]		; mutarea valorii din plaintext in al     
	xor al, [edi + ecx - 1]		; xor intre valoarea din plaintext si valoarea din key
	mov [edx + ecx - 1], al		; mutarea rezultatului din xor in ciphertext
	loop loop_letters

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY