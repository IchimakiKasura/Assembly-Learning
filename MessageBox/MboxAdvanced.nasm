;
;   MessageBox Created by Ichimaki kasura
;
;   To compile, run this command
;       nasm -f win64 MBoxAdvanced.nasm && gcc -o MBoxAdvanced MBoxAdvanced.obj && ./MBoxAdvanced
;
;bits 64
default rel
global  main
extern  MessageBoxA
extern  printf

SHADOW_ALLOC    equ     32
NULL            equ     0

section .bss
    hInstance   resq    1
    returnValue resq    1
    selectedMsg resq    1

section .data
    MainTitle   db      "A simple Message Box", 0
    ResultTitle db      "Results", 0
    Caption     db      "Hello!", 10, 10, "Press any buttons available and will return a message", 10, "of what button you've pressed", 10, 0
    msg1        db      "You've pressed the OK button!", 0
    msg2        db      "You've pressed the NO button!", 0
    msg3        db      "You've pressed the CANCEL or CLOSE button!", 0
    fcken       db      "I hate this console popping out", 10, 0
    
    msg1Len     equ     $-msg1
    msg2Len     equ     $-msg2
    msg3Len     equ     $-msg3

section .text
    main:
        mov     qword [returnValue],    NULL

        push    rbp
        mov     rbp,    rsp
        sub     rsp,    SHADOW_ALLOC

        lea     rcx,    [fcken]
        call    printf

        mov     rcx,    NULL
        lea     rdx,    [Caption]
        lea     r8 ,    [MainTitle]
        mov     r9 ,    30h|3h|200h|NULL|20000h
        call    MessageBoxA
        call    PRESSED

        mov     rcx,    NULL
        lea     rdx,    [selectedMsg]
        lea     r8 ,    [ResultTitle]
        mov     r9 ,    40h|0h|200h|NULL|20000h
        call    MessageBoxA

        call    EXIT

    PRESSED:
        cmp     rax,    6
        je      IS_OK
        cmp     rax,    7
        je      IS_NO
        jne      IS_CLOSE

    IS_OK:
        lea     rsi,    [msg1]
        lea     rdi,    [selectedMsg]
        lea     rcx,    [abs msg1Len]
        rep     movsq
        ret

    IS_NO:
        lea     rsi,    [msg2]
        lea     rdi,    [selectedMsg]
        lea     rcx,    [abs msg2Len]
        rep     movsq
        ret
        
    IS_CLOSE:
        lea     rsi,    [msg3]
        lea     rdi,    [selectedMsg]
        lea     rcx,    [abs msg3Len]
        rep     movsq
        ret

    EXIT:
        xor     rax,    rax
        leave
        ret