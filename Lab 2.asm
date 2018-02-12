;Class:CSE 313 Machine organization Lab
;Section: 01
;Instructor: Taline Georgiou
;Term: Winter 2018
;Name: Matthew Ramirez, Ivette Campana
;Lab #2: Arithmetic Functions
;Description: The basic use of using the twos complment to negate a number and..
;..to use that to subtract two numbers. As well as using the twos complement....
;..to find the absolute value of an number with the use of branch checks which..
;..check if the number is already zero or positive. At the end we simply use....
;..another check to see if X or Y was greater then once found by using some.....
;..new branches to check and write 0/1/2 in the register to tell us the answer..
;-------------------------------------------------------------------------------

        .ORIG x3120

        LD R0, X
        LD R1, Y
        LD R2, BASE

	STR R0, R2, #0 ; Stores X and Y in..
	STR R1, R2, #1 ; ..x3120/21 respectively

        NOT R3, R1     ; Twos Complement
        ADD R3, R3, #1 ; ^
        ADD R4, R0, R3 ; Stores R0(X) + R3(-Y) into R4
        STR R4, R2, #2 ; Stores R4 at x3122

        ADD R3, R0, #0 ; Store original X into R3
        BRzp ZP        ; Branch if result is zero or positive
        NOT R3, R3     ; Otherwise execute the following
        ADD R3, R3, #1 ; Twos complement to force positive
        ZP             ; Branch end
        STR R3, R2, #3 ; Store R3 at x3123

        ADD R4, R1, #0 ; Store original Y into R4
        BRzp XP        ; Branch if result is zero or positive
        NOT R4, R4     ; Otherwise execute following
        ADD R4, R4, #1 ; Twos complement to force positive
        XP             ; Branch end
        STR R4, R2, #4 ; Store R4 at x3124

        NOT R5, R4     ; Twos complement for R4(|Y|)
        ADD R5, R5, #1 ; ^
        ADD R6, R3, R5 ; Adds R3(|X|) + R4(|Y|) result at R6
        BRz STOP       ; Branch if zero
        BRp GREATER    ; Branch if positive
        BRn LESS       ; Branch if negative

GREATER ADD R7, R7, #1 ; If positive, add 1 to R7
        BRp STOP       ; Stop if condition met otherwise go to LESS

LESS    ADD R7, R7, #2 ; If negative, add 2 to R7 then stop, otherwise skip
STOP    STR R7, R2, #5 ; If zero, skip to this line and add the zero already..
                       ; ..in R7 to x3125
HALT

X       .FILL 12
Y       .FILL 12
BASE    .FILL x3120

.END
