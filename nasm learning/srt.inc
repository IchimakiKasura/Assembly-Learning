; win64 only
bits 64

; relative addressing mode
default rel

%include    'srt/preExtern.inc'
%include    'srt/constants.inc'
%include    'srt/define.inc'

; constant function? idfk
exit:
    xor rax,    rax
    leave
    ret