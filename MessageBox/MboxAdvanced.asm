;
;   MessageBox Created by Ichimaki kasura
;
;   To compile, run this command
;       nasm -f win64 MBoxAdvanced.asm && gcc -o MBoxAdvanced MBoxAdvanced.obj && ./MBoxAdvanced
;
;bits 64
default rel
global  main

extern  MessageBoxA
extern  ExitProcess
extern  printf
extern  ShowWindow
extern  GetModuleHandleA

SHADOW_ALLOC    equ     32
NULL            equ     0

section .bss
    hInstance   resq    1
    returnValue resq    1
    selectedMsg resq    10

section .data
    MainTitle   db      "A simple Message Box", 0
    ResultTitle db      "Results", 0
    Caption     db      "Hello!", 10, 10, "Press any buttons available and will return a message", 10, "of what button you've pressed", 10, 0
    msg1        db      "You've pressed the OK button!", 0
    msg1Len     equ     $-msg1
    msg2        db      "You've pressed the NO button!", 0
    msg2Len     equ     $-msg2
    msg3        db      "You've pressed the CANCEL or CLOSE button!", 0
    msg3Len     equ     $-msg3
    fcken       db      "I hate this console popping out", 10, 0

section .text
    main:
        mov     qword [returnValue],    NULL

        sub     rsp,    8

        lea     rcx,    [fcken]
        call    printf

        sub     rsp,    SHADOW_ALLOC

        xor     rcx,    rcx
        call    GetModuleHandleA
        mov     qword [hInstance],      rax

        mov     rcx,    [hInstance]
        mov     rdx,    0

        mov     rcx,    NULL
        lea     rdx,    [Caption]
        lea     r8 ,    [MainTitle]
        mov     r9 ,    30h|3h
        call    MessageBoxA

        cmp     rax,    6   ; ok
        je      .PRESSED_OK
        cmp     rax,    7   ; no
        je      .PRESSED_NO
        jne     .PRESSED_CLOSE

    .PRESSED_OK:
        lea     rsi,    [msg1]
        lea     rdi,    [selectedMsg]
        mov     rcx,    msg1Len
        rep     movsq
        jmp     .RESULT

    .PRESSED_NO:
        lea     rsi,    [msg2]
        lea     rdi,    [selectedMsg]
        mov     rcx,    msg2Len
        rep     movsq
        jmp     .RESULT
        
    .PRESSED_CLOSE:
        lea     rsi,    [msg3]
        lea     rdi,    [selectedMsg]
        mov     rcx,    msg3Len
        rep     movsq
        jmp     .RESULT

    .RESULT:
        mov     rcx,    NULL
        lea     rdx,    [selectedMsg]
        lea     r8 ,    [ResultTitle]
        mov     r9 ,    40h|0h
        call    MessageBoxA

        add     rsp,    SHADOW_ALLOC
    

        jmp     EXIT
        
EXIT:
    xor     rcx,    rcx
    call    ExitProcess