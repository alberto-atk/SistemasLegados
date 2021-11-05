       IDENTIFICATION DIVISION.
       PROGRAM-ID.  SeqWrite.
       
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT USERFILE ASSIGN TO "USERS.DAT"
       		ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS USER-TARJ
               FILE STATUS IS FSU.
       
       
           SELECT LOGINFILE ASSIGN TO  "LOGIN.DAT"
              ORGANIZATION IS INDEXED
              ACCESS MODE IS DYNAMIC
              RECORD KEY IS LOGIN-TARJ
              FILE STATUS IS FSL.
       
       DATA DIVISION.
       FILE SECTION.
       FD USERFILE.
       01 REG-USUARIO.
          02 USER-TARJ             PIC 9(10).
          02 USER-PIN              PIC 9(4).
          02 USER-DNI              PIC X(9).
          02 USER-NOM-APE          PIC X(30).
          02 USER-TFNO             PIC 9(9).
          02 USER-DIRECCION        PIC X(25).
          02 USER-BLOQUEADA        PIC X.    
          02 CUENTA-USUARIO OCCURS 3 TIMES.
              03 USER-NUM-CUENTA       PIC X(24).
              03 USER-SALDO            PIC 9(9)V99.
       
       FD LOGINFILE.
        01 REG-LOGIN.
          02 LOGIN-TARJ             PIC 9(10).
          02 LOGIN-NUM-INTENTOS     PIC 9.
       
       WORKING-STORAGE SECTION.
       77  CUENTA-VACIA    PIC X(24) VALUE "                        ".
       77  SALDO-VACIO     PIC X VALUE " ".
       77  RECORD-COUNTER  PIC 9.
       01  FSU     PIC XX.
       01  FSL     PIC XX.

       01  DATOS-USUARIO.
           02  TARJ             PIC 9(10).
           02  PIN              PIC 9(4).
           02  DNI              PIC X(9).
           02  NOM-APE          PIC X(30).
           02  TFNO             PIC 9(9).
           02  DIRECCION        PIC X(25).
           02  BLOQUEADA        PIC X.    
           02  CUENTA1          PIC X(24).
           02  SALDO1           PIC 9(9)V99.
           02  EUROS1           PIC 9(9).
           02  CENTS1           PIC 99.
           02  CUENTA2          PIC X(24).
           02  SALDO2           PIC 9(9)V99.
           02  EUROS2           PIC 9(9).
           02  CENTS2           PIC 99.
           02  CUENTA3          PIC X(24).
           02  SALDO3           PIC 9(9)V99.
           02  EUROS3           PIC 9(9).
           02  CENTS3           PIC 99.
       
       01 WS-REG-USUARIO.
         02 WS-USER-TARJ             PIC 9(10).
         02 WS-USER-PIN              PIC 9(4).
         02 WS-USER-DNI              PIC X(9).
         02 WS-USER-NOM-APE          PIC X(30).
         02 WS-USER-TFNO             PIC X(9).
         02 WS-USER-DIRECCION        PIC X(25).
         02 WS-USER-BLOQUEADA        PIC X.
         02 WS-CUENTA-USUARIO OCCURS 3 TIMES.
             03 WS-USER-NUM-CUENTA       PIC X(24).
             03 WS-USER-SALDO            PIC 9(9)V99.

       01 WS-REG-LOGIN.
         02 WS-LOGIN-TARJ             PIC 9(10).
         02 WS-LOGIN-NUM-INTENTOS     PIC 9.

       01 FICHERO-USERS-EXTEND         PIC XX.
       01 FICHERO-LOGIN-EXTEND         PIC XX.

       SCREEN SECTION.
       01 CLEAR-SCREEN.
            02 BLANK SCREEN.

       01  PANTALLA-DATOS-USUARIO.
           02 LINE 2   COL 9   VALUE "---INTRODUZCA DATOS USUARIO---".
           02 LINE 4   COL 15  VALUE "TARJETA: ".
           02 LINE 4   COL 24  PIC 9(10) USING TARJ UNDERLINE 
               BLANK WHEN ZERO.
           02 LINE 6   COL 19  VALUE "PIN: ".
           02 LINE 6   COL 24  PIC 9(4) USING PIN UNDERLINE.
           02 LINE 8   COL 19  VALUE "DNI: ".
           02 LINE 8   COL 24  PIC X(9) USING DNI UNDERLINE.
           02 LINE 10  COL 4   VALUE "NOMBRE y APELLIDOS: ".
           02 LINE 10  COL 24  PIC X(30) USING NOM-APE UNDERLINE.
           02 LINE 12  COL 14  VALUE "TELEFONO: ".
           02 LINE 12  COL 24  PIC 9(9) USING TFNO UNDERLINE 
               BLANK WHEN ZERO.
           02 LINE 14  COL 13  VALUE "DIRECCION: ".
           02 LINE 14  COL 24  PIC X(25) USING DIRECCION UNDERLINE.
           02 LINE 16  COL 14  VALUE "CUENTA 1: ".
           02 LINE 16  COL 24  PIC X(24) USING CUENTA1 UNDERLINE.
           02 LINE 17  COL 8   VALUE "SALDO CUENTA 1: ".
           02 LINE 17  COL 24  PIC 9(9) USING EUROS1.
           02 LINE 17  COL 33  VALUE ".".
           02 LINE 17  COL 34  PIC 99 USING CENTS1.
           02 LINE 19  COL 14  VALUE "CUENTA 2: ".
           02 LINE 19  COL 24  PIC X(24) USING CUENTA2 UNDERLINE.
           02 LINE 20  COL 8   VALUE "SALDO CUENTA 2: ".
           02 LINE 20  COL 24  PIC 9(9) USING EUROS2.
           02 LINE 20  COL 33  VALUE ".".
           02 LINE 20  COL 34  PIC 99 USING CENTS2.
           02 LINE 22  COL 14  VALUE "CUENTA 3: ".
           02 LINE 22  COL 24  PIC X(24) USING CUENTA3 UNDERLINE.
           02 LINE 23  COL 8   VALUE "SALDO CUENTA 3: ".
           02 LINE 23  COL 24  PIC 9(9) USING EUROS3.
           02 LINE 23  COL 33  VALUE ".".
           02 LINE 23  COL 34  PIC 99 USING CENTS3. 
           02 LINE 26  COL 17  VALUE "ENTER - Aceptar".
           02 LINE 27  COL 17  VALUE "  F9  - Salir".

       01  PANTALLA-USUARIO-REGISTRADO.
           02 LINE 2   COL 13  VALUE "---USUARIO REGISTRADO---".
           02 LINE 4   COL 15  VALUE "TARJETA: ".
           02 LINE 4   COL 24  PIC 9(10) FROM TARJ.
           02 LINE 6   COL 19  VALUE "PIN: ".
           02 LINE 6   COL 24  PIC 9(4) FROM PIN.
           02 LINE 8   COL 19  VALUE "DNI: ".
           02 LINE 8   COL 24  PIC X(9) FROM DNI.
           02 LINE 10  COL 4   VALUE "NOMBRE y APELLIDOS: ".
           02 LINE 10  COL 24  PIC X(30) FROM NOM-APE.
           02 LINE 12  COL 14  VALUE "TELEFONO: ".
           02 LINE 12  COL 24  PIC 9(9) FROM TFNO.
           02 LINE 14  COL 13  VALUE "DIRECCION: ".
           02 LINE 14  COL 24  PIC X(25) FROM DIRECCION.
           02 LINE 16  COL 14  VALUE "CUENTA 1: ".
           02 LINE 16  COL 24  PIC X(24) FROM CUENTA1.
           02 LINE 17  COL 8   VALUE "SALDO CUENTA 1: ".
           02 LINE 17  COL 24  PIC 9(9) FROM EUROS1.
           02 LINE 17  COL 33  VALUE ".".
           02 LINE 17  COL 34  PIC 99 FROM CENTS1.
           02 LINE 19  COL 14  VALUE "CUENTA 2: ".
           02 LINE 19  COL 24  PIC X(24) FROM CUENTA2.
           02 LINE 20  COL 8   VALUE "SALDO CUENTA 2: ".
           02 LINE 20  COL 24  PIC 9(9) FROM EUROS2.
           02 LINE 20  COL 33  VALUE ".".
           02 LINE 20  COL 34  PIC 99 FROM CENTS2.
           02 LINE 22  COL 14  VALUE "CUENTA 3: ".
           02 LINE 22  COL 24  PIC X(24) FROM CUENTA3.
           02 LINE 23  COL 8   VALUE "SALDO CUENTA 3: ".
           02 LINE 23  COL 24  PIC 9(9) FROM EUROS3.
           02 LINE 23  COL 33  VALUE ".".
           02 LINE 23  COL 34  PIC 99 FROM CENTS3.
           02 LINE 24  COL 1   VALUE " ".
           02 LINE 25  COL 1   VALUE " ".
       
       PROCEDURE DIVISION.
           
       INICIO.
             PERFORM FIND-USERFILE.
             PERFORM FIND-LOGINFILE.
             DISPLAY CLEAR-SCREEN.
             DISPLAY PANTALLA-USUARIO-REGISTRADO.
             STOP RUN.

