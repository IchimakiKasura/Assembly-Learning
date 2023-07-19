%include        'srt.inc'

global  main


section .bss
    num             resb    1

section .data
    callingTest     db      "Calling Test Func",10,0
    TestCall        db      "Test has called",10,0
    TestCalled      db      "Test call ended",10,0
    teststring      db      "test %d",10,0
    testnum         dq      1234567890

section .text
    main:
        push    rbp
        mov     rbp,    rsp
        sub     rsp,    SHADOW_ALLOCATE
        
        lea     rcx,    [callingTest]   ; outputs: "Calling Test Func"
        call    printf

        lea     rcx,    [TestCall]      ; outputs: "Test has Called"
        call    FunctionCallTest
        call    printf

        lea     rcx,    [TestCalled]    ; outputs: "Test Call ended"
        call    printf

        call    exit

    FunctionCallTest:
        push    rbp
        sub     rsp,    SHADOW_ALLOCATE
        call    printf
        add     rsp,    SHADOW_ALLOCATE
        pop     rbp
        mov     rax,    0
        ret