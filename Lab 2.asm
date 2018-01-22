
.ORIG x3120
X .FILL 10
Y .FILL 20
BASE .FILL x3120


LD R0, X
LD R1, Y
AND R7, R7, #0
LD R2, BASE

NOT R3, R1
ADD R3, R3, #1
ADD R4, R0, R3
STR R4, R2, #2

ADD R3, R0, #0
BRzp ZP
NOT R3, R3
ADD R3, R3, #1
ZP
STR R3, R2, #3

ADD R4, R1, #0
BRzp XP
NOT R4, R4
ADD R4, R4, #1
XP
STR R4, R2, #4

NOT R5, R4
ADD R6, R4, R3

BRz Equals
BRn GreaterR4
BRp GreaterR3

Equals BRnzp End

GreaterR4 ADD R7, R7, #-1
BRnzp End
GreaterR3 ADD R7, R7, #1
BRnzp End

HALT

.END