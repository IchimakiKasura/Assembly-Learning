;
;   Simple MessageBox Created by Ichimaki kasura
;
;   To compile, run this command
;       nasm -f win64 MBox.asm && gcc -o MBox MBox.obj && ./MBox
;
;bits 64
global  main

extern  MessageBoxA
extern  ExitProcess

SHADOW_ALLOC    equ     32
null            equ     0

section .data
    Title       db      "A simple Message Box", 0
    Caption     db      "Hello there,", 10, "Please press ok to close", 10, 10, "Thank you!", 0

section .text
    main:
        push    rbp
        mov     rbp,    rsp
        sub     rsp,    SHADOW_ALLOC    ; Allocate

        mov     rcx,    null            ; hwnd | window attached to?
        lea     rdx,    [rel Caption]   ; Text Message
        lea     r8 ,    [rel Title]     ; Window Title
        mov     r9 ,    20h|0h          ; 20h value for "MB_ICONQUESTION"
                                        ; 0h  value for "MB_OK", OK button
                                        ; see more here:
                                        ; https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-messagebox

        call    MessageBoxA             ; Executes the MessageBox
        
        ; MessageBox return value will be placed on RAX register

        xor     rcx,    rcx             ; exit code
        call    ExitProcess             ; closes and returns the exit code