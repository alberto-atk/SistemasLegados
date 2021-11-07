       IDENTIFICATION DIVISION.
       PROGRAM-ID.  SeqWrite.
       
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.         
                SELECT ESPECFILE ASSIGN TO  "ESPEC.DAT"
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
            03 DDE                 PIC 99.
            03 FILLER              PIC X.
            03 MME                 PIC 99.
            03 FILLER              PIC X.
            03 AAE                 PIC 9999.

       WORKING-STORAGE SECTION.
       01  FSE     PIC X(2).

       01 DATOS-ESPECTACULO.
           02 NUMERO                   PIC 99.
           02 NOMBRE                   PIC X(20).
           02 EUROS-ENTRADA            PIC 999.
           02 CENT-ENTRADA             PIC 99.
           02 DESCRIPCION              PIC X(30).
           02 ENTRADAS-DISPONIBLES     PIC 9(3).
           02 DIA                      PIC 99.
           02 MES                      PIC 99.
           02 ANYO                     PIC 9999.

       01 FICHERO-ESPEC-EXTEND         PIC XX.
       01 SALDO                        PIC 999V99.

       SCREEN SECTION.
       01 CLEAR-SCREEN.
            02 BLANK SCREEN.

       01  PANTALLA-DATOS-ESPECTACULO.
           02 LINE 2   COL 9   VALUE "---INTRODUZCA LOS DATOS DEL ESPECTACULO---".
           02 LINE 4   COL 19  VALUE "NUMERO DE ESPECTACULO:".
           02 LINE 4   COL 42  PIC 99 USING NUMERO UNDERLINE 
               BLANK WHEN ZERO.
           02 LINE 6   COL 19  VALUE "NOMBRE DEL ESPECTACULO:".
           02 LINE 6   COL 44  PIC X(20) USING NOMBRE UNDERLINE.
           02 LINE 8   COL 19  VALUE "PRECIO POR ENTRADA:    .  ".
           02 LINE 8   COL 39  PIC 999 USING EUROS-ENTRADA .
           02 LINE 8   COL 43  PIC 99 USING CENT-ENTRADA.
           02 LINE 10  COL 19   VALUE "DESCRIPCION:".
           02 LINE 10  COL 32  PIC X(30) USING DESCRIPCION UNDERLINE.
           02 LINE 12  COL 19  VALUE "ENTRADAS DISPONIBLES:".
           02 LINE 12  COL 41  PIC 9(3) USING ENTRADAS-DISPONIBLES UNDERLINE 
               BLANK WHEN ZERO.
           02 LINE 16 COL 19 VALUE "Fecha:   /  /    ".
           02 LINE 16 COL 26 PIC 99 USING DIA UNDERLINE FULL.
           02 LINE 16 COL 29 PIC 99 USING MES UNDERLINE FULL.
           02 LINE 16 COL 32 PIC 9999 USING ANYO UNDERLINE FULL.
           02 LINE 20 COL 19  VALUE "ENTER - Aceptar".
           02 LINE 21  COL 19  VALUE "  F9  - Salir".

       01  PANTALLA-ESPECTACULO-REGISTRADO.
          02 LINE 2   COL 9   VALUE "---INTRODUZCA LOS DATOS DEL ESPECTACULO---".
           02 LINE 4   COL 19  VALUE "NUMERO DE ESPECTACULO:".
           02 LINE 4   COL 42  PIC 99 FROM NUMERO.
           02 LINE 6   COL 19  VALUE "NOMBRE DEL ESPECTACULO:".
           02 LINE 6   COL 44  PIC X(20) FROM NOMBRE.
           02 LINE 8   COL 19  VALUE "PRECIO POR ENTRADA:    .  ".
           02 LINE 8   COL 39  PIC 999 FROM EUROS-ENTRADA .
           02 LINE 8   COL 43  PIC 99 FROM CENT-ENTRADA.
           02 LINE 10  COL 19   VALUE "DESCRIPCION:".
           02 LINE 10  COL 32  PIC X(30) FROM DESCRIPCION.
           02 LINE 12  COL 19  VALUE "ENTRADAS DISPONIBLES:".
           02 LINE 12  COL 41  PIC 9(3) FROM ENTRADAS-DISPONIBLES.
           02 LINE 16 COL 19 VALUE "Fecha:   /  /    ".
           02 LINE 16 COL 26 PIC 99 FROM DIA.
           02 LINE 16 COL 29 PIC 99 FROM MES.
           02 LINE 16 COL 32 PIC 9999 FROM ANYO.
           02 LINE 20 COL 19  VALUE "ENTER - Aceptar".
           02 LINE 21  COL 19  VALUE "  F9  - Salir".



       PROCEDURE DIVISION.

       INICIO.
           PERFORM FIND-ESPECFILE.
           DISPLAY CLEAR-SCREEN.
           IF COB-CRT-STATUS = 1009
               STOP RUN.
           DISPLAY PANTALLA-ESPECTACULO-REGISTRADO.

*> Busca el fichero de espectaculos.
       FIND-ESPECFILE.
           OPEN INPUT ESPECFILE.
           IF FSE = "35"
               MOVE "NO" TO FICHERO-ESPEC-EXTEND
           ELSE 
               PERFORM READ-ESPECFILE.
           CLOSE ESPECFILE.
           PERFORM WRITE-ESPEC-DATA.


*> Lee el fichero de espectaculos.
       READ-ESPECFILE.
           READ ESPECFILE 
           AT END MOVE "NO" TO FICHERO-ESPEC-EXTEND
           NOT AT END MOVE "SI" TO FICHERO-ESPEC-EXTEND.

*> Escribe los datos del espectaculo.
       WRITE-ESPEC-DATA.
           IF FICHERO-ESPEC-EXTEND = "SI"
               OPEN I-O ESPECFILE
           ELSE
               OPEN OUTPUT ESPECFILE.
           PERFORM ASK-ESPEC-DATA.
           PERFORM WRITE-ESPECFILE.
           CLOSE ESPECFILE.

*> Pregunta por los datos del espectaculo.
       ASK-ESPEC-DATA.
           DISPLAY PANTALLA-DATOS-ESPECTACULO.
           ACCEPT PANTALLA-DATOS-ESPECTACULO
               IF COB-CRT-STATUS = 1009
                   STOP RUN.

*> Actualiza el fichero de espectaculos.
       WRITE-ESPECFILE.
           MOVE NUMERO TO ESPEC-NUMERO.
           MOVE NOMBRE TO ESPEC-NOMBRE.
  
           COMPUTE SALDO = (CENT-ENTRADA / 100) + EUROS-ENTRADA.
           MOVE SALDO TO ESPEC-PRECIO-ENTRADA.
           MOVE DESCRIPCION TO ESPEC-DESCRIPCION.
           MOVE ENTRADAS-DISPONIBLES TO ESPEC-ENT-DISPONIBLES.
           MOVE DIA TO DDE.
           MOVE MES TO MME.
           MOVE ANYO TO AAE.

           WRITE REG-ESPECTACULO.
           REWRITE REG-ESPECTACULO.