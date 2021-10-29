IDENTIFICATION DIVISION.
PROGRAM-ID. WRITEMOVSFILE.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
       SELECT MOVSFILE ASSIGN TO "MOVS.DAT"
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS FSM.

DATA DIVISION.
FILE SECTION.
FD MOVSFILE.
01 REG-MOVIMIENTOS.
       02 MOV-ID               PIC X(20).
       02 MOV-CONCEPTO         PIC X(40).
       02 MOV-CANTIDAD         PIC --------9.99.
       02 MOV-CUENTA-DESTINO   PIC X(24).
       02 MOV-SALDO            PIC 9(9)V99.
       02 MOV-FECHA.            
           03 DDM              PIC 99.
           03 FILLER           PIC X.
           03 MMM              PIC 99.
           03 FILLER           PIC X.
           03 AAM              PIC 9999.
       02 MOV-HORA.
           03 HH               PIC 99.
           03 FILLER           PIC X.
           03 MM               PIC 99.
           03 FILLER           PIC X.
           03 SS               PIC 99.

WORKING-STORAGE SECTION.
       01 FSM      PIC X(2).

PROCEDURE DIVISION.
       INICIO.
           OPEN OUTPUT MOVSFILE.
           CLOSE MOVSFILE.
           STOP RUN.