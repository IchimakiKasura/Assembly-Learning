%include                'bin/define.nasm'
%include                'bin/extern.nasm'
%include                'bin/data.nasm'
%include                'bin/bss.nasm'

section .code

        global  main
        main:
                sub     rsp, SHADOW_ALLOC       ; reserve shadow space what

                ; start code

                mov     rcx, message1
                call    printf

                mov     rcx, format
                mov     rdx, mystring
                call    scanf

                mov     rcx, message2
                mov     rdx, mystring
                call    printf

                mov     rcx, linebreak
                call    printf
                mov     rcx, 5                  ; wait 5 seconds
                call    sleep
                mov     rcx, message3
                call    printf
                mov     rcx, 2                  ; wait 2 seconds
                call    sleep

                mov     rcx, 10
                mov     rax, '0'

                l1:
                        mov     [rel num], rax
                        push    rcx
                        
                        ; This is so pain that i need to do this
                        ; whenever I need to write on printf
                        push    rax
                        push    rdx
                        push    rsi
                        push    r8
                        push    r11

                        mov     rcx, count
                        mov     rdx, num
                        call    printf

                        pop     r11
                        pop     r8
                        pop     rsi
                        pop     rdx
                        pop     rax

                        mov     rax, [rel num]
                        inc     rax
                        pop     rcx
                        loop l1

                ; end code

                add     rsp, SHADOW_ALLOC       ; remove shadow space what
                
        exit:
                
                ;exit code
                mov     rax, EXIT_CODE
                ret