*> Busca el fichero de usuarios.
       FIND-USERFILE.
           OPEN INPUT USERFILE.
           IF FSU = "35"
               MOVE "NO" TO FICHERO-USERS-EXTEND
           ELSE 
               PERFORM READ-USERFILE.
           CLOSE USERFILE.
           PERFORM WRITE-USER-DATA.

*> Busca el fichero de claves de acceso.
       FIND-LOGINFILE.
           OPEN INPUT LOGINFILE.
           IF FSL = "35"
               MOVE "NO" TO FICHERO-LOGIN-EXTEND
           ELSE
               PERFORM READ-LOGINFILE.
           CLOSE LOGINFILE.
           PERFORM WRITE-LOGIN-DATA.

*> Lee el fichero de usuarios.
       READ-USERFILE.
           READ USERFILE 
           AT END MOVE "NO" TO FICHERO-USERS-EXTEND
           NOT AT END MOVE "SI" TO FICHERO-USERS-EXTEND.

*> Lee el fichero de claves de acceso.
       READ-LOGINFILE.
           READ LOGINFILE 
           AT END MOVE "NO" TO FICHERO-LOGIN-EXTEND
           NOT AT END MOVE "SI" TO FICHERO-LOGIN-EXTEND.

*> Escribe los datos del usuario.
       WRITE-USER-DATA.
           IF FICHERO-USERS-EXTEND = "SI"
               OPEN I-O USERFILE
           ELSE
               OPEN OUTPUT USERFILE.
           PERFORM ASK-USER-DATA.
           PERFORM WRITE-USERFILE.
           CLOSE USERFILE.

