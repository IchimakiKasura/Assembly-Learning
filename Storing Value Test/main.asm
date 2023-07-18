%include        'bin/data.asm'
%include        'bin/equ.asm'
%include        'bin/extern.asm'
%include        'bin/vars.asm'

section .text
    global  main

    main:
        sub     rsp,    SHADOW_ALLOC

        mov     rcx,    0           ; hwnd
        mov     rdx,    Caption     ; Message
        mov     r8,     Title       ; Title
        mov     r9,     10h         ; MB_ERROR_ICON
        or      r9,     4h          ; MB_BUTTON
        call    MessageBoxA         ; executes

        cmp     rax,    7           ; checks if 7 (OK) or 6 (CANCEL) was pressed
        jl      YES                 ; jumps to YES if the OK Button was pressed
        jle     NO                  ; jumps to NO if the CANCEL Button was pressed

        add     rsp,    SHADOW_ALLOC
        
    L1:
        jmp exit
        ; ; first name
        ; mov     rcx,    name1
        ; call    printf
        ; mov     rcx,    frmt
        ; mov     rdx,    FirstName
        ; call    scanf
        
        ; ; last name
        ; mov     rcx,    name2
        ; call    printf
        ; mov     rcx,    frmt
        ; mov     rdx,    LastName
        ; call    scanf

        ; ; DATE
        ; mov     rcx,    date1
        ; call    printf
        ; mov     rcx,    frmt
        ; mov     rdx,    DateofBirth
        ; call    scanf

        ; ; MONTH
        ; mov     rcx,    date2
        ; call    printf
        ; mov     rcx,    frmt
        ; mov     rdx,    MonthofBirth
        ; call    scanf

        ; ; YEAR
        ; mov     rcx,    date3
        ; call    printf
        ; mov     rcx,    frmt
        ; mov     rdx,    YearofBirth
        ; call    scanf

        ; ; output whole name
        ; mov     rcx,    str1
        ; mov     rdx,    FirstName
        ; call    printf

        ; ; output whole birthday
        ; mov     rcx,    str2
        ; mov     rdx,    MonthofBirth
        ; mov     r8 ,    DateofBirth
        ; mov     r9 ,    YearofBirth
        ; call    printf

        ; ; for fun?
        ; mov     rcx, 10
        ; mov     rax, '0'

        ; l1:
        ;     mov     [rel num], rax
        ;     push    rcx

        ;     push    rax
        ;     push    rdx
        ;     push    rdi
        ;     push    rsi
        ;     push    r8

        ;     mov     rcx, nums
        ;     mov     rdx, num
        ;     call    printf

        ;     pop     rax
        ;     pop     rdx
        ;     pop     rdi
        ;     pop     rsi
        ;     pop     r8

        ;     mov     rax, [rel num]
        ;     inc     rax
        ;     pop     rcx
        ;     loop    l1

        ; end code

    YES:
        mov     rcx,    msgOK
        call    printf
        jmp     L1

    NO:
        mov     rcx,    msgNO
        call    printf
        jmp     L1

    exit:
        ; exit code 0 = success
        mov     rax, 0
        call    ExitProcess