ORIGIN 4x0000

SEGMENT CodeSegment:
	AND	R0, R0, 0
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	ADD	R0, R0, 1
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

	LSHF	R0, R0, 2
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	; R0 should contain 4

	RSHFL	R0, R0, 1
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	; R0 should contain 2

	RSHFA	R0, R0, 1
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	; R0 should contain 1

	LEA	R1, VALUE1
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	LDR	R0, R1, 0
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	; R0 should contain 4xFFF0

	RSHFA	R0, R0, 4
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	; R0 should contain 4xFFFF

ENDLOOP:
	BRnzp	ENDLOOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

SEGMENT
DATA:
VALUE1:	DATA2	4xFFF0
