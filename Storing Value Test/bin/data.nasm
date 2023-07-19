
section .data
    frmt            db      "%s", 0

    name1           db      "First Name: ", 0
    name2           db      "Last Name: ", 0

    date1           db      "Date of Birth: ", 0
    date2           db      "Month of Birth: ", 0
    date3           db      "Year of Birth: ", 0

    str1            db      "Your name is %s", 10, 0
    str2            db      "Your birthday is %s %s, %s", 10, 0

    nums            db      "Number counted: %s", 10, 0

    Title           db      "oopsie", 0
    Caption         db      "Uh oh stinky poopoo made an errory fuck you.", 10, 10, "Get some help.", 0

    msgOK           db      "User Pressed OK", 10, 0
    msgNO           db      "User Pressed CANCEL", 10, 0