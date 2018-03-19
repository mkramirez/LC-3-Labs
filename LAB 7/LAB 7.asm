;Class:CSE 313 Machine organization Lab
;Section: 01
;Instructor: Taline Georgiou
;Term: Winter 2018
;Name: Matthew Ramirez, Ivette Campana
;Lab #7: Compute Day of the week
;Description: The program simply takes the 3 sections of a date, being the day,
;the month, and the year. We compute M which gives us the Month by calculating
;if its greater or equal to 2, we add 10. Otherwise we subtract 2, as the month
;is recognized different, March = 1, April 2, etc etc. We then find D which is
;simply the last 2 digits of the year which we find using a mod 100. Then for C
;we use a division of the year, to find the first 2 digits of the year. After
;with the use of the Zellar formula, plug in all of the numbers to find the mod
;7 then correlate that number to the correct day and print it out.
;-------------------------------------------------------------------------------
.ORIG x3000

	LDI R3, MONTH	; m
	LDI R4, DAY	; q (day)
	LDI R5, YEAR	; k

	JSR COMPUTE_M	; Calculate M
	JSR COMPUTE_D	; Calculate D
	JSR COMPUTE_C	; Calculate C

	ADD R6, R4, #0	; Adding q (Day)
	LDI R2, M
	ADD R2, R2, #1 	; (M + 1)
	AND R1, R1, #0
	ADD R1, R1, #13
	JSR MULT	; 13 * (M + 1) part of Zeller's Formula

	LDI R1, X_MUL_Y
	AND R2, R2, #0
	ADD R2, R2, #5
	JSR DIV		; (13 * (M + 1)) / 5 next part of Zeller's Formula
	LDI R1, X_DIV_Y
	ADD R6, R6, R1	; q + (13 * (M + 1)) / 5

	LDI R1, D
	ADD R6, R6, R1	; q + (13 * (M + 1)) / 5 + D

	AND R2, R2, #0
	ADD R2, R2, #4
	JSR DIV		; D / 4
	LDI R1, X_DIV_Y
	ADD R6, R6, R1	; q + ((13 * (M + 1)) / 5) + D + (D / 4) Zeller

	LDI R1, C
	AND R2, R2, #0
	ADD R2, R2, #4
	JSR DIV		; C / 4
	LDI R1, X_DIV_Y
	ADD R6, R6, R1	; q + ((13 * (M + 1)) / 5) + D + (D / 4) + (C / 4)

	LDI R1, C
	AND R2, R2, #0
	ADD R2, R2, #2
	JSR MULT	; 2 * C
	LDI R1, X_MUL_Y
	NOT R1, R1
	ADD R1, R1, #1
	ADD R6, R6, R1 	; q + ((13 * (M + 1)) / 5) + D + (D / 4) + (C / 4) - (2 * C)

	ADD R1, R6, #0
	AND R2, R2, #0
	ADD R2, R2, #7
	JSR MOD		; MOD 7

	LDI R1, X_MOD_Y
	STI R1, DAY_OF_THE_WEEK
	LD R0, DAYS_OF_THE_WEEK_LIST
	AND R2, R2, #0
	ADD R2, R2, #10
	JSR MULT
	LDI R1, X_MUL_Y
	ADD R0, R0, R1
	PUTS

HALT


;--------------------------- VARIABLES USED IN PROG ----------------------------
MONTH	.FILL x31F0
DAY	.FILL x31F1
YEAR	.FILL x31F2
DAY_OF_THE_WEEK .FILL x31F3
DAYS_OF_THE_WEEK_LIST .FILL x3600
M	.FILL x3100
D	.FILL x3101
C	.FILL x3102
X_MUL_Y .FILL x3103
X_DIV_Y .FILL x3104
X_MOD_Y .FILL x3105
N_100	.FILL #100
;--------------------------- Computer the M Value ------------------------------
; if [ k <= 2 ] -> k + 12
; else -> k
COMPUTE_M
  	STI R1, SAVE_R1
	STI R2, SAVE_R2
	STI R3, SAVE_R3

	LDI R1, MONTH
	ADD R3, R1, #0
	AND R2, R2, #0
	ADD R2, R2, #-2
	ADD R1, R1, R2
	BRp MONTH_GT_2
	ADD R3, R3, #10
	BR #2
MONTH_GT_2
	ADD R3, R3, #0
	STI R3, M
	LDI R1, SAVE_R1
	LDI R2, SAVE_R2
	LDI R3, SAVE_R3
	RET
;--------------------------- Computer the D Value ------------------------------
; Last 2 digits of the year
COMPUTE_D
	STI R1, SAVE_R1
	STI R2, SAVE_R2
	STI R3, SAVE_R3
	STI R7, SAVE_R7

	LDI R1, YEAR
	LD  R2, N_100
	JSR MOD
	LDI R3, X_MOD_Y
	STI R3, D
	LDI R1, SAVE_R1
	LDI R2, SAVE_R2
	LDI R3, SAVE_R3
	LDI R7, SAVE_R7
	RET
;--------------------------- Computer the C Value ------------------------------
; First two digits of the year
COMPUTE_C
	STI R1, SAVE_R1
	STI R2, SAVE_R2
	STI R3, SAVE_R3
	STI R7, SAVE_R7

	LDI R1, YEAR
	LD  R2, N_100
	JSR DIV
	LDI R3, X_DIV_Y
	STI R3, C
	LDI R1, SAVE_R1
	LDI R2, SAVE_R2
	LDI R3, SAVE_R3
	LDI R7, SAVE_R7
	RET
MULT
	STI R1, SAVE_R1
	STI R2, SAVE_R2
	STI R3, SAVE_R3
	STI R4, SAVE_R4
	AND R4, R4, #0
	ADD R1, R1, #0
	BRn X_NEG
	BR #3
X_NEG
	NOT R1, R1
	ADD R1, R1, #1
	NOT R4, R4
	ADD R2, R2, #0
	BRn Y_NEG
	BR #3
Y_NEG
	NOT R2, R2
	ADD R2, R2, #1
	NOT R4, R4
	AND R3, R3, #0
MULT_REPEAT
	ADD R3, R3, R1
	ADD R2, R2, #-1
	BRnp MULT_REPEAT

	ADD R4, R4, #0
	BRn CHANGE_SIGN
	BR #2
CHANGE_SIGN
	NOT R3, R3
	ADD R3, R3, #1
	STI R3, X_MUL_Y
	LDI R1, SAVE_R1
	LDI R2, SAVE_R2
	LDI R3, SAVE_R3
	LDI R4, SAVE_R4
	RET

DIV
	STI R1, SAVE_R1
	STI R2, SAVE_R2
	STI R3, SAVE_R3
	STI R4, SAVE_R4
	STI R5, SAVE_R5

	AND R3, R3, #0
	AND R5, R5, #0
	ADD R1, R1, #0
	BRn X_NEG_2
	BR #3
X_NEG_2
	NOT R1, R1
	ADD R1, R1, #1
	NOT R5, R5
	ADD R2, R2, #0
	BRn Y_NEG_2
	BR #3
Y_NEG_2
	NOT R2, R2
	ADD R2, R2, #1
	NOT R5, R5

	NOT R4, R2
	ADD R4, R4, #1
DIV_REPEAT
	ADD R1, R1, R4
	BRn #2
	ADD R3, R3, #1
	BR DIV_REPEAT
	ADD R5, R5, #0
	BRn CHANGE_SIGN_2
	BR #2
CHANGE_SIGN_2
	NOT R3, R3
	ADD R3, R3, #1
	STI R3, X_DIV_Y
	LDI R1, SAVE_R1
	LDI R2, SAVE_R2
	LDI R3, SAVE_R3
	LDI R4, SAVE_R4
	LDI R5, SAVE_R5
	RET

MOD
	STI R1, SAVE_R1
	STI R2, SAVE_R2
	STI R3, SAVE_R3
	STI R4, SAVE_R4
	STI R5, SAVE_R5

	AND R5, R5, #0
	ADD R1, R1, #0
	BRn X_NEG_3
	BR #3
X_NEG_3
	NOT R1, R1
	ADD R1, R1, #1
	NOT R5, R5
	ADD R2, R2, #0
	BRn Y_NEG_3
	BR #3
Y_NEG_3
	NOT R2, R2
	ADD R2, R2, #1
	NOT R5, R5
	NOT R3, R2
	ADD R3, R3, #1
	ADD R4, R1, #0
MOD_REPEAT
	ADD R1, R1, R3
	BRnz #2
	ADD R4, R4, R3
	BR MOD_REPEAT
	STI R4, X_MOD_Y
	LDI R1, SAVE_R1
	LDI R2, SAVE_R2
	LDI R3, SAVE_R3
	LDI R4, SAVE_R4
	LDI R5, SAVE_R5
	RET

SAVE_R1 .FILL x3500
SAVE_R2 .FILL x3501
SAVE_R3 .FILL x3502
SAVE_R4 .FILL x3503
SAVE_R5 .FILL x3504
SAVE_R7 .FILL x3505

.END

































.END
