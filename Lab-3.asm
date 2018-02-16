;Class:CSE 313 Machine organization Lab
;Section: 01
;Instructor: Taline Georgiou
;Term: Winter 2018
;Name: Matthew Ramirez, Ivette Campana
;Lab #3: Days of the week
;Description: Using a loop to prompt the user for a number 0-6 which outputs....
;..a the day of the week respectively. The loop will continue to repeat until...
;..the user puts in a number outside of the scope of the loop which is any......
;..number that is greater than 6.
;-------------------------------------------------------------------------------
        .ORIG x3000

        LD R6, X
        LD R1, Y

RESTART LEA R0, PROMPT
        PUTS
        GETC

        ADD R3, R0, x0
        ADD R3, R3, R1

        NOT R5, R6
        ADD R5, R5, #1
        ADD R4, R3, R5
        BRp GREATER     ;Greater than 6

GREATER BRp STOP

        LEA R0, DAYS
        ADD R3, R3, x0

LOOP    BRz DISPLAY
        ADD R0, R0, #10
        ADD R3, R3, #-1
        BR LOOP
DISPLAY PUTS
        BR RESTART

STOP
HALT

X       .FILL 6
Y       .FILL -48
PROMPT  .STRINGZ "Please enter number: "

DAYS    .STRINGZ "Sunday   "
        .STRINGZ "Monday   "
        .STRINGZ "Tuesday  "
        .STRINGZ "Wednesday"
        .STRINGZ "Thursday "
        .STRINGZ "Friday   "
        .STRINGZ "Saturday "
.END
