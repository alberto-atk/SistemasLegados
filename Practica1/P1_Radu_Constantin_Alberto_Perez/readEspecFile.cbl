IDENTIFICATION DIVISION.
PROGRAM-ID.  READESPECFILE.
*> Programa para leer el fichero ESPEC.DAT
*>
*> Versiones:
*> Versión 1.0 - Lectura indexada de una entrada del fichero ESPEC.DAT
*>
*> Radu Constantin Robu y Alberto Pérez Blasco


ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
         SELECT EspecFile ASSIGN TO  "ESPEC.DAT"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS ESPEC-NUMERO
           FILE STATUS IS FSE.
DATA DIVISION.
FILE SECTION.
FD ESPECFILE.
01 REG-ESPECTACULO.
  02 ESPEC-NUMERO           PIC 99.
  02 ESPEC-NOMBRE           PIC X(20).
  02 ESPEC-PRECIO-ENTRADA   PIC 999V99.
  02 ESPEC-DESCRIPCION      PIC X(30).
  02 ESPEC-ENT-DISPONIBLES  PIC 9(3).
  02 ESPEC-FECHA.
     03 DDE                  PIC 99.
     03 FILLER              PIC X.
     03 MME                  PIC 99.
     03 FILLER              PIC X.
     03 AAE                  PIC 9999.

WORKING-STORAGE SECTION.
01  FSE     PIC X(2).
01  WS-REG-ESPECTACULO.
  02 WS-ESPEC-NUMERO           PIC 99.
  02 WS-ESPEC-NOMBRE           PIC X(20).
  02 WS-ESPEC-PRECIO-ENTRADA   PIC 999V99.
  02 WS-ESPEC-DESCRIPCION      PIC X(30).
  02 WS-ESPEC-ENT-DISPONIBLES  PIC 9(3).
  02 WS-ESPEC-FECHA.
     03 WS-DDE                  PIC 99.
     03 FILLER              PIC X.
     03 WS-MME                  PIC 99.
     03 FILLER              PIC X.
     03 WS-AAE                  PIC 9999.
PROCEDURE DIVISION.
    INICIO.
           MOVE 99 TO ESPEC-NUMERO
       
           OPEN INPUT EspecFile.
             READ EspecFile RECORD INTO WS-REG-ESPECTACULO
               KEY IS ESPEC-NUMERO
               INVALID KEY DISPLAY ESPEC-NUMERO
               NOT INVALID KEY DISPLAY WS-REG-ESPECTACULO
             END-READ.
           CLOSE EspecFile.
       STOP RUN.