IDENTIFICATION DIVISION.
PROGRAM-ID.  ShortestProgram.

DATA DIVISION.

WORKING-STORAGE SECTION.
01 CHR PIC X.
01 ASC PIC 99 COMP-X REDEFINES CHR.

PROCEDURE DIVISION.
000-MAIN.

MOVE "X" TO CHR.
DISPLAY "ASCII VALUE OF X:".
DISPLAY ASC.

MOVE 89 TO ASC.
DISPLAY "CHAR FOR ASCII 89:".
DISPLAY CHR.

STOP RUN. 