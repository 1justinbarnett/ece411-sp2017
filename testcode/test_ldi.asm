ORIGIN 4x0000

SEGMENT CodeSegment:
	LEA	R1, VALUE1
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	LDI	R0, R1, 1
	; R0 should contain the value 4x600D

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
VALUE1:	DATA2	VALUE2
VALUE2: DATA2	VALUE3
VALUE3: DATA2	4x600D

