Origin 4x0000

SEGMENT  CodeSegment:
   ; wb -> ex SR1
   ADD	R0, R0, 1
   NOP
   ADD  R0, R0, 1
   AND  R1, R1, 0

   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP

   ; wb -> ex SR2
   ADD  R1, R1, 5
   NOP
   ADD  R2, R0, R1

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

