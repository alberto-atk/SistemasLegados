       IDENTIFICATION DIVISION.
       PROGRAM-ID. WRITEMOVSFILE.
       *> Programa para crear el fichero MOVS.DAT si el programa CAJERO 
       *> no lo crea de forma automática
       *>
       *> Versiones
       *> Versión 1.0 - Escritura de los datos en el fichero de forma 
       *> directa
       *>
       *> Radu Constantin Robu y Alberto Pérez Blasco
       
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
                  PERFORM WRITE-MOVS-FILE.
                  STOP RUN.
                  
       *> Crea el fichero de movimientos para el programa cajero.
              WRITE-MOVS-FILE.
                  OPEN OUTPUT MOVSFILE.
                  CLOSE MOVSFILE.