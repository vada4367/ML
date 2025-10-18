section .rodata
    fmt_in  db "%d %d", 0          ; 0  - '\0' in c abi
    fmt_out db "Result: %d", 10, 0 ; 10 - '\n' in ascii

section .text
    global main
    extern printf, scanf

;
; Some basic stuff:
; 
; CMD dest, source
; 
; rsp           - stack
; rbp           - our stack ptr
; 
; rdi, rsi, rdx - c fn args
; eax           - c fn result (32bit)
;

add:
    mov eax, edi
    add eax, esi
    ret

main:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    lea rdi, [rel fmt_in]
    lea rsi, [rbp-4]
    lea rdx, [rbp-8]
    xor eax, eax
    call scanf

    mov edi, DWORD [rbp-4] ; DWORD - 32bit (like cast void* to u32*)
    mov esi, DWORD [rbp-8]
    call add

    lea rdi, [rel fmt_out]
    mov esi, eax
    xor eax, eax
    call printf

    xor eax, eax
    leave
    ret

section .note.GNU-stack

