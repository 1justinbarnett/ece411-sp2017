Origin 4x0000

SEGMENT  CodeSegment:
   LEA  R0, VALUE
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP

   ADD	R1, R1, 5
   STR	R1, R0, 0
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   LDR	R0, R0, 0
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP

HALT:
   BRnzp HALT
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP

SEGMENT Data:
VALUE:	DATA2	4x0000

