;
;   Simple MessageBox Created by Ichimaki kasura
;
;   To compile, run this command
;       nasm -f win64 MBox.asm && gcc -o MBox MBox.obj && ./MBox
;
;bits 64
global  main

extern  MessageBoxA

SHADOW_ALLOC    equ     40

section .data
    Title       db      "A simple Message Box", 0
    Caption     db      "Hello there,", 10, "Please press ok to close", 10, 10, "Thank you!", 0

section .text
    main:
        sub     rsp,    SHADOW_ALLOC    ; Allocate

        mov     rcx,    0               ; hwnd | window attached to?
        mov     rdx,    Caption         ; Text Message
        mov     r8 ,    Title           ; Window Title
        mov     r9 ,    20h             ; 0x00000020 hex value for "MB_ICONQUESTION"
        or      r9 ,    0h              ; 0x00000000 hex value for "MB_OK", OK button
      ; or      r9 ,    0h              ; This defaults the focus to OK button [optional]
        call    MessageBoxA             ; Executes the MessageBox
        
        ; MessageBox return value will be placed on RAX register

        add     rsp,    SHADOW_ALLOC    ; De-Allocate

        mov     rax,    0               ; exit code
        ret                             ; closes and returns the exit code