*> Escribe los datos de acceso de usuario.
       WRITE-LOGIN-DATA.
           IF FICHERO-LOGIN-EXTEND = "SI"
               OPEN I-O LOGINFILE
           ELSE
               OPEN OUTPUT LOGINFILE.
           PERFORM WRITE-LOGINFILE.
           CLOSE LOGINFILE.

*> Pregunta por los datos del usuario.
       ASK-USER-DATA.
           DISPLAY PANTALLA-DATOS-USUARIO.
           ACCEPT PANTALLA-DATOS-USUARIO
               IF COB-CRT-STATUS = 1009
                   STOP RUN.

*> Actualiza el fichero de usuarios.
       WRITE-USERFILE.
           MOVE TARJ TO USER-TARJ.
           MOVE PIN TO USER-PIN.
           MOVE DNI TO USER-DNI.
           MOVE NOM-APE TO USER-NOM-APE.
           MOVE TFNO TO USER-TFNO.
           MOVE DIRECCION TO USER-DIRECCION.
           MOVE "0" TO USER-BLOQUEADA.
           MOVE CUENTA1 TO USER-NUM-CUENTA(1).
           COMPUTE SALDO1 = (CENTS1 / 100) + EUROS1.
           MOVE SALDO1 TO USER-SALDO(1).
           MOVE CUENTA2 TO USER-NUM-CUENTA(2).
           COMPUTE SALDO2 = (CENTS2 / 100) + EUROS2.
           MOVE SALDO2 TO USER-SALDO(2).
           MOVE CUENTA3 TO USER-NUM-CUENTA(3).
           COMPUTE SALDO3 = (CENTS3 / 100) + EUROS3.
           MOVE SALDO3 TO USER-SALDO(3).
           WRITE REG-USUARIO.
           REWRITE REG-USUARIO.

*> Actualiza el fichero de claves de acceso.
       WRITE-LOGINFILE.
           MOVE TARJ TO LOGIN-TARJ.
           MOVE 0 TO LOGIN-NUM-INTENTOS.
           WRITE REG-LOGIN.
           REWRITE REG-LOGIN.
              
       
         