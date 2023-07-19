%include    'bin/extern.nasm'
%include    'bin/constants.nasm'
%include    'bin/extern.nasm'
%include    'bin/define.nasm'
%include    'bin/bss.nasm'
%include    'bin/data.nasm'

global  main

section .text
        main:
                push    rbp
                mov     rsp,    rbp
                sub     rsp,    SHADOW_ALLOCATION

                ; mov     rcx,    [rel string]
                ; call    puts

                jmp    EXIT

EXIT:
    xor     rax,    rax
    mov     rcx,    0
    call    ExitProcess