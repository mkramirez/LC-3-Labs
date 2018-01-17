; Class:CSE 313 Machine Organization Lab
;Section: 01
;Instructor Taline Georgiou
;Term: Winter 2018
;Name : Matthew Ramirez
;Lab#1: ALU Operations
;Description: The storing of variables into memory addresses and
; calling them for Bitwise functions such as ADD, AND, NOT, etc.

.ORIG x3100
X .FILL 10
Y .FILL 20
BASE .FILL x3100

LD R0, X
LD R1, Y
LD R2, BASE

ADD R3, R1, R0
STR R3, R2, #2

AND R3, R1, R0
STR R3, R2, #3

NOT R0, R0
NOT R1, R1
AND R3, R1, R0
NOT R3, R3
STR R3, R2, #4

LD R0, X
LD R1, Y

NOT R3, R0
STR R3, R2, #5
NOT R3, R1
STR R3, R2, #6

ADD R3, R0, #3
STR R3, R2, #7
ADD R3, R1, #-3
STR R3, R2, #8

HALT

.END