;Class:CSE 313 Machine organization Lab
;Section: 01
;Instructor: Taline Georgiou
;Term: Winter 2018
;Name: Matthew Ramirez, Ivette Campana
;Lab #7: Days of the Week
;Description:
;-------------------------------------------------------------------------------

        .ORIG x3000
STEP1   LDI R3, M
        LDI R4, Y
        ADD R0, R0, R3
        JSR MONTH
        ST R0, SAVEREG0

STEP2   AND R0, R0, #0
        ADD R0, R0, R4
        JSR SEP

STEP3   LD R0, SAVEREG0
        ADD R0, R0, #1
        AND R1, R1, #0
        ADD R1, R1, #13
        AND R2, R2, #0
        JSR MULT

STEP4   AND R0, R0, #0
        AND R1, R1, #0
        ADD R0, R0, R2
        DD R1, R1, #5
	NOT R1, R1
	ADD R1, R1, #1
	AND R2, R2, #0
	JSR DIVID

STEP5   LDI R0, K
        ADD R6, R0, R2

STEP6   LD R0, SAVEREG2
        ADD R6, R6, R0

STEP7   AND R1, R1, #0
        ADD R1, R1, #4
        AND R2, R2, #0
        NOT R1, R1
        ADD R1, R1, #1
        JSR DIVID

STEP8   ADD R6, R6, R2
        LD R0, SAVEREG1
        AND R1, R1, #0
        ADD R1, R1, #2
        AND R2, R2, #0
        JSR MULT
        NOT R2, R2
        ADD R2, R2, #1
        ADD R6, R6, R2

STEP9   AND R1, R1, #0
	ADD R1, R1, #4
	NOT R1, R1
	ADD R1, R1, #1
	AND R2, R2, #0
	JSR DIVID
	ADD R6, R6, R2
	AND R0, R0, #0
	AND R1, R1, #0
	AND R2, R2, #0
	ADD R0, R0, R6
	ADD R1, R1, #7
	NOT R1, R1
	ADD R1, R1, #1
	JSR DIVID
	ADD R3, R0, #0
	STI R3, FINAL
	LEA R0, DAYS

DISLOOP ADD R3, R3, #0
	BRz DISPLAY
	ADD R0, R0, #10
	ADD R3, R3, #-1
	BR DISLOOP

DISPLAY PUTS
	HALT

MONTH	ADD R0, R0, #-2
	BRnz MONTH1
	BRp MONTH2

MONTH1	ADD R0, R0, #14
	ADD R4, R4, #-1
	RET

MONTH2	ADD R0, R0, #2
	RET

SEP	AND R3, R3, x0
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #10

	NOT R3, R3
	ADD R3, R3, #1
	AND R2, R2, #0
	AND R1, R1, #0
	BR SEPLOOP

SEPLOOP	ADD R0, R0, R3
	BRnz SEPEND
	ADD R1, R1, #1
	BR SEPLOOP

SEPEND	NOT R3, R3
	ADD R3, R3, #1
	ADD R0, R0, R3
	ADD R2, R0, R3
	RET

MULT	ADD R2, R2, R0
	ADD R1, R1, #-1
	BRz RETURN
	BR MULT

DIVID	ADD R0, R0, R1
	ADD R2, R2, #1
	AND R3, R3, #0
	ADD R3, R0, R1
	BRn RETURN
	BR DIVID

RETURN 	RET

K	.FILL x31F0
M	.FILL x31F1
Y	.FILL x31F2
FINAL	.FILL x31F3
SAVEREG0 .FILL x0
SAVEREG1 .FILL x0
SAVEREG2 .FILL x0
DAYS	.STRINGZ "Saturday  "
	.STRINGZ "Sunday    "
	.STRINGZ "Monday    "
	.STRINGZ "Tuesday   "
	.STRINGZ "Wednesday "
	.STRINGZ "Thursday  "
	.STRINGZ "Friday    "

.END
