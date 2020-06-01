ORIGIN 4x0000

SEGMENT CodeSegment:
	LEA	R0, VALUE2
	NOP
	NOP
	NOP
	NOP
	NOP

	LDB	R1, R0, 0
	LDB	R2, R0, -1
	LDB	R3, R0, 2
	LDB	R4, R0, 3
	LDB	R5, R0, 4
	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	; R1 should contain 4x0078 here
	; R2 should contain 4x0012 here
	; R3 should contain 4x00CD here
	; R4 should contain 4x00AB here
	; R5 should contain 4x0022 here

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
VALUE1:	DATA2	4x1234
VALUE2: DATA2	4x5678
VALUE3:	DATA2	4xABCD
VALUE4:	DATA2	4x1122

