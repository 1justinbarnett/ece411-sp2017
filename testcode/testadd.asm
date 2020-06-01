Origin 4x0000

SEGMENT  CodeSegment:
   ADD	R0, R0, 1;  R0 <- 1;
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

