%include        'bin/data.asm'
%include        'bin/equ.asm'
%include        'bin/extern.asm'
%include        'bin/vars.asm'

section .text
    global  main

    main:
        sub     rsp,    SHADOW_ALLOC

        ; first name
        mov     rcx,    name1
        call    printf
        mov     rcx,    frmt
        mov     rdx,    FirstName
        call    scanf
        
        ; last name
        mov     rcx,    name2
        call    printf
        mov     rcx,    frmt
        mov     rdx,    LastName
        call    scanf

        ; DATE
        mov     rcx,    date1
        call    printf
        mov     rcx,    frmt
        mov     rdx,    DateofBirth
        call    scanf

        ; MONTH
        mov     rcx,    date2
        call    printf
        mov     rcx,    frmt
        mov     rdx,    MonthofBirth
        call    scanf

        ; YEAR
        mov     rcx,    date3
        call    printf
        mov     rcx,    frmt
        mov     rdx,    YearofBirth
        call    scanf

        ; output whole name
        mov     rcx,    str1
        mov     rdx,    FirstName
        call    printf

        ; output whole birthday
        mov     rcx,    str2
        mov     rdx,    MonthofBirth
        mov     r8 ,    DateofBirth
        mov     r9 ,    YearofBirth
        call    printf

        ; for fun?
        mov     rcx, 10
        mov     rax, '0'

        l1:
            mov     [rel num], rax
            push    rcx

            push    rax
            push    rdx
            push    rdi
            push    rsi
            push    r8

            mov     rcx, nums
            mov     rdx, num
            call    printf

            pop     rax
            pop     rdx
            pop     rdi
            pop     rsi
            pop     r8

            mov     rax, [rel num]
            inc     rax
            pop     rcx
            loop    l1

        ; end code
        add     rsp,    SHADOW_ALLOC  
        jmp exit

    exit:
        ; exit code 0 = success
        mov     rax, 0
        call    ExitProcess