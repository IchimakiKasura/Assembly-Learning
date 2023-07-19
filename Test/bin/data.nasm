
section .data
        linebreak       db      10, 0
        waiting         db      `please wait 5 seconds\n`, 0
        message1        db      "Hello, What is your name: ", 0
        message2        db      "Such a nice name! Hello %s", 10, 0
        message3        db      "congrats for waiting, you earned nothing!", 10, 0
        format          db      "%s", 0
        mystring        times   1024 db 0
        fmt             db      "%d", 10, 0
        count           db      "counted number: %s", 10, 0