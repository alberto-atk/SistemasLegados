IDENTIFICATION DIVISION.
PROGRAM-ID.  SeqWrite.


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

PROCEDURE DIVISION.
INICIO.
*> Espectaculo 1      
       OPEN OUTPUT EspecFile.
         MOVE 99 TO ESPEC-NUMERO.
         MOVE "pRUEBA1222213121231f" TO ESPEC-NOMBRE.
         MOVE 240.99 TO ESPEC-PRECIO-ENTRADA.
         MOVE "Espectaculo de pruebaaaaaaaaa1" TO ESPEC-DESCRIPCION.
         MOVE 200 TO ESPEC-ENT-DISPONIBLES.
         MOVE "23/10/2021" TO ESPEC-FECHA
       DISPLAY REG-ESPECTACULO.
       WRITE REG-ESPECTACULO
       END-WRITE.

*> Espectaculo 2
      OPEN EXTEND EspecFile.
         MOVE 2 TO ESPEC-NUMERO.
         MOVE "pRUEBA2sfefefefefee2" TO ESPEC-NOMBRE.
         MOVE 240.99 TO ESPEC-PRECIO-ENTRADA.
         MOVE "Espectaculo de pruebaaaaaaaaa2" TO ESPEC-DESCRIPCION.
         MOVE 200 TO ESPEC-ENT-DISPONIBLES.
         MOVE "23/10/2021" TO ESPEC-FECHA
       DISPLAY REG-ESPECTACULO.
       WRITE REG-ESPECTACULO
      

*> Espectaculo 3     
         MOVE 3 TO ESPEC-NUMERO.
         MOVE "pRUEBA3sfefefefefee3" TO ESPEC-NOMBRE.
         MOVE 240.99 TO ESPEC-PRECIO-ENTRADA.
         MOVE "Espectaculo de pruebaaaaaaaaa3" TO ESPEC-DESCRIPCION.
         MOVE 200 TO ESPEC-ENT-DISPONIBLES.
         MOVE "23/10/2021" TO ESPEC-FECHA
       WRITE REG-ESPECTACULO

*> Espectaculo 4   
         MOVE 4 TO ESPEC-NUMERO.
         MOVE "pRUEBA4sfefefefefee4" TO ESPEC-NOMBRE.
         MOVE 240.99 TO ESPEC-PRECIO-ENTRADA.
         MOVE "Espectaculo de pruebaaaaaaaaa4" TO ESPEC-DESCRIPCION.
         MOVE 200 TO ESPEC-ENT-DISPONIBLES.
         MOVE "23/10/2021" TO ESPEC-FECHA
       WRITE REG-ESPECTACULO

*> Espectaculo 5   
         MOVE 5 TO ESPEC-NUMERO.
         MOVE "pRUEBA5sfefefefefee5" TO ESPEC-NOMBRE.
         MOVE 240.99 TO ESPEC-PRECIO-ENTRADA.
         MOVE "Espectaculo de pruebaaaaaaaaa5" TO ESPEC-DESCRIPCION.
         MOVE 200 TO ESPEC-ENT-DISPONIBLES.
         MOVE "23/10/2021" TO ESPEC-FECHA 
       WRITE REG-ESPECTACULO

*> Espectaculo 6
         MOVE 6 TO ESPEC-NUMERO.
         MOVE "pRUEBA6sfefefefefee6" TO ESPEC-NOMBRE.
         MOVE 240.99 TO ESPEC-PRECIO-ENTRADA.
         MOVE "Espectaculo de pruebaaaaaaaaa6" TO ESPEC-DESCRIPCION.
         MOVE 200 TO ESPEC-ENT-DISPONIBLES.
         MOVE "23/10/2021" TO ESPEC-FECHA  
       WRITE REG-ESPECTACULO

*> Espectaculo 7   
         MOVE 7 TO ESPEC-NUMERO.
         MOVE "pRUEBA7sfefefefefee7" TO ESPEC-NOMBRE.
         MOVE 240.99 TO ESPEC-PRECIO-ENTRADA.
         MOVE "Espectaculo de pruebaaaaaaaaa7" TO ESPEC-DESCRIPCION.
         MOVE 200 TO ESPEC-ENT-DISPONIBLES.
         MOVE "23/12/2021" TO ESPEC-FECHA 
       WRITE REG-ESPECTACULO
       END-WRITE.
       CLOSE EspecFile.

       STOP RUN.