# Notes

If you encountered an error or problem after compiling and running these codes please note that
the `default rel` is always defined on my code examples. if you don't like putting `default rel` you can
always put `rel` keyword like `[rel string]` when doing `lea` instr.

## Moving variables

- `RSI` is always the source of the address you want to copy.
- `RDI` is the destination of the copied address from `RSI`.
- `RCX` is for the `REP` keyword on how many time it needs to repeat thus putting the source length is required.

notes:
If `default rel` is defined on the code, the `src length` should be an `abs` like `[abs srclength]`

```nasm
lea     rsi,    [src]
lea     rdi,    [dest]
lea     rcx,    [src length]
rep     movsq
```

## IF-else statement

- `cmp` will act as an `if` keyword.
- `je` means `jump if equal`, if the `cmp` is true this keyword is executed.
- `jne` means `jump if not equal`, if the `cmp` is false this keyword is executed.

notes:
If adding a calling function inside the `RCX_TRUE` or `RCX_FALSE` its required to
allocate another shadow space/stack. recommeded is 32 bytes

```nasm
extern  printf
section .text
global   main
main:
    push    rbp
    mov     rbp,    rsp
    sub     rsp,    32

    mov     rcx,    1       ; changing this other than 1 will print 2
    call    IsRCXtrue

    lea     rcx,    [frm]
    mov     rdx,    rax
    call    printf          ; should return 1

    leave
    ret

; begin if else statement
IsRCXtrue:
    cmp     rcx,    1
    je      RCX_TRUE
    jne     RCX_FALSE

RCX_TRUE:
    mov     rax,    1
    ret

RCX_FALSE:
    mov     rax,    2
    ret

section .data
    frm     db      "rcx is %d",10
```

# Arguments, Parameters
- I am using windows 64bit (`nasm -fwin64`), each OS has a different calling convention so on Windows the calling conventions are:
    - `RCX`, `RDX`, `R8`, `R9` for the first four integer or pointer arguments
    - the fifth or more arguments are passed to the stack. [more info](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention?view=msvc-170)

## C
``` C
int simpleFunction(int a, int b, int c, int d, int e, int f)
{
    // the int a to int d is passed to the rcx to r9, the int e and f are passed to the stack
    return 0;
}
```
## Asm
```nasm
mov     rcx,    1
mov     rdx,    2
mov     r8 ,    3
mov     r9 ,    4
call    simpleFunction

simpleFunction:
    mov rax, 0
    ret
```

- How do we pass the E and the F parameter?
    - E and F are passed to the stack thats where the `shadow space` needed* _(this is based on my understanding hence im writing these notes)_<br>
    To actually pass the extra arguments we will access the STACK which in calling convention its the `RSP`. [more here](https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions?view=msvc-170#register-volatility-and-preservation)<br>
    To pass arguments you need to add more Shadow Space for the other arguments to be passed or it will seg fault as there's no bytes to be allocated. Each arguments are 8 bytes.<br><br>
    ```nasm
    ; single +8*5 if you're passing 1 extra parameter and +8*6 if passing 2 extra parameter
    sub     rsp,    32+8*5
    ```
    _( again this is based on my understanding for the past few days of learning this laungage )_

    Example:
    ```nasm
    sub     RSP,    32 + 64                             ; Shadow space + 8 parameters
                                                        ; ( 32+8*8 )

    mov     ECX,    WS_EX_COMPOSITED                    ; 1st param
    lea     RDX,    [REL ClassName]                     ; 2nd param
    lea     R8,     [REL WindowName]                    ; 3rd param
    mov     R9D,    WS_OVERLAPPEDWINDOW                 ; 4th param
    mov     dword   [RSP + 4 * 8], CW_USEDEFAULT        ; 5th param
    mov     dword   [RSP + 5 * 8], CW_USEDEFAULT        ; 6th param
    mov     dword   [RSP + 6 * 8], WindowWidth          ; 7th param
    mov     dword   [RSP + 7 * 8], WindowHeight         ; 8th param
    mov     qword   [RSP + 8 * 8], NULL                 ; 9th param
    mov     qword   [RSP + 9 * 8], NULL                 ; 10th param
    mov     RAX,     qword [REL hInstance]              
    mov     qword   [RSP + 10 * 8], RAX                 ; 11th param
    mov     qword   [RSP + 11 * 8], NULL                ; 12th param
    call    CreateWindowExA                             ; call function
    ```
    (source: https://www.davidgrantham.com/nasm-basicwindow64/)

# Loops?
- still learning.