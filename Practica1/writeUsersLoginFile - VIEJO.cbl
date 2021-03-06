       IDENTIFICATION DIVISION.
       PROGRAM-ID.  SeqWrite.
       
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT UserFile ASSIGN TO "USERS.DAT"
       		ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS USER-TARJ
               FILE STATUS IS FSU.
       
       
           SELECT LoginFile ASSIGN TO  "LOGIN.DAT"
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
          02 USER-TFNO             PIC X(9).
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
       01  FSU     PIC X(2).
       01  FSL     PIC XX(2).
       77  CUENTA-VACIA    PIC X(24) VALUE "                        ".
       
       PROCEDURE DIVISION.
           
       INICIO.
             PERFORM WRITE-LOGINFILE.
             PERFORM WRITE-USERSFILE.
             STOP RUN.

       WRITE-USERSFILE.
           OPEN OUTPUT UserFile.
              MOVE 1234567890 TO USER-TARJ.
              MOVE 1234 TO USER-PIN.
              MOVE 700.00 TO USER-SALDO(1).
              MOVE 1000.00 TO USER-SALDO(2).
              MOVE " " TO USER-SALDO(3).
              MOVE "17461858F" TO USER-DNI.
              MOVE "Alberto Perez Blasco" TO USER-NOM-APE.
              MOVE "456123789" TO USER-TFNO.
              MOVE "ÑKAJSFÑLKLKJDL" TO USER-DIRECCION.
              MOVE "0" TO USER-BLOQUEADA.
              MOVE "ES1212121212121212121212" TO USER-NUM-CUENTA(1)
              MOVE "ES3232323232323232323232" TO USER-NUM-CUENTA(2)
              MOVE CUENTA-VACIA TO USER-NUM-CUENTA(3)
              DISPLAY REG-USUARIO.
              WRITE REG-USUARIO
       
              MOVE 0987654321 TO USER-TARJ.
              MOVE 0000 TO USER-PIN.
              MOVE 90.00 TO USER-SALDO(1).
              MOVE " " TO USER-SALDO(2).
              MOVE " " TO USER-SALDO(3).
              MOVE "X9210389Q" TO USER-DNI
              MOVE "Radu Constantin Robu" TO USER-NOM-APE.
              MOVE "TERUEL" TO USER-DIRECCION.
              MOVE "0" TO USER-BLOQUEADA.
              MOVE "RO1212121212121212121212" TO USER-NUM-CUENTA(1).
              MOVE CUENTA-VACIA TO USER-NUM-CUENTA(2)
              MOVE CUENTA-VACIA TO USER-NUM-CUENTA(3)
              DISPLAY REG-USUARIO.
              WRITE REG-USUARIO.
            CLOSE UserFile. 

           WRITE-LOGINFILE.
           OPEN OUTPUT LoginFile.
              MOVE 1234567890 TO LOGIN-TARJ.
              MOVE 0 TO LOGIN-NUM-INTENTOS.
              DISPLAY REG-LOGIN.
              WRITE REG-LOGIN
       
              MOVE 0987654321 TO LOGIN-TARJ.
              MOVE 0 TO LOGIN-NUM-INTENTOS.
              DISPLAY REG-LOGIN.
              WRITE REG-LOGIN.
            CLOSE LoginFile.       
              
       
         