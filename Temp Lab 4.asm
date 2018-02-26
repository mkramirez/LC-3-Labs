;Class:CSE 313 Machine organization Lab
;Section: 01
;Instructor: Taline Georgiou
;Term: Winter 2018
;Name: Matthew Ramirez, Ivette Campana
;Lab #4: Fibonacci Numbers
;Description: 
;-------------------------------------------------------------------------------
        .ORIG x3000

        LEA R1, xFF
        LDR R1, R1, #0

        ADD R3, R3, #1
        ADD R1, R1, #-2
        BRnz CHECK

        ADD R1, R1, #2

FIBSEQ  NOT R6, R1
        ADD R6, R6, #1
        ADD R6, R6, R5
        BRz CHECK

        ADD R4, R2, R3
        ADD R5, R5, #1
        ADD R2, R3, #0
        ADD R3, R4, #0
        BR FIBSEQ

CHECK   STI R2, Fn

L_FIB   ADD R4, R2, R3
        BRn GOT_NUM

        ADD R2, R3, #0
        ADD R3, R4, #0
        ADD R5, R5, #1
        BR L_FIB

        ADD R5, R5, #1
GOT_NUM STI R5, N
        STI R3, FN

HALT

Fn      .FILL x3101
N       .FILL x3102
FN      .FILL x3103

.END
