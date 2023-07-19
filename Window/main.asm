%include    'bin/extern.asm'
%include    'bin/constants.asm'
%include    'bin/extern.asm'
%include    'bin/define.asm'
%include    'bin/bss.asm'
%include    'bin/data.asm'

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