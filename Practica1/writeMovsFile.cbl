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
       02 MOV-CUENTA-DESTINO   PIC X(20).
       02 MOV-SALDO            PIC 9(9)V99.
       02 MOV-FECHA.            
           03 DDM              PIC 99.
           03 FILLER           PIC X.
           03 MMM              PIC 99.
           03 FILLER           PIC X.
           03 AAM              PIC 99.
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
           PERFORM WRITE-MOVS-FILE.
           STOP RUN.

       WRITE-MOVS-FILE.
           OPEN OUTPUT MOVSFILE.
               MOVE 11111222223333344444 TO MOV-ID.
               MOVE "Me gusta el dinero." TO MOV-CONCEPTO.
               MOVE 30000.00 TO MOV-CANTIDAD.
               MOVE "CUENTADEALBERTO" TO MOV-CUENTA-DESTINO.
               MOVE "60000.00" TO MOV-SALDO.
               MOVE "25-10-2021" TO MOV-FECHA.
               MOVE "16:24:00" TO MOV-HORA.
               DISPLAY REG-MOVIMIENTOS.
               WRITE REG-MOVIMIENTOS.
           CLOSE MOVSFILE.
