       IDENTIFICATION DIVISION.
       PROGRAM-ID. CAJERO.
       
        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
           SELECT USERFILE ASSIGN TO  "USERS.DAT"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS USER-TARJ
           FILE STATUS IS FSU.

           SELECT MOVFILE ASSIGN TO  "MOVS.DAT"
           ORGANIZATION IS SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS FSM.

           SELECT ESPECFILE ASSIGN TO  "ESPEC.DAT"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS ESPEC-NUMERO
           FILE STATUS IS FSE.

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
            02 USER-TFNO             PIC X(9).
            02 USER-DIRECCION        PIC X(25).
            02 USER-BLOQUEADA        PIC X.
            02 CUENTA-USUARIO        OCCURS 3 TIMES.
               03 USER-NUM-CUENTA       PIC X(24).
               03 USER-SALDO            PIC 9(9)V99.

         FD MOVFILE.
         01 REG-MOVIMIENTOS.
           02 MOV-ID                 PIC X(24).
           02 MOV-CONCEPTO           PIC X(40).
           02 MOV-CANTIDAD           PIC --------9.99.
           02 MOV-CUENTA-DESTINO     PIC X(24).
           02 MOV-SALDO              PIC 9(9)V99.
           02 MOV-FECHA.
              03 DDM                 PIC 99.
              03 FILLER              PIC X.
              03 MMM                 PIC 99.
              03 FILLER              PIC X.
              03 AAM                 PIC 9999.
           02 MOV-HORA.
              03 HH                  PIC 99.
              03 FILLER              PIC X.
              03 MM                  PIC 99.
              03 FILLER              PIC X.
              03 SS                  PIC 99.

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

         FD LOGINFILE.
         01 REG-LOGIN.
           02 LOGIN-TARJ             PIC 9(10).
           02 LOGIN-NUM-INTENTOS     PIC 9.

        WORKING-STORAGE SECTION.
         77 OP                       PIC X.
         77 OPCION                   PIC 9.
         77 FSU                      PIC XX.
         77 FSE                      PIC XX.
         77 FSM                      PIC XX.
         77 FSL                      PIC XX.
         77 TECLA                    PIC X.
         77 CODIGO-TECLA             PIC 99.
         77 CUENTA-VACIA             PIC X(24) VALUE "                        ".
         77 I                         PIC 999 VALUE 1.
         77 J                         PIC 999 VALUE 1.
         77 K                         PIC 999 VALUE 1.
         77 L                         PIC 999 VALUE 1.
         77 M                         PIC 999 VALUE 1.
         77 TOTAL-CUENTAS             PIC 999 VALUE 0.
         77 SELECCION-CUENTA          PIC 9.
         77 CUENTA-SELECCIONADA       PIC X(24).
         77 SALDO-SELECCIONADO        PIC 9(9)V99.
         77 SALDO-DESTINO             PIC 9(9)v99.
         77 LINEA-MOV                 PIC 99 VALUE 12.
         01 MOVIMIENTO.
            02 LINEA-DETALLE-MOV OCCURS 999 TIMES.
                03 FILLER             PIC X(1) VALUE SPACES.
                03 FECHA-D           PIC X(10).
                03 FILLER             PIC X(3) VALUE SPACES.
                03 CONCEPTO-D        PIC X(40).
                03 FILLER             PIC X(2) VALUE SPACES.
                03 CANTIDAD-D        PIC --------9.99.
                03 FILLER             PIC X(3) VALUE SPACES.
                03 SALDO-CUENTA-D    PIC --------9.99.
         77 LINEA-ESPEC                 PIC 99 VALUE 12.
         01 ESPECTACULO.
            02 LINEA-DETALLE-ESPEC OCCURS 100 TIMES.
                03 FILLER                PIC X(1) VALUE SPACES.
                03 NUM-D-ESPEC          PIC 99.
                03 FILLER                PIC X(3) VALUE SPACES.
                03 FECHA-D-ESPEC           PIC X(10).
                03 FILLER                PIC X(3) VALUE SPACES.
                03 NOMBRE-D-ESPEC       PIC X(20).
                03 FILLER                PIC X(3) VALUE SPACES.
                03 DESCRIPCION-D-ESPEC     PIC X(30).
                03 FILLER                PIC X(4) VALUE SPACES.
                03 PRECIO-D-ESPEC       PIC ZZ9.99.
                03 FILLER                PIC X(7) VALUE SPACES.
                03 ENT-DISPO-D-ESPEC    PIC ZZ9.

         01 WS-REG-USUARIO.
            02 WS-USER-TARJ             PIC 9(10).
            02 WS-USER-PIN              PIC 9(4).
            02 WS-USER-DNI              PIC X(9).
            02 WS-USER-NOM-APE          PIC X(30).
            02 WS-USER-TFNO             PIC X(9).
            02 WS-USER-DIRECCION        PIC X(25).
            02 WS-USER-BLOQUEADA        PIC X.
            02 WS-CUENTA-USUARIO        OCCURS 3 TIMES.
               03 WS-USER-NUM-CUENTA       PIC X(24).
               03 WS-USER-SALDO            PIC 9(9)V99.

         01 HORA.
              02 HH                  PIC 99.
              02 MM                  PIC 99.
              02 SS                  PIC 99.
         01 HORAF.
              02 HH                  PIC 99.
              02 FILLER              PIC X VALUE ":".
              02 MM                  PIC 99.
              02 FILLER              PIC X VALUE ":".
              02 SS                  PIC 99.

         01 FECHA.
               02 AA                  PIC 9999.
              02 MM                  PIC 99.
              02 DD                  PIC 99.
         01 FECHAF.
              02 DD                  PIC 99.
              02 FILLER              PIC X VALUE "/".
              02 MM                  PIC 99.
              02 FILLER              PIC X VALUE "/".
              02 AA                  PIC 9999.

        01 DATOS-ACCESO.
            02 NUM-TARJETA           PIC 9(10).
            02 PIN                   PIC 9(4).
            02 NUM-INTENTOS-ACC      PIC 9 VALUE 0.
            02 MSJ-INTENTOS-ACC      PIC X(35).
            02 MSJ-1-INTENTOS-ACC    PIC X(33)
               VALUE "Clave incorrecta, queda 1 intento".
            02 MSJ-2-INTENTOS-ACC    PIC X(35)
               VALUE "Clave incorrecta, quedan 2 intentos".

        01 SALDO-RETIRAR.
            02 EUROSR                PIC 9(9).
            02 CENTR                 PIC 99.
            02 DINERO-A-SACAR        PIC 9(9)V99.
            02 ERROR-RETIRAR         PIC X(48).
            02 MSJ-ERROR-RETIRAR     PIC X(48)
               VALUE "Saldo insuficiente. Indique una cantidad menor!!".
            02 CANTIDAD-RET-MOV      PIC --------9.99.

        01 CONSULTA-MOVIMIENTOS.
            02 DD-COMP                 PIC 99.
            02 FECHA-INICIO.
               03 DDI                PIC 99.
               03 MMI                PIC 99.
               03 AAI                PIC 9999.
            02 FECHA-FIN.
               03 DDF                PIC 99.
               03 MMF                PIC 99.
               03 AAF                PIC 9999.
            02 IEUROS                 PIC 9(6).
            02 ICENT                 PIC 99.
            02 FEUROS                PIC 9(6).
            02 FCENT                 PIC 99.
            02 CANTIDAD-INICIAL-MOV  PIC 9(6)V99.
            02 CANTIDAD-FINAL-MOV    PIC 9(6)V99.
            02 CANTIDAD-MOV          PIC 9(6)V99.
            02 FECHA-INICIAL-MOV     PIC 9(8).
            02 FECHA-FINAL-MOV       PIC 9(8).
            02 FECHA-MOV              PIC 9(8).
            02 NUM-TOTAL-MOV         PIC 999 VALUE IS 0.
            02 NUM-PANTALLA-MOV      PIC 999 VALUE IS 1.
            02 TOTAL-PANTALLAS-MOV   PIC 99.
            02 RESTO-MOV             PIC 99.
            02 NUM-PRIMER-MOV        PIC 999.
            02 NUM-ULTIMO-MOV        PIC 999.
            02 FILTRAR-POR-FECHA     PIC X(2) VALUE "SI".
            02 FILTRAR-POR-CANTIDAD  PIC X(2) VALUE "SI".
            02 MSJ-MOVS              PIC X(50).
            02 MSJ-ERROR-CANT        PIC X(50) VALUE
                "La cantidad inicial debe ser menor que la final!".
            02 MSJ-ERROR-FORMATO-FECHAS   PIC X(21) VALUE
                "La fecha es invalida!".
            02 MSJ-ERROR-FECHAS-I-F  PIC X(45) VALUE
                "La fecha inicial debe ser menor que la final!".

        01 SALDO-INGRESAR.
            02 EUROSI                PIC 9(4).
            02 CENTI                 PIC 99.
            02 DINERO-A-INGRESAR     PIC 9(9)V99.
            02 TOTAL-INGRESADO       PIC 9(5)V99.

        01 TRANSFERENCIA.
            02 CUENTA-DESTINO        PIC X(24).
            02 TITULAR               PIC X(20).
            02 CANTIDAD.
               03 EUROST             PIC 9(9).
               03 CENTT              PIC 99.
            02 DINERO-A-TRANSFERIR   PIC 9(9)V99.
            02 ERROR-TRANSF          PIC X(47).
            02 MSJ-ERROR-TRANSF      PIC X(47)
               VALUE "Saldo insuficiente. Indique una cantidad menor!".
            02 CANTIDAD-TRANSF-MOV   PIC --------9.99.
            02 CONCEPTO-TRANSF-MOV   PIC X(40).

        01 ESPECTACULOS.
            02 NUM-ENTRADAS          PIC 9(3).
            02 NUM-ENTRADAS-FORMAT   PIC ZZ9.
            02 NUM-ESPEC             PIC 99.
            02 COSTE-TOTAL-ENTRADAS  PIC 9(4)V99.
            02 COSTE-TOTAL-ENT-MOV   PIC ---9.99.
            02 NUM-TOTAL-ESPEC       PIC 99.
            02 HAY-ENTRADAS             PIC X(2).
            02 EXISTE-ESPECTACULO     PIC X(2).
            02 MSJ-ENTER-ESPEC       PIC X(22).
            02 MSJ-NO-MAS-ESPEC      PIC X(13) VALUE "Enter-Aceptar".
            02 MSJ-MAS-ESPEC         PIC X(22)
                VALUE "Enter-Mas espectaculos".
            02 NUM-PANTALLA-ESPEC    PIC 999 VALUE 1.
            02 TOTAL-PANTALLAS-ESPEC PIC 99.
            02 RESTO-ESPEC             PIC 99.
            02 NUM-PRIMER-ESPEC      PIC 999.
            02 NUM-ULTIMO-ESPEC      PIC 999.
            02 MSJ-COMPRAR-ENTRADAS  PIC X(51).
            02 MSJ-ERROR-ENTRADAS    PIC X(51) VALUE
               "Entradas insuficientes. Indique una cantidad menor!".
            02 MSJ-ERROR-ESPEC       PIC X(50) VALUE
               "El espectaculo seleccionado no existe. Elija otro!".

        01 CAMBIO-CLAVE.
            02 CLAVE-ACTUAL          PIC 9(4).
            02 CLAVE-NUEVA           PIC 9(4).
            02 CLAVE-NUEVA-2         PIC 9(4).
            02 MSJ-ERROR-CCLAVE      PIC X(41).
            02 MSJ-INTENTOS          PIC X(19).
            02 NUM-ERRORES-CACTUAL   PIC 9 VALUE 0.
            02 NUM-ERRORES-CNUEVA    PIC 9 VALUE 0.
            02 ERROR-CLAVE-ACTUAL    PIC X(41)
               VALUE "La clave actual indicada no es correcta!!".
            02 ERROR-CLAVE-NUEVA     PIC X(41)
               VALUE "La nueva clave no coincide o no es valida".
            02 ERROR-TARJ-BLOQ       PIC X(31)
               VALUE "Tarjeta bloqueada por seguridad".
            02 MSJ-0-INTENTOS        PIC X(19)
               VALUE "Acuda a una oficina".
            02 MSJ-1-INTENTOS        PIC X(17)
               VALUE "Queda 1 intento".
            02 MSJ-2-INTENTOS        PIC X(17)
               VALUE "Quedan 2 intentos".


        SCREEN SECTION.
         01 CLEAR-SCREEN.
            02 BLANK SCREEN.

         01 PANTALLA-BIENVENIDA FOREGROUND-COLOR IS 7
            BACKGROUND-COLOR IS 1.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 8 COL 28 VALUE "Bienvenido a UnizarBank".
            02 LINE 11 COL 17
               VALUE "Por favor, introduzca una tarjeta para operar".
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-ACCESO-SISTEMA FULL REQUIRED AUTO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 10 COL 25 VALUE "Numero de tarjeta: ".
            02 LINE 10 COL 44 PIC 9(10) USING NUM-TARJETA
                BLANK WHEN ZERO.
            02 LINE 12 COL 37 VALUE "Clave: ".
            02 LINE 12 COL 44 PIC 9(4) USING PIN SECURE
				BLANK WHEN ZERO.
            02 LINE 23 COL 17 VALUE "Esc - Cancelar".
            02 LINE 23 COL 48 VALUE "Enter - Aceptar". 
         
         01 PANTALLA-ERROR-ACCESO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 10 COL 22 PIC X(35) FROM MSJ-INTENTOS-ACC.
            02 LINE 23 COL 17 VALUE "Esc - Cancelar".
            02 LINE 23 COL 48 VALUE "Enter - Aceptar".

         01 PANTALLA-ERROR-USUARIO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 10 COL 22
               VALUE "El numero de tarjeta no es correcto".
            02 LINE 23 COL 17 VALUE "Esc - Cancelar".
            02 LINE 23 COL 48 VALUE "Enter - Aceptar".

         01 PANTALLA-SELECCION-CUENTA.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 8 COL 20 VALUE 
               "Escoja la cuenta con la que desee operar".
            02 LINE 10 COL 17 VALUE "1.-".
            02 LINE 10 COL 20 PIC X(24) FROM WS-USER-NUM-CUENTA(1).
            02 LINE 10 COL 45 VALUE "          .   EUR".
            02 LINE 10 COL 45 PIC ZZZZZZZ9.99 FROM WS-USER-SALDO(1).
            02 LINE 12 COL 17 VALUE "2.-".
            02 LINE 12 COL 20 PIC X(24) FROM WS-USER-NUM-CUENTA(2).
            02 LINE 12 COL 45 VALUE "          .   EUR".
            02 LINE 12 COL 45 PIC ZZZZZZZ9.99 FROM WS-USER-SALDO(2).
            02 LINE 14 COL 17 VALUE "3.-".
            02 LINE 14 COL 20 PIC X(24) FROM WS-USER-NUM-CUENTA(3).
            02 LINE 14 COL 45 VALUE "          .   EUR".
            02 LINE 14 COL 45 PIC ZZZZZZZ9.99 FROM WS-USER-SALDO(3).

            02 LINE 16 COL 44 PIC 9 USING SELECCION-CUENTA
                BLANK WHEN ZERO.
            02 LINE 23 COL 17 VALUE "Esc - Cancelar".
            02 LINE 23 COL 48 VALUE "Enter - Aceptar".

         01 PANTALLA-BLOQUEO-TARJETA.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 10 COL 20
               VALUE "Se ha sobrepasado el numero de intentos".
            02 LINE 12 COL 24 VALUE "Tarjeta bloqueada por seguridad".
            02 LINE 14 COL 30 VALUE "Acuda a una oficina ".
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-TARJETA-BLOQUEADA.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 11 COL 27 VALUE "Su tarjeta esta bloqueada".
            02 LINE 13 COL 30 VALUE "Acuda a una oficina".
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-MENU-PRINCIPAL.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 25 VALUE "1 - Consultar saldo".
            02 LINE 10 COL 25 VALUE "2 - Consultar movimientos".
            02 LINE 11 COL 25 VALUE "3 - Retirar efectivo".
            02 LINE 12 COL 25 VALUE "4 - Ingresar efectivo".
            02 LINE 13 COL 25 VALUE "5 - Ordenar transferencia".
            02 LINE 14 COL 25 VALUE "6 - Comprar entradas espectaculos".
            02 LINE 16 COL 25 VALUE "7 - Cambiar clave".
            02 LINE 23 COL 34 VALUE "Esc - Salir".
        
         01 PANTALLA-CONSULTA-SALDO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 31 UNDERLINE VALUE "Consulta de saldo".
            02 LINE 13 COL 16
               VALUE "El saldo de tu cuenta                          es de".
            02 LINE 13 COL 38 PIC X(24) FROM CUENTA-SELECCIONADA.
            02 LINE 15 COL 32 PIC --------9.99 FROM SALDO-SELECCIONADO.
            02 LINE 15 COL 45 VALUE "EUR".
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-CONSULTA-MOVIMIENTOS AUTO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 28 VALUE "Consulta de movimientos" UNDERLINE.
            02 LINE 12 COL 9
               VALUE "Se mostraran los ultimos movimientos de mas a ".
            02 LINE 12 COL 55 VALUE "menos recientes".
            02 LINE 13 COL 8
               VALUE "Alternativamente, indique un intervalo de fechas".
            02 LINE 13 COL 56 VALUE " y/o cantidades".
            02 LINE 16 COL 22
               VALUE "Entre las fechas   /  /     y   /  /    ".
            02 LINE 16 COL 39 PIC 99 USING DDI UNDERLINE FULL.
            02 LINE 16 COL 42 PIC 99 USING MMI UNDERLINE FULL.
            02 LINE 16 COL 45 PIC 9999 USING AAI UNDERLINE FULL.
            02 LINE 16 COL 52 PIC 99 USING DDF UNDERLINE FULL.
            02 LINE 16 COL 55 PIC 99 USING MMF UNDERLINE FULL.
            02 LINE 16 COL 58 PIC 9999 USING AAF UNDERLINE FULL.
            02 LINE 17 COL 18
               VALUE "Cantidad entre       .   EUR y       .   EUR".
            02 LINE 17 COL 33 PIC 9(6) USING IEUROS UNDERLINE.
            02 LINE 17 COL 40 PIC 99 USING ICENT UNDERLINE FULL.
            02 LINE 17 COL 49 PIC 9(6) USING FEUROS UNDERLINE.
            02 LINE 17 COL 56 PIC 99 USING FCENT UNDERLINE FULL.
			02 LINE 19 COL 15 PIC X(50) FROM MSJ-MOVS HIGHLIGHT.
            02 LINE 23 COL 17 VALUE "Esc - Cancelar".
            02 LINE 23 COL 48 VALUE "Enter - Aceptar".

         01 PANTALLA-MUESTRA-MOVIMIENTOS.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 8 COL 28 VALUE "Consulta de movimientos".
            02 LINE 11 COL 2 VALUE "Fecha".
            02 LINE 12 COL 2 VALUE "----------".
            02 LINE 11 COL 15 VALUE "Concepto".
            02 LINE 12 COL 15
                VALUE "----------------------------------------".
            02 LINE 11 COL 61 VALUE "Cantidad".
            02 LINE 12 COL 61 VALUE "--------".
            02 LINE 11 COL 72 VALUE "Saldo cuenta".
            02 LINE 12 COL 72 VALUE "------------".
            02 LINE 23 COL 13 VALUE "Esc -".
            02 LINE 24 COL 11 VALUE "Cancelar".
            02 LINE 23 COL 32 VALUE "Abajo -".
            02 LINE 24 COL 28 VALUE "Movs. Anteriores".
            02 LINE 23 COL 59 VALUE "Arriba -".
            02 LINE 24 COL 54 VALUE "Movs. Siguientes".

         01 PANTALLA-SIN-MOVIMIENTOS.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 28 VALUE "Consulta de movimientos".
            02 LINE 12 COL 14 VALUE "No hay movimientos con los ".
            02 LINE 12 COL 41 VALUE "criterios seleccionados!".
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-RETIRAR-EFECTIVO REQUIRED AUTO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 32 VALUE "Retirar efectivo" UNDERLINE.
            02 LINE 12 COL 25 VALUE "Saldo actual:              EUR".
            02 LINE 12 COL 39 PIC ZZZZZZZZ9.99 FROM SALDO-SELECCIONADO.
            02 LINE 15 COL 16
               VALUE "Indique la cantidad a retirar:          .   EUR".
            02 LINE 15 COL 47 PIC 9(9) USING EUROSR.
            02 LINE 15 COL 57 PIC 99 USING CENTR FULL BLANK WHEN ZERO.
            02 LINE 18 COLUMN 16 PIC X(48) FROM ERROR-RETIRAR HIGHLIGHT.
            02 LINE 23 COL 17 VALUE "Esc - Cancelar".
            02 LINE 23 COL 48 VALUE "Enter - Aceptar".

         01 PANTALLA-EFECTIVO-RETIRADO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 32 VALUE "Retirar efectivo" UNDERLINE.
            02 LINE 13 COL 19
               VALUE "Por favor, retire los billetes y el ticket".
            02 LINE 15 COL 19
               VALUE "El saldo resultante es de              EUR".
            02 LINE 15 COL 45 PIC --------9.99 FROM SALDO-SELECCIONADO.
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-INICIAR-INGRESO REQUIRED AUTO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 31 VALUE "Ingresar efectivo" UNDERLINE.
            02 LINE 12 COL 25 VALUE "Saldo actual:          .   EUR".
            02 LINE 12 COL 39 PIC ZZZZZZZZ9.99 FROM SALDO-SELECCIONADO.
            02 LINE 16 COL 23
               VALUE "Por favor, introduzca los billetes".
            02 LINE 18 COL 24 VALUE "Cantidad a ingresar     .   EUR".
            02 LINE 18 COL 44 PIC 9(4) USING EUROSI.
            02 LINE 18 COL 49 PIC 99 USING CENTI FULL BLANK WHEN ZERO.
            02 LINE 23 COL 17 VALUE "Esc - Cancelar".
            02 LINE 23 COL 48 VALUE "Enter - Ingresar".  
         
         01 PANTALLA-INGRESANDO-EFECTIVO REQUIRED AUTO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 31 VALUE "Ingresar efectivo" UNDERLINE.
            02 LINE 12 COL 25 VALUE "Saldo actual:          .   EUR".
            02 LINE 12 COL 39 PIC ZZZZZZZZ9.99 FROM SALDO-SELECCIONADO.
            02 LINE 15 COL 10 VALUE "Por favor, introduzca los ".
            02 LINE 15 COL 36 VALUE    "billetes para continuar ".
            02 LINE 15 COL 60 VALUE    "ingresando".
            02 LINE 16 COL 25 VALUE    "Lleva ingresados          EUR".
            02 LINE 16 COL 42 PIC ZZZZ9.99 FROM TOTAL-INGRESADO.
            02 LINE 19 COL 24 VALUE "Cantidad a ingresar     .   EUR".
            02 LINE 19 COL 44 PIC 9(4) USING EUROSI.
            02 LINE 19 COL 49 PIC 99 USING CENTI FULL BLANK WHEN ZERO.  
            02 LINE 23 COL 28 VALUE "Esc - Finalizar ingreso".
            
         01 PANTALLA-ERROR-SELECCION.
           02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 10 COL 22
               VALUE "La cuenta seleccionada no es correcta".
            02 LINE 23 COL 48 VALUE "Enter - Aceptar".

         01 PANTALLA-EFECTIVO-INGRESADO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 31 VALUE "Ingresar efectivo" UNDERLINE.
            02 LINE 13 COL 19
               VALUE "Se han recibido correctamente          EUR".
            02 LINE 13 COL 49 PIC ZZZZ9.99 FROM TOTAL-INGRESADO.
            02 LINE 15 COL 19
               VALUE "El saldo resultante es de              EUR".
            02 LINE 15 COL 45 PIC --------9.99 FROM SALDO-SELECCIONADO.
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-ORDENAR-TRANSF REQUIRED AUTO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 8 COL 29 VALUE "Ordenar transferencia" UNDERLINE.
            02 LINE 11 COL 25 VALUE "Saldo actual:              EUR".
            02 LINE 11 COL 39 PIC --------9.99 FROM SALDO-SELECCIONADO.
            02 LINE 14 COL 16 VALUE "Indique la cuenta destino: ".
            02 LINE 14 COL 43 PIC X(24) USING CUENTA-DESTINO FULL.
            02 LINE 15 COL 16 VALUE "y el nombre de su titular: ".
            02 LINE 15 COL 43 PIC X(20) USING TITULAR.
            02 LINE 17 COL 16 VALUE
                "Indique la cantidad a transferir          .   EUR".
            02 LINE 17 COL 49 PIC 9(9) USING EUROST.
            02 LINE 17 COL 59 PIC 99 USING CENTT FULL BLANK WHEN ZERO.
            02 LINE 20 COL 16 PIC X(47) FROM ERROR-TRANSF HIGHLIGHT.
            02 LINE 23 COL 17 VALUE "Esc - Cancelar".
            02 LINE 23 COL 48 VALUE "Enter - Aceptar".

         01 PANTALLA-CONFIRMAR-TRANSF.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 8 COL 29 VALUE "Ordenar transferencia" UNDERLINE.
            02 LINE 12 COL 17
               VALUE "Va a transferir              EUR de su cuenta".
            02 LINE 12 COL 33 PIC --------9.99 FROM DINERO-A-TRANSFERIR.
            02 LINE 14 COL 23
               VALUE "a la cuenta '                        '".
            02 LINE 16 COL 22 VALUE "cuyo titular es ".
            02 LINE 14 COL 36 PIC X(24) FROM CUENTA-DESTINO.
            02 LINE 16 COL 38 PIC X(20) FROM TITULAR.
            02 LINE 23 COL 17 VALUE "Esc - Cancelar".
            02 LINE 23 COL 46 VALUE "Enter - Confirmar".

         01 PANTALLA-TRANSF-CONFIRMADA.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 8 COL 29 VALUE "Ordenar transferencia" UNDERLINE.
            02 LINE 12 COL 21
               VALUE "Transferencia realizada correctamente!".
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-TRANSF-CANCELADA.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 8 COL 29 VALUE "Ordenar transferencia" UNDERLINE.
            02 LINE 12 COL 28 VALUE "Transferencia cancelada!".
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-MUESTRA-ESPECTACULOS REQUIRED AUTO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 7 COL 23 VALUE "Compra de entradas de espectaculos"
                UNDERLINE.
            02 LINE 9 COL 25 VALUE "Saldo actual:              EUR".
            02 LINE 9 COL 39 PIC --------9.99 FROM SALDO-SELECCIONADO.
            02 LINE 11 COL 2 VALUE "Num".
            02 LINE 12 COL 1 VALUE "----".
            02 LINE 11 COL 9 VALUE "Fecha".
            02 LINE 12 COL 7 VALUE "----------".
            02 LINE 11 COL 27 VALUE "Nombre".
            02 LINE 12 COL 20 VALUE "--------------------".
            02 LINE 11 COL 52 VALUE "Descripcion".
            02 LINE 12 COL 43 VALUE "------------------------------".
            02 LINE 11 COL 76 VALUE "Precio".
            02 LINE 12 COL 76 VALUE "-------".
            02 LINE 11 COL 86 VALUE "Disponible".
            02 LINE 12 COL 86 VALUE "----------".				
            02 LINE 23 COL 6 VALUE "Esc -".
            02 LINE 24 COL 4 VALUE "Cancelar".
            02 LINE 23 COL 25 VALUE "Abajo -".
            02 LINE 24 COL 20 VALUE "Espec. Anteriores".
            02 LINE 23 COL 50 VALUE "Arriba -".
            02 LINE 24 COL 45 VALUE "Espec. Siguientes".
            02 LINE 23 COL 70 VALUE "Enter -".
            02 LINE 24 COL 68 VALUE "Ir a compra".

         01 PANTALLA-COMPRAR-ENTRADAS AUTO REQUIRED.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 7 COL 23 VALUE "Compra de entradas de espectaculos"
                UNDERLINE.
            02 LINE 9 COL 25 VALUE "Saldo actual:              EUR".
            02 LINE 9 COL 39 PIC --------9.99 FROM SALDO-SELECCIONADO.
            02 LINE 11 COL 2 VALUE "Num".
            02 LINE 12 COL 1 VALUE "----".
            02 LINE 11 COL 9 VALUE "Fecha".
            02 LINE 12 COL 7 VALUE "----------".
            02 LINE 11 COL 27 VALUE "Nombre".
            02 LINE 12 COL 20 VALUE "--------------------".
            02 LINE 11 COL 52 VALUE "Descripcion".
            02 LINE 12 COL 43 VALUE "------------------------------".
            02 LINE 11 COL 76 VALUE "Precio".
            02 LINE 12 COL 76 VALUE "-------".
            02 LINE 11 COL 86 VALUE "Disponible".
            02 LINE 12 COL 86 VALUE "----------".	
            02 LINE 20 COL 18 VALUE "Comprar '   ' entradas ".
            02 LINE 20 COL 41 VALUE "del espectaculo '  '".
            02 LINE 20 COL 27 PIC 9(3) USING NUM-ENTRADAS
                BLANK WHEN ZERO.
            02 LINE 20 COL 58 PIC 99 USING NUM-ESPEC BLANK WHEN ZERO.
            02 LINE 22 COL 14 PIC X(51) FROM MSJ-COMPRAR-ENTRADAS
				HIGHLIGHT.
            02 LINE 24 COL 17 VALUE "Esc - Cancelar".
            02 LINE 24 COL 48 VALUE "Enter - Comprar".

         01 PANTALLA-ENT-ESPEC-COMPRADAS.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 8 COL 23 VALUE "Compra de entradas de espectaculos"
                UNDERLINE.
            02 LINE 13 COL 25 VALUE "Por favor, retire las entradas".
            02 LINE 15 COL 19
               VALUE "El saldo resultante es de              EUR".
            02 LINE 15 COL 45 PIC --------9.99 FROM SALDO-SELECCIONADO.
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-ESPEC-SIN-SALDO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 39 VALUE "-".
            02 LINE 4 COL 41 PIC X(8) FROM HORAF.
            02 LINE 8 COL 23 VALUE "Compra de entradas de espectaculos"
                UNDERLINE.
            02 LINE 13 COL 16 VALUE
                 "Lo sentimos mucho, pero el saldo es insuficiente".
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-CONFIRMAR-COMPRA-ENT.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 7 COL 23 VALUE "Compra de entradas de espectaculos"
                UNDERLINE.
            02 LINE 12 COL 18 VALUE "Vas a comprar     entradas ".
            02 LINE 12 COL 32 PIC ZZ9 FROM NUM-ENTRADAS.
            02 LINE 12 COL 45 VALUE "para el ".
            02 LINE 12 COL 53 PIC X(10) FROM ESPEC-FECHA.
            02 LINE 14 COL 22 VALUE "del espectaculo ".
            02 LINE 14 COL 38 PIC X(20) FROM ESPEC-NOMBRE.
            02 LINE 17 COL 27 VALUE "Precio total:         EUR".
            02 LINE 17 COL 41 PIC ---9.99 FROM COSTE-TOTAL-ENTRADAS.
            02 LINE 23 COL 17 VALUE "Esc - Cancelar".
            02 LINE 23 COL 47 VALUE "Enter - Confirmar".

         01 PANTALLA-SIN-ESPECTACULOS.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 8 COL 23 VALUE "Compra de entradas de espectaculos"
                UNDERLINE.
            02 LINE 13 COL 34 VALUE "Lo sentimos!".
            02 LINE 14 COL 16 VALUE "En este momento no hay ".
            02 LINE 14 COL 39 VALUE "espectaculos en cartelera".
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-CAMBIAR-CLAVE REQUIRED FULL AUTO.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 28 VALUE "Cambio de clave personal" UNDERLINE.
            02 LINE 12 COL 24 VALUE "Introduzca la clave actual: ".
            02 LINE 12 COL 52 PIC 9(4) USING CLAVE-ACTUAL SECURE
                BLANK WHEN ZERO.
            02 LINE 13 COL 25 VALUE "Introduzca la nueva clave: ".
            02 LINE 13 COL 52 PIC 9(4) USING CLAVE-NUEVA SECURE
                BLANK WHEN ZERO.
            02 LINE 14 COL 29 VALUE "Repita la nueva clave: ".
            02 LINE 14 COL 52 PIC 9(4) USING CLAVE-NUEVA-2 SECURE
            	BLANK WHEN ZERO.
            02 LINE 23 COL 17 VALUE "Esc - Cancelar".
            02 LINE 23 COL 47 VALUE "Enter - Confirmar".

         01 PANTALLA-CLAVE-CAMBIADA.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 28 VALUE "Cambio de clave personal" UNDERLINE.
            02 LINE 12 COL 19
               VALUE "La clave se ha actualizado correctamente!".
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".

         01 PANTALLA-ERROR-CAMBIO-CLAVE.
            02 BLANK SCREEN.
            02 LINE 3 COL 26 VALUE "Cajero Automatico UnizarBank".
            02 LINE 4 COL 30 PIC X(10) FROM FECHAF.
            02 LINE 4 COL 41 VALUE "-".
            02 LINE 4 COL 43 PIC X(8) FROM HORAF.
            02 LINE 9 COL 28 VALUE "Cambio de clave personal" UNDERLINE.
            02 LINE 13 COL 22 PIC X(41) FROM MSJ-ERROR-CCLAVE.
            02 LINE 15 COL 30 PIC X(19) FROM MSJ-INTENTOS.
            02 LINE 23 COL 32 VALUE "Enter - Aceptar".


        PROCEDURE DIVISION.
        SPECIAL-CHARACTERS.
           SET ENVIRONMENT 'COB_SCREEN_EXCEPTIONS' TO 'Y'.
           SET ENVIRONMENT 'COB_SCREEN_ESC' TO 'Y'.

         INICIO.
            PERFORM OBTENER-FECHA.
			DISPLAY PANTALLA-BIENVENIDA.  
			PERFORM LEER-TECLA.
			IF COB-CRT-STATUS = 2005
			  STOP RUN 
			ELSE
			 IF COB-CRT-STATUS NOT = 0
			   GO TO INICIO.
			  
         LOGIN.
			DISPLAY PANTALLA-ACCESO-SISTEMA. 
			ACCEPT PANTALLA-ACCESO-SISTEMA
			  IF COB-CRT-STATUS = 2005
			    PERFORM RESTAURAR-CAMPOS-ACCESO
		        GO TO INICIO.
		    
		    PERFORM LEER-TECLA.
			IF COB-CRT-STATUS = 2005	  
			  GO TO INICIO 
			ELSE
			 IF COB-CRT-STATUS NOT = 0
			   MOVE 0 TO PIN
			   GO TO LOGIN.
			    	  
			PERFORM COMPROBAR-ACCESO. 
			IF NUM-INTENTOS-ACC > 0
	 	      IF NUM-INTENTOS-ACC = 1
                MOVE MSJ-2-INTENTOS-ACC TO MSJ-INTENTOS-ACC
                GO TO ERROR-CLAVE
              ELSE
                IF NUM-INTENTOS-ACC = 2
                  MOVE MSJ-1-INTENTOS-ACC TO MSJ-INTENTOS-ACC
                  GO TO ERROR-CLAVE
                ELSE
                  PERFORM RESTAURAR-CAMPOS-ACCESO
                  GO TO BLOQUEO-TARJETA.
         PERFORM MOSTRAR-PANTALLA-SELECCION-CUENTA.   

         MENU-OPCIONES.
            PERFORM RESTAURAR-CAMPOS-ACCESO.
            DISPLAY PANTALLA-MENU-PRINCIPAL.
			PERFORM LEER-TECLA.

			IF COB-CRT-STATUS = 2005
			  MOVE 0 TO NUM-ERRORES-CNUEVA
		      MOVE 0 TO NUM-ERRORES-CACTUAL
			  GO TO INICIO 
			ELSE
			  IF TECLA = 1
			    GO TO CONSULTAR-SALDO
			  ELSE
			    IF TECLA = 2
				  GO TO CONSULTAR-MOVS
			    ELSE
				  IF TECLA = 3
			        GO TO RETIRAR-EFECTIVO
				  ELSE
				    IF TECLA = 4
                      GO TO INGRESAR-EFECTIVO
                    ELSE
                      IF TECLA = 5
                        GO TO HACER-TRANSFERENCIA
                      ELSE
                        IF TECLA = 6
                          GO TO COMPRAR-ENTRADAS
                        ELSE
                          IF TECLA = 7
                            GO TO CAMBIAR-CLAVE
                          ELSE
                            GO TO MENU-OPCIONES.

*> Procedimiento mostrar-pantalla-seleccion-cuenta
       MOSTRAR-PANTALLA-SELECCION-CUENTA.
           PERFORM LEER-SALDOS-CUENTAS.
		   DISPLAY PANTALLA-SELECCION-CUENTA.
           ACCEPT PANTALLA-SELECCION-CUENTA.
           IF COB-CRT-STATUS = 2005
               PERFORM RESTAURAR-CAMPOS-ACCESO
               GO TO LOGIN.
           PERFORM OBTENER-CUENTA-SALDO-A-USAR.       





*> Procedimiento obtener saldos y cuentas
       LEER-SALDOS-CUENTAS.
           MOVE 1 TO K. 
           OPEN INPUT USERFILE.

           MOVE USER-NUM-CUENTA(1) TO WS-USER-NUM-CUENTA(1).
           MOVE USER-SALDO(1) TO WS-USER-SALDO(1).

           MOVE USER-NUM-CUENTA(2) TO WS-USER-NUM-CUENTA(2).
           MOVE USER-SALDO(2) TO WS-USER-SALDO(2).

           MOVE USER-NUM-CUENTA(3) TO WS-USER-NUM-CUENTA(3).
           MOVE USER-SALDO(3) TO WS-USER-SALDO(3).

          CLOSE USERFILE.


       



*> Procedimiento obtener cuenta a usar por el usuario
       OBTENER-CUENTA-SALDO-A-USAR.
           IF SELECCION-CUENTA > 3
               PERFORM MOSTRAR-ERROR-SELECCION-CUENTA
           ELSE
               IF WS-USER-NUM-CUENTA(SELECCION-CUENTA) = CUENTA-VACIA
                   PERFORM MOSTRAR-ERROR-SELECCION-CUENTA
               ELSE
                  MOVE WS-USER-NUM-CUENTA(SELECCION-CUENTA) TO CUENTA-SELECCIONADA
                  MOVE WS-USER-SALDO(SELECCION-CUENTA) TO SALDO-SELECCIONADO.

*> Procedimiento mostrar-error-seleccion-cuenta
       MOSTRAR-ERROR-SELECCION-CUENTA.
           DISPLAY PANTALLA-ERROR-SELECCION.
           PERFORM LEER-TECLA.
		   IF COB-CRT-STATUS = 0
               MOVE ' ' TO SELECCION-CUENTA
               PERFORM MOSTRAR-PANTALLA-SELECCION-CUENTA.


*> Procedimiento obtener-fecha
       OBTENER-FECHA.
           MOVE FUNCTION CURRENT-DATE TO FECHA.
           MOVE CORR FECHA TO FECHAF.
           ACCEPT HORA FROM TIME.
           MOVE CORR HORA TO HORAF.

*> Procedimiento leer-tecla
       LEER-TECLA.
           ACCEPT TECLA LINE 25 COLUMN 1.
            

*> Procedimiento restaurar-campos-acceso
       RESTAURAR-CAMPOS-ACCESO.
           MOVE 0 TO PIN.
           MOVE 0 TO NUM-TARJETA.

*> Procedimiento comprobar-acceso
       COMPROBAR-ACCESO.
           OPEN INPUT USERFILE.
           OPEN I-O LOGINFILE.
           MOVE NUM-TARJETA TO USER-TARJ.

           READ USERFILE INVALID KEY GO TO ERROR-USUARIO.
           IF USER-BLOQUEADA = "1"
             GO TO ERROR-TAJETA-BLOQUEADA.

           MOVE NUM-TARJETA TO LOGIN-TARJ.
           READ LOGINFILE INVALID KEY GO TO ERROR-USUARIO.
           IF USER-PIN = PIN
             MOVE 0 TO NUM-INTENTOS-ACC
             MOVE 0 TO LOGIN-NUM-INTENTOS
             REWRITE REG-LOGIN
             CLOSE USERFILE
             CLOSE LOGINFILE
           ELSE
             MOVE LOGIN-NUM-INTENTOS TO NUM-INTENTOS-ACC
             ADD 1 TO NUM-INTENTOS-ACC
             MOVE NUM-INTENTOS-ACC TO LOGIN-NUM-INTENTOS
             REWRITE REG-LOGIN
             CLOSE USERFILE
             CLOSE LOGINFILE.

*> Procedimiento error-tarjeta-bloqueada
       ERROR-TAJETA-BLOQUEADA.
           CLOSE USERFILE.
           CLOSE LOGINFILE.
           PERFORM RESTAURAR-CAMPOS-ACCESO.

         MUESTRA-MSJ-TARJETA-BLOQUEADA.
	       DISPLAY PANTALLA-TARJETA-BLOQUEADA.
		   PERFORM LEER-TECLA.
			 IF COB-CRT-STATUS NOT = 0
               GO TO MUESTRA-MSJ-TARJETA-BLOQUEADA
             ELSE
               GO TO INICIO.

*> Procedimiento error-usuario
       ERROR-USUARIO.
           CLOSE USERFILE.
           CLOSE LOGINFILE.
           MOVE 0 TO NUM-INTENTOS-ACC.
           MOVE 0 TO PIN.

         MUESTRA-MENSAJE-ERROR-USUARIO.
           DISPLAY PANTALLA-ERROR-USUARIO.

           PERFORM LEER-TECLA.
           IF COB-CRT-STATUS = 2005
             GO TO INICIO
           ELSE
             IF COB-CRT-STATUS = 13
               GO TO LOGIN
             ELSE
               GO TO MUESTRA-MENSAJE-ERROR-USUARIO.

*> Procedimiento error-clave
       ERROR-CLAVE.
         MUESTRA-MENSAJE-ERROR-ACCESO.
           DISPLAY PANTALLA-ERROR-ACCESO.
           PERFORM LEER-TECLA.
           IF COB-CRT-STATUS = 2005
             PERFORM RESTAURAR-CAMPOS-ACCESO
             GO TO INICIO
           ELSE
             IF COB-CRT-STATUS = 0
               MOVE 0 TO PIN
               GO TO LOGIN
             ELSE
               GO TO MUESTRA-MENSAJE-ERROR-ACCESO.

*> Procedimiento bloqueo-tarjeta
       BLOQUEO-TARJETA.
           OPEN I-O USERFILE.
           READ USERFILE.

         MUESTRA-MSJ-BLOQUEO-TARJETA.
           DISPLAY PANTALLA-BLOQUEO-TARJETA.
           PERFORM LEER-TECLA.
           IF COB-CRT-STATUS NOT = 0
             GO TO MUESTRA-MSJ-BLOQUEO-TARJETA
           ELSE
             MOVE 0 TO NUM-INTENTOS-ACC.
             MOVE "1" TO USER-BLOQUEADA

             REWRITE REG-USUARIO
             CLOSE USERFILE
             GO TO INICIO.


*> Procedimiento consultar-saldo
       CONSULTAR-SALDO.
           OPEN INPUT USERFILE.
           READ USERFILE.

         MUESTRA-SALDO.  
		   DISPLAY PANTALLA-CONSULTA-SALDO.
		   PERFORM LEER-TECLA.
           IF COB-CRT-STATUS NOT = 0
             GO TO MUESTRA-SALDO.

           CLOSE USERFILE.
           GO TO MENU-OPCIONES.


*> Procedimiento consultar-movimientos
       CONSULTAR-MOVS.
          MOSTRAR-PANTALLA-MOVS.
		   DISPLAY PANTALLA-CONSULTA-MOVIMIENTOS.
		   ACCEPT PANTALLA-CONSULTA-MOVIMIENTOS
		     IF COB-CRT-STATUS = 2005
		       PERFORM RESTAURAR-CAMPOS-MOVIMIENTOS
		       MOVE " " TO MSJ-MOVS
		       GO TO MENU-OPCIONES.		       
		   
		   PERFORM LEER-TECLA.
           IF COB-CRT-STATUS = 2005
              PERFORM RESTAURAR-CAMPOS-MOVIMIENTOS
		      MOVE " " TO MSJ-MOVS
			  GO TO MENU-OPCIONES
		   ELSE
		      IF COB-CRT-STATUS NOT = 0
				GO TO MOSTRAR-PANTALLA-MOVS
			  ELSE
				GO TO LEER-MOVIMIENTOS.

*> Procedimiento leer-movimientos
       LEER-MOVIMIENTOS.
           COMPUTE CANTIDAD-INICIAL-MOV = (ICENT / 100) + IEUROS.
           COMPUTE CANTIDAD-FINAL-MOV = (FCENT / 100) + FEUROS.

           PERFORM COMPROBAR-FECHAS THRU FIN-COMPROBAR-FECHAS.
           MOVE " " TO MSJ-MOVS.
           PERFORM COMPROBAR-CANTIDADES THRU FIN-COMPROBAR-CANTIDADES.
           MOVE " " TO MSJ-MOVS.

           IF CANTIDAD-INICIAL-MOV = 0
             IF CANTIDAD-FINAL-MOV = 0
               MOVE "NO" TO FILTRAR-POR-CANTIDAD.

           IF DDI = 0
             IF DDF = 0
               IF MMI = 0
                 IF MMF = 0
                     MOVE "NO" TO FILTRAR-POR-FECHA.

           IF FILTRAR-POR-CANTIDAD = "SI"
             IF FILTRAR-POR-FECHA = "SI"
               PERFORM BUSCAR-MOVS-FECHA-CANT
                                THRU FIN-BUSCAR-MOVS-FECHA-CANT
             ELSE
               PERFORM BUSCAR-MOVS-POR-CANTIDAD
                                THRU FIN-BUSCAR-MOVS-POR-CANTIDAD
           ELSE
             IF FILTRAR-POR-FECHA = "SI"
               PERFORM BUSCAR-MOVS-POR-FECHA
                                THRU FIN-BUSCAR-MOVS-POR-FECHA
             ELSE
               PERFORM BUSCAR-TODOS-MOVS THRU FIN-BUSCAR-TODOS-MOVS.

           DIVIDE 8 INTO NUM-TOTAL-MOV GIVING
                            TOTAL-PANTALLAS-MOV REMAINDER RESTO-MOV.
           IF RESTO-MOV > 0
             ADD 1 TO TOTAL-PANTALLAS-MOV.

           IF NUM-TOTAL-MOV = 0
             GO TO ERROR-MOSTRAR-MOVIMIENTOS.

         MOSTRAR-PANTALLA-MOV.
           COMPUTE NUM-ULTIMO-MOV = NUM-PANTALLA-MOV * 8.
           COMPUTE NUM-PRIMER-MOV = NUM-ULTIMO-MOV - 7.

           DISPLAY PANTALLA-MUESTRA-MOVIMIENTOS.
           PERFORM UNTIL NUM-PRIMER-MOV > NUM-ULTIMO-MOV
                        OR CONCEPTO-D(NUM-PRIMER-MOV) = "FIN"
             ADD 1 TO LINEA-MOV
             DISPLAY LINEA-DETALLE-MOV(NUM-PRIMER-MOV)
               AT LINE NUMBER LINEA-MOV
			 ADD 1 TO NUM-PRIMER-MOV
	       END-PERFORM.
           
           PERFORM LEER-TECLA.
		   IF COB-CRT-STATUS = 2005
		     PERFORM RESTAURAR-CAMPOS-MOVIMIENTOS
			 GO TO MENU-OPCIONES  
		   ELSE
		     IF COB-CRT-STATUS = 2003
		       IF NUM-PANTALLA-MOV = 1
				 MOVE 12 TO LINEA-MOV
				 GO TO MOSTRAR-PANTALLA-MOV
			   ELSE
			     SUBTRACT 1 FROM NUM-PANTALLA-MOV
				 MOVE 12 TO LINEA-MOV
				 GO TO MOSTRAR-PANTALLA-MOV
		     ELSE
		       IF COB-CRT-STATUS = 2004
		         IF NUM-PANTALLA-MOV = TOTAL-PANTALLAS-MOV
				   MOVE 12 TO LINEA-MOV
				   GO TO MOSTRAR-PANTALLA-MOV
			     ELSE
			       ADD 1 TO NUM-PANTALLA-MOV
				   MOVE 12 TO LINEA-MOV
				   GO TO MOSTRAR-PANTALLA-MOV
			   ELSE
			     MOVE 12 TO LINEA-MOV
		         GO TO MOSTRAR-PANTALLA-MOV.
       
*> Procedimiento comprobar-fechas
       COMPROBAR-FECHAS.
           COMPUTE FECHA-INICIAL-MOV =
                        (AAI * 10000) + (MMI * 100) + DDI.
           COMPUTE FECHA-FINAL-MOV =
                        (AAF * 10000) + (MMF * 100) + DDF.
           IF FECHA-INICIAL-MOV > FECHA-FINAL-MOV
             MOVE MSJ-ERROR-FECHAS-I-F TO MSJ-MOVS
             GO TO ERROR-FECHA.


           IF DDI >= 1 AND DDI <= 31 AND DDF >= 1 AND DDF <= 31
                    AND MMI <= 12 AND MMI >= 1 AND MMF <= 12
                    AND MMF >= 1
             GO TO FIN-COMPROBAR-FECHAS.

           IF DDI = 0
             IF MMI = 0
               IF AAI = 0
                 IF DDF = 0
                   IF MMF = 0
                     IF AAF = 0
                       GO TO FIN-COMPROBAR-FECHAS.


           MOVE MSJ-ERROR-FORMATO-FECHAS TO MSJ-MOVS.
         ERROR-FECHA.
           MOVE 0 TO DDI.
           MOVE 0 TO MMI.
           MOVE 0 TO AAI.
           MOVE 0 TO DDF.
           MOVE 0 TO MMF.
           MOVE 0 TO AAF.
           GO TO MOSTRAR-PANTALLA-MOVS.
       FIN-COMPROBAR-FECHAS.
           EXIT.

*> Procedimiento comprobar-cantidades
       COMPROBAR-CANTIDADES.
           IF CANTIDAD-INICIAL-MOV > CANTIDAD-FINAL-MOV
             MOVE MSJ-ERROR-CANT TO MSJ-MOVS
             MOVE 0 TO IEUROS
             MOVE 0 TO ICENT
             MOVE 0 TO FEUROS
             MOVE 0 TO FCENT
             GO TO MOSTRAR-PANTALLA-MOVS.
       FIN-COMPROBAR-CANTIDADES.
             EXIT.

*> Procedimiento buscar-todos-los-movimientos
       BUSCAR-TODOS-MOVS.
           MOVE 0 TO NUM-TOTAL-MOV.
           MOVE 1 TO J.
           OPEN INPUT MOVFILE.
         INICIO-OBTENER-TODOS-MOVS.
           READ MOVFILE NEXT RECORD
                    AT END GO TO FIN-CONTAR-TODOS-MOVS.
           IF CUENTA-SELECCIONADA = MOV-ID
             ADD 1 TO NUM-TOTAL-MOV
             MOVE MOV-FECHA TO FECHA-D(J)
             MOVE MOV-CONCEPTO TO CONCEPTO-D(J)
             MOVE MOV-CANTIDAD TO CANTIDAD-D(J)
             MOVE MOV-SALDO TO SALDO-CUENTA-D(J)
             ADD 1 TO J.
           GO TO INICIO-OBTENER-TODOS-MOVS.

         FIN-CONTAR-TODOS-MOVS.
           MOVE "FIN" TO CONCEPTO-D(J).
           CLOSE MOVFILE.
         FIN-BUSCAR-TODOS-MOVS.

*> Procedimiento buscar-movimientos-por-cantidad
       BUSCAR-MOVS-POR-CANTIDAD.
           MOVE 0 TO NUM-TOTAL-MOV.
           MOVE 1 TO J.
           OPEN INPUT MOVFILE.
         INICIO-OBTENER-MOVS-POR-CANT.
           READ MOVFILE NEXT RECORD
                  AT END GO TO FIN-CONTAR-MOVS-POR-CANT.
           MOVE MOV-CANTIDAD TO CANTIDAD-MOV.
           IF CUENTA-SELECCIONADA = MOV-ID
             IF CANTIDAD-MOV >= CANTIDAD-INICIAL-MOV
               IF CANTIDAD-MOV <= CANTIDAD-FINAL-MOV
                 ADD 1 TO NUM-TOTAL-MOV
                 MOVE MOV-FECHA TO FECHA-D(J)
                 MOVE MOV-CONCEPTO TO CONCEPTO-D(J)
                 MOVE MOV-CANTIDAD TO CANTIDAD-D(J)
                 MOVE MOV-SALDO TO SALDO-CUENTA-D(J)
                 ADD 1 TO J.
           GO TO INICIO-OBTENER-MOVS-POR-CANT.

         FIN-CONTAR-MOVS-POR-CANT.
           MOVE "FIN" TO CONCEPTO-D(J)
           CLOSE MOVFILE.
         FIN-BUSCAR-MOVS-POR-CANTIDAD.

*> Procedimiento buscar-movimientos-por-fecha
       BUSCAR-MOVS-POR-FECHA.
           MOVE 0 TO NUM-TOTAL-MOV.
           MOVE 1 TO J.
           COMPUTE FECHA-INICIAL-MOV =
                        (AAI * 10000) + (MMI * 100) + DDI.
           COMPUTE FECHA-FINAL-MOV =
                        (AAF * 10000) + (MMF * 100) + DDF.

           OPEN INPUT MOVFILE.
         INICIO-OBTENER-MOVS-POR-FECHA.
           READ MOVFILE NEXT RECORD
                  AT END GO TO FIN-CONTAR-MOVS-POR-FECHA.

           IF CUENTA-SELECCIONADA = MOV-ID
            COMPUTE FECHA-MOV = (AAM * 10000) + (MMM * 100) + DDM
            IF FECHA-MOV >= FECHA-INICIAL-MOV
              IF FECHA-MOV <= FECHA-FINAL-MOV
                ADD 1 TO NUM-TOTAL-MOV
                MOVE MOV-FECHA TO FECHA-D(J)
                MOVE MOV-CONCEPTO TO CONCEPTO-D(J)
                MOVE MOV-CANTIDAD TO CANTIDAD-D(J)
                MOVE MOV-SALDO TO SALDO-CUENTA-D(J)
                ADD 1 TO J.
           GO TO INICIO-OBTENER-MOVS-POR-FECHA.

          FIN-CONTAR-MOVS-POR-FECHA.
           MOVE "FIN" TO CONCEPTO-D(J).
           CLOSE MOVFILE.
         FIN-BUSCAR-MOVS-POR-FECHA.

*> Procedimiento buscar-movimientos-por-cantidad-y-fecha
       BUSCAR-MOVS-FECHA-CANT.
           MOVE 0 TO NUM-TOTAL-MOV.
           MOVE 1 TO J.
           COMPUTE FECHA-INICIAL-MOV =
                    (AAI * 10000) + (MMI * 100) + DDI.
           COMPUTE FECHA-FINAL-MOV =
                    (AAF * 10000) + (MMF * 100) + DDF.

           OPEN INPUT MOVFILE.
         INICIO-OBTENER-MOVS-FECHA-CANT.
           READ MOVFILE NEXT RECORD
               AT END GO TO FIN-CONTAR-MOVS-FECHA-CANT.
           MOVE MOV-CANTIDAD TO CANTIDAD-MOV.

           IF CUENTA-SELECCIONADA = MOV-ID
             IF CANTIDAD-MOV >= CANTIDAD-INICIAL-MOV
               IF CANTIDAD-MOV <= CANTIDAD-FINAL-MOV
                 COMPUTE FECHA-MOV =
                            (AAM * 10000) + (MMM * 100) + DDM
                 IF FECHA-MOV >= FECHA-INICIAL-MOV
                   IF FECHA-MOV <= FECHA-FINAL-MOV
                     ADD 1 TO NUM-TOTAL-MOV
                     MOVE MOV-FECHA TO FECHA-D(J)
                     MOVE MOV-CONCEPTO TO CONCEPTO-D(J)
                     MOVE MOV-CANTIDAD TO CANTIDAD-D(J)
                     MOVE MOV-SALDO TO SALDO-CUENTA-D(J)
                     ADD 1 TO J.
           GO TO INICIO-OBTENER-MOVS-FECHA-CANT.

         FIN-CONTAR-MOVS-FECHA-CANT.
           MOVE "FIN" TO CONCEPTO-D(J).
           CLOSE MOVFILE.
         FIN-BUSCAR-MOVS-FECHA-CANT.

*> Procedimiento error-mostrar-movimientos
       ERROR-MOSTRAR-MOVIMIENTOS.
           PERFORM RESTAURAR-CAMPOS-MOVIMIENTOS.
         MOSTRAR-ERROR-MOVS.
           DISPLAY PANTALLA-SIN-MOVIMIENTOS
           PERFORM LEER-TECLA
           IF COB-CRT-STATUS NOT = 0
             GO TO MOSTRAR-ERROR-MOVS
           ELSE
             GO TO MENU-OPCIONES.

*> Procedimiento restaurar-campos-movimientos
       RESTAURAR-CAMPOS-MOVIMIENTOS.
           MOVE 12 TO LINEA-MOV.
           MOVE "SI" TO FILTRAR-POR-FECHA.
           MOVE "SI" TO FILTRAR-POR-CANTIDAD.
           MOVE 1 TO NUM-PANTALLA-MOV.
           MOVE 0 TO NUM-TOTAL-MOV.
           DISPLAY "ESTOY AQUI. MENUDO FALLO."
           MOVE 0 TO IEUROS.
           MOVE 0 TO ICENT.
           MOVE 0 TO FEUROS.
           MOVE 0 TO FCENT.
           MOVE 0 TO DDI.
           MOVE 0 TO MMI.
           MOVE 0 TO AAI.
           MOVE 0 TO DDF.
           MOVE 0 TO MMF.
           MOVE 0 TO AAF.


*> Procedimiento retirar-efectivo
       RETIRAR-EFECTIVO.
           OPEN I-O USERFILE.
           READ USERFILE.

         MOSTRAR-PANTALLA-RE.
           DISPLAY PANTALLA-RETIRAR-EFECTIVO.
           ACCEPT PANTALLA-RETIRAR-EFECTIVO
             IF COB-CRT-STATUS = 2005
               MOVE 0 TO EUROSR
               MOVE 0 TO CENTR
               CLOSE USERFILE
               GO TO MENU-OPCIONES.

           PERFORM LEER-TECLA.
           IF COB-CRT-STATUS = 2005
             MOVE 0 TO EUROSR
             MOVE 0 TO CENTR
             CLOSE USERFILE
             GO TO MENU-OPCIONES
           ELSE
             IF COB-CRT-STATUS NOT = 0
               GO TO MOSTRAR-PANTALLA-RE.

           COMPUTE DINERO-A-SACAR = (CENTR / 100) + EUROSR.

           IF DINERO-A-SACAR = 0
             GO TO MOSTRAR-PANTALLA-RE.

           IF DINERO-A-SACAR > SALDO-SELECCIONADO
             MOVE 0 TO EUROSR
             MOVE 0 TO CENTR
             MOVE MSJ-ERROR-RETIRAR TO ERROR-RETIRAR
             GO TO MOSTRAR-PANTALLA-RE
           ELSE
             MOVE " " TO ERROR-RETIRAR.

           COMPUTE SALDO-SELECCIONADO = SALDO-SELECCIONADO - DINERO-A-SACAR.
           MOVE SALDO-SELECCIONADO TO USER-SALDO(SELECCION-CUENTA).
           REWRITE REG-USUARIO.
           CLOSE USERFILE.
           MOVE 0 TO EUROSR.
           MOVE 0 TO CENTR.

           PERFORM GUARDAR-MOV-RETIRAR-EFECTIVO.

         MUESTRA-EFECTIVO-RETIRADO.
		   DISPLAY PANTALLA-EFECTIVO-RETIRADO.
		   PERFORM LEER-TECLA.
           IF COB-CRT-STATUS NOT = 0
             GO TO MUESTRA-EFECTIVO-RETIRADO.

           GO TO MENU-OPCIONES.

*> Procedimiento guardar-movimiento-de-retirar-efectivo
       GUARDAR-MOV-RETIRAR-EFECTIVO.
           OPEN EXTEND MOVFILE.
           COMPUTE CANTIDAD-RET-MOV =
                                DINERO-A-SACAR - (DINERO-A-SACAR * 2).

           MOVE CUENTA-SELECCIONADA TO MOV-ID.
           MOVE "Reintegro" TO MOV-CONCEPTO.
           MOVE CANTIDAD-RET-MOV TO MOV-CANTIDAD.
           MOVE " " TO MOV-CUENTA-DESTINO.
           MOVE SALDO-SELECCIONADO TO MOV-SALDO.
           PERFORM OBTENER-FECHA.
           MOVE FECHAF TO MOV-FECHA.
           MOVE HORAF TO MOV-HORA.
           WRITE REG-MOVIMIENTOS.
           CLOSE MOVFILE.


*> Procedimiento ingresar-efectivo
       INGRESAR-EFECTIVO.
           OPEN I-O USERFILE.
           READ USERFILE.

         MOSTRAR-PANTALLA-INI-INGRESO.
		   DISPLAY PANTALLA-INICIAR-INGRESO.
		   ACCEPT PANTALLA-INICIAR-INGRESO
		    IF COB-CRT-STATUS = 2005
		     MOVE 0 TO EUROSI
			 MOVE 0 TO CENTI
		     CLOSE USERFILE
		     GO TO MENU-OPCIONES.
		  
		  PERFORM LEER-TECLA.
           IF COB-CRT-STATUS = 2005
             MOVE 0 TO EUROSI
             MOVE 0 TO CENTI
             CLOSE USERFILE
             GO TO MENU-OPCIONES
           ELSE
             IF COB-CRT-STATUS NOT = 0
               GO TO MOSTRAR-PANTALLA-INI-INGRESO.

          COMPUTE DINERO-A-INGRESAR = (CENTI / 100) + EUROSI.
          GO TO GESTIONAR-INGRESO.

          MUESTRA-EFECTIVO-INGRESADO.
            DISPLAY PANTALLA-EFECTIVO-INGRESADO.
            PERFORM LEER-TECLA.
			IF COB-CRT-STATUS NOT = 0
              GO TO MUESTRA-EFECTIVO-INGRESADO.
            MOVE 0 TO TOTAL-INGRESADO.
            MOVE 0 TO DINERO-A-INGRESAR.
            GO TO MENU-OPCIONES.

*> Procedimiento gestionar-ingreso
       GESTIONAR-INGRESO.
		    IF DINERO-A-INGRESAR = 0
		      GO TO MOSTRAR-PANTALLA-INI-INGRESO
		    ELSE
		      MOVE 0 TO EUROSI
			  MOVE 0 TO CENTI
		      COMPUTE TOTAL-INGRESADO = TOTAL-INGRESADO 
										+ DINERO-A-INGRESAR.
																			
         MOSTRAR-PANTALLA-INGRESANDO.						
		   DISPLAY PANTALLA-INGRESANDO-EFECTIVO.
		   ACCEPT PANTALLA-INGRESANDO-EFECTIVO
		    IF COB-CRT-STATUS = 2005
			 MOVE 0 TO EUROSI
			 MOVE 0 TO CENTI
			 GO TO FIN-INGRESO.
		  
		   PERFORM LEER-TECLA.
		   IF COB-CRT-STATUS = 2005
		     MOVE 0 TO EUROSI
			 MOVE 0 TO CENTI
			 GO TO FIN-INGRESO
		   ELSE
		     IF COB-CRT-STATUS NOT = 0
			   GO TO MOSTRAR-PANTALLA-INGRESANDO.
		  
		   COMPUTE DINERO-A-INGRESAR = (CENTI / 100) + EUROSI.    

		   IF DINERO-A-INGRESAR = 0
			 GO TO MOSTRAR-PANTALLA-INGRESANDO
		   ELSE
			 COMPUTE TOTAL-INGRESADO = TOTAL-INGRESADO 
									+ DINERO-A-INGRESAR
			 MOVE 0 TO EUROSI
			 MOVE 0 TO CENTI
			 GO TO MOSTRAR-PANTALLA-INGRESANDO.
              
         FIN-INGRESO.
           COMPUTE SALDO-SELECCIONADO = SALDO-SELECCIONADO + TOTAL-INGRESADO.
           MOVE SALDO-SELECCIONADO TO USER-SALDO(SELECCION-CUENTA).
           REWRITE REG-USUARIO.
           CLOSE USERFILE.
           PERFORM GUARDAR-MOV-INGRESAR-EFECTIVO.
           GO TO MUESTRA-EFECTIVO-INGRESADO.

*> Procedimiento guardar-movimiento-ingresar-efectivo
       GUARDAR-MOV-INGRESAR-EFECTIVO.
           OPEN EXTEND MOVFILE.

           MOVE CUENTA-SELECCIONADA TO MOV-ID.
           MOVE "Ingreso" TO MOV-CONCEPTO.
           MOVE TOTAL-INGRESADO TO MOV-CANTIDAD.
           MOVE " " TO MOV-CUENTA-DESTINO.
           MOVE SALDO-SELECCIONADO TO MOV-SALDO.
           PERFORM OBTENER-FECHA.
           MOVE FECHAF TO MOV-FECHA.
           MOVE HORAF TO MOV-HORA.
           WRITE REG-MOVIMIENTOS.
           CLOSE MOVFILE.


*> Procedimiento hacer-transferencia
       HACER-TRANSFERENCIA.
           OPEN I-O USERFILE.
           READ USERFILE.

         MOSTRAR-PANTALLA-TRANSF.
           DISPLAY PANTALLA-ORDENAR-TRANSF.

         ESPERAR-DATOS-TRANSF.
           ACCEPT PANTALLA-ORDENAR-TRANSF
            IF COB-CRT-STATUS = 2005
              PERFORM LIMPIAR-CAMPOS-TRANSFERENCIA
              CLOSE USERFILE
              GO TO MENU-OPCIONES.

           PERFORM LEER-TECLA.
           IF COB-CRT-STATUS = 2005
             PERFORM LIMPIAR-CAMPOS-TRANSFERENCIA
			 CLOSE USERFILE
	         GO TO MENU-OPCIONES
	       ELSE
             IF COB-CRT-STATUS NOT = 0
			   GO TO ESPERAR-DATOS-TRANSF.
           
           COMPUTE DINERO-A-TRANSFERIR = (CENTT / 100) + EUROST. 
           IF SALDO-SELECCIONADO < DINERO-A-TRANSFERIR
             MOVE MSJ-ERROR-TRANSF TO ERROR-TRANSF
             MOVE 0 TO EUROST
             MOVE 0 TO CENTT
             GO TO MOSTRAR-PANTALLA-TRANSF.

         MUESTRA-CONFIRMAR-TRANSF.
           DISPLAY PANTALLA-CONFIRMAR-TRANSF.
           PERFORM LEER-TECLA.
           IF COB-CRT-STATUS = 2005
             PERFORM LIMPIAR-CAMPOS-TRANSFERENCIA
             CLOSE USERFILE
			 GO TO GESTIONAR-TRANSF-CANCELADA
	       ELSE
             IF COB-CRT-STATUS NOT = 0
			   GO TO MUESTRA-CONFIRMAR-TRANSF.
           
		   COMPUTE SALDO-SELECCIONADO = SALDO-SELECCIONADO - DINERO-A-TRANSFERIR.
           MOVE SALDO-SELECCIONADO TO USER-SALDO(SELECCION-CUENTA).
           REWRITE REG-USUARIO.
		   CLOSE USERFILE.
		   PERFORM GUARDAR-MOV-TRANSF-EFECTIVO.
		   
           PERFORM TRANSFERIR-DINERO-CUENTA-DESTINO 
                   THRU FIN-TRANSFERIR-DINERO.

           PERFORM GUARDAR-MOV-TRANSFERENCIA.

		   PERFORM LIMPIAR-CAMPOS-TRANSFERENCIA.
         MUESTRA-TRANS-CONFIRMADA.    
		   DISPLAY PANTALLA-TRANSF-CONFIRMADA.
		   PERFORM LEER-TECLA.
		   IF COB-CRT-STATUS NOT = 0
		     GO TO MUESTRA-TRANS-CONFIRMADA
		   ELSE 
		     GO TO MENU-OPCIONES.

*> Procedimiento transferir-dinero-cuenta-destino
       TRANSFERIR-DINERO-CUENTA-DESTINO.
           OPEN I-O USERFILE.
        
         INICIO-OBTENER-CUENTAS.
           READ USERFILE NEXT RECORD INTO WS-REG-USUARIO
               AT END GO TO FIN-OBTENER-CUENTAS.
           MOVE 1 TO M.
       
           PERFORM TRANSFERIR-DINERO UNTIL M = 4.
       
           GO TO INICIO-OBTENER-CUENTAS.
  
         FIN-OBTENER-CUENTAS.
           CLOSE USERFILE.
         FIN-TRANSFERIR-DINERO.

*> Procedimiento auxiliar que busca la cuenta de un usuario
       TRANSFERIR-DINERO.
           IF WS-USER-NUM-CUENTA(M) = CUENTA-DESTINO  
               COMPUTE WS-USER-SALDO(M) = WS-USER-SALDO(M) + DINERO-A-TRANSFERIR
               MOVE WS-USER-SALDO(M) TO USER-SALDO(M)
               REWRITE REG-USUARIO.
           ADD 1 TO M.
           

*> Procedimiento guardar-movimiento-hacer-transferencia  	   
	   GUARDAR-MOV-TRANSF-EFECTIVO.
	       OPEN EXTEND MOVFILE.       
	       COMPUTE CANTIDAD-TRANSF-MOV = 
				DINERO-A-TRANSFERIR - (DINERO-A-TRANSFERIR * 2).
		   STRING "Transferencia a " TITULAR DELIMITED BY SIZE 
		      INTO CONCEPTO-TRANSF-MOV.
				
	       MOVE CUENTA-SELECCIONADA TO MOV-ID.
		   MOVE CONCEPTO-TRANSF-MOV TO MOV-CONCEPTO.
		   MOVE CANTIDAD-TRANSF-MOV TO MOV-CANTIDAD.
		   MOVE CUENTA-DESTINO TO MOV-CUENTA-DESTINO. 
		   MOVE SALDO-SELECCIONADO TO MOV-SALDO.  
		   PERFORM OBTENER-FECHA.
		   MOVE FECHAF TO MOV-FECHA.
		   MOVE HORAF TO MOV-HORA.
	       WRITE REG-MOVIMIENTOS.
	       CLOSE MOVFILE.

*> Guarda una transferencia como movimiento en la cuenta de destino
       GUARDAR-MOV-TRANSFERENCIA.
           OPEN EXTEND MOVFILE.

           MOVE CUENTA-DESTINO TO MOV-ID.
           MOVE "Transferencia a su favor" TO MOV-CONCEPTO.
           MOVE DINERO-A-TRANSFERIR TO MOV-CANTIDAD.
           MOVE " " TO MOV-CUENTA-DESTINO.
           PERFORM OBTENER-SALDO-CUENTA-DESTINO THRU FIN-OBTENER-SALDO.
           MOVE SALDO-DESTINO TO MOV-SALDO.
           PERFORM OBTENER-FECHA.
           MOVE FECHAF TO MOV-FECHA.
           MOVE HORAF TO MOV-HORA.
           WRITE REG-MOVIMIENTOS.
           CLOSE MOVFILE.

*> Obtiene el saldo de la cuenta de destino para indicarlo en la transferencia
       OBTENER-SALDO-CUENTA-DESTINO.
           OPEN I-O USERFILE.
        
         INICIO-OBTENER-SALDO-CUENTAS.
           READ USERFILE NEXT RECORD INTO WS-REG-USUARIO
               AT END GO TO FIN-OBTENER-SALDO-CUENTAS.
           MOVE 1 TO M.
       
           PERFORM OBTENER-SALDO UNTIL M = 4.
       
           GO TO INICIO-OBTENER-SALDO-CUENTAS.
  
         FIN-OBTENER-SALDO-CUENTAS.
           CLOSE USERFILE.
         FIN-OBTENER-SALDO.

*> Procedimiento auxiliar que busca el saldo de la cuenta de destino
       OBTENER-SALDO.
           IF WS-USER-NUM-CUENTA(M) = CUENTA-DESTINO  
               MOVE WS-USER-SALDO(M) TO SALDO-DESTINO.
           ADD 1 TO M.
	            
*> Procedimiento gestionar-transferencia-cancelada       
       GESTIONAR-TRANSF-CANCELADA.
         MUESTRA-TRANSF-CANCEL.
           DISPLAY PANTALLA-TRANSF-CANCELADA.
           ACCEPT TECLA LINE 25, POSITION 1
                ON EXCEPTION MOVE TECLA TO CODIGO-TECLA.
           IF COB-CRT-STATUS NOT = 0
			 GO TO MUESTRA-TRANSF-CANCEL
		   ELSE
		     GO TO MENU-OPCIONES.
		
*> Procedimiento limpiar-campos-transferencia  			   
       LIMPIAR-CAMPOS-TRANSFERENCIA.
           MOVE " " TO CUENTA-DESTINO.
           MOVE " " TO TITULAR.
           MOVE 0 TO EUROST.
           MOVE 0 TO CENTT.


*> Procedimiento comprar-entradas
       COMPRAR-ENTRADAS.
           PERFORM OBTENER-ESPECTACULOS THRU FIN-OBTENER-ESPECTACULOS.

           DIVIDE 6 INTO NUM-TOTAL-ESPEC GIVING
                          TOTAL-PANTALLAS-ESPEC REMAINDER RESTO-ESPEC.
           IF RESTO-ESPEC > 0
             ADD 1 TO TOTAL-PANTALLAS-ESPEC.

           IF NUM-TOTAL-ESPEC = 0
             GO TO ERROR-MOSTRAR-ESPECTACULOS.

         MOSTRAR-PANTALLA-ESPEC.
           COMPUTE NUM-ULTIMO-ESPEC = NUM-PANTALLA-ESPEC * 6.
           COMPUTE NUM-PRIMER-ESPEC = NUM-ULTIMO-ESPEC - 5.

           DISPLAY PANTALLA-MUESTRA-ESPECTACULOS.
           PERFORM UNTIL NUM-PRIMER-ESPEC > NUM-ULTIMO-ESPEC
             ADD 1 TO LINEA-ESPEC
             DISPLAY LINEA-DETALLE-ESPEC(NUM-PRIMER-ESPEC) 
               AT LINE NUMBER LINEA-ESPEC
			 ADD 1 TO NUM-PRIMER-ESPEC 
	       END-PERFORM.
           
           PERFORM LEER-TECLA.
		   IF COB-CRT-STATUS = 2005
		     PERFORM RESTAURAR-CAMPOS-ESPEC
			 GO TO MENU-OPCIONES  
		   ELSE
		     IF COB-CRT-STATUS = 2003
		       IF NUM-PANTALLA-ESPEC = 1
				 MOVE 12 TO LINEA-ESPEC
				 GO TO MOSTRAR-PANTALLA-ESPEC
			   ELSE
			     SUBTRACT 1 FROM NUM-PANTALLA-ESPEC
				 MOVE 12 TO LINEA-ESPEC
				 GO TO MOSTRAR-PANTALLA-ESPEC
		     ELSE
		       IF COB-CRT-STATUS = 2004
		         IF NUM-PANTALLA-ESPEC = TOTAL-PANTALLAS-ESPEC
				   MOVE 12 TO LINEA-ESPEC
				   GO TO MOSTRAR-PANTALLA-ESPEC
			     ELSE
			       ADD 1 TO NUM-PANTALLA-ESPEC
				   MOVE 12 TO LINEA-ESPEC
				   GO TO MOSTRAR-PANTALLA-ESPEC
			   ELSE
			     IF COB-CRT-STATUS NOT = 0
			       MOVE 12 TO LINEA-ESPEC
		           GO TO MOSTRAR-PANTALLA-ESPEC
		         ELSE
		           MOVE 12 TO LINEA-ESPEC
		           GO TO GESTION-COMPRA-ENTRADAS.
			
*> Procedimiento obtener-espectaculos            
       OBTENER-ESPECTACULOS.
           MOVE 0 TO NUM-TOTAL-ESPEC.
           MOVE 1 TO I.
           OPEN INPUT ESPECFILE.
         INICIO-OBTENER-ESPEC.
           READ ESPECFILE NEXT RECORD AT END GO TO FIN-CONTAR-ESPEC.

           ADD 1 TO NUM-TOTAL-ESPEC.
           MOVE ESPEC-NUMERO TO NUM-D-ESPEC(I).
           MOVE ESPEC-FECHA TO FECHA-D-ESPEC(I).
           MOVE ESPEC-NOMBRE TO NOMBRE-D-ESPEC(I).
           MOVE ESPEC-DESCRIPCION TO DESCRIPCION-D-ESPEC(I).
           MOVE ESPEC-PRECIO-ENTRADA TO PRECIO-D-ESPEC(I).
           MOVE ESPEC-ENT-DISPONIBLES TO ENT-DISPO-D-ESPEC(I).
           ADD 1 TO I.
           GO TO INICIO-OBTENER-ESPEC.

         FIN-CONTAR-ESPEC.
           CLOSE ESPECFILE.
       FIN-OBTENER-ESPECTACULOS.

*> Procedimiento gestionar-compra-de-entradas
       GESTION-COMPRA-ENTRADAS.
         MOSTRAR-PANTALLA-COMPRA-ENT.
           COMPUTE NUM-ULTIMO-ESPEC = NUM-PANTALLA-ESPEC * 6.
           COMPUTE NUM-PRIMER-ESPEC = NUM-ULTIMO-ESPEC - 5.
           DISPLAY PANTALLA-COMPRAR-ENTRADAS.
           PERFORM UNTIL NUM-PRIMER-ESPEC > NUM-ULTIMO-ESPEC
             ADD 1 TO LINEA-ESPEC
             DISPLAY LINEA-DETALLE-ESPEC(NUM-PRIMER-ESPEC) 
               AT LINE NUMBER LINEA-ESPEC
			 ADD 1 TO NUM-PRIMER-ESPEC
	       END-PERFORM.
           ACCEPT PANTALLA-COMPRAR-ENTRADAS
            IF COB-CRT-STATUS = 2005
              PERFORM RESTAURAR-CAMPOS-ESPEC
              MOVE " " TO MSJ-COMPRAR-ENTRADAS
              GO TO COMPRAR-ENTRADAS.

           PERFORM LEER-TECLA.
           IF COB-CRT-STATUS = 2005
             PERFORM RESTAURAR-CAMPOS-ESPEC
             MOVE " " TO MSJ-COMPRAR-ENTRADAS
             GO TO COMPRAR-ENTRADAS
	       ELSE
             IF COB-CRT-STATUS NOT = 0
               MOVE 12 TO LINEA-ESPEC
			   GO TO MOSTRAR-PANTALLA-COMPRA-ENT.
		   
		   IF NUM-ENTRADAS = 0
		     MOVE 12 TO LINEA-ESPEC
			 GO TO MOSTRAR-PANTALLA-COMPRA-ENT.
		   
		   PERFORM COMPROBAR-ESPECTACULO
						THRU FIN-COMPROBAR-ESPECTACULO.
		   IF EXISTE-ESPECTACULO = "NO"
		     MOVE MSJ-ERROR-ESPEC TO MSJ-COMPRAR-ENTRADAS
		     PERFORM RESTAURAR-CAMPOS-ESPEC
			 GO TO GESTION-COMPRA-ENTRADAS.
		   	   
		   PERFORM COMPROBAR-ENTRADAS-DISPO
						THRU FIN-COMPROBAR-ENTRADAS-DISPO.
		   IF HAY-ENTRADAS = "NO"
			 MOVE MSJ-ERROR-ENTRADAS TO MSJ-COMPRAR-ENTRADAS
			 PERFORM RESTAURAR-CAMPOS-ESPEC
			 GO TO GESTION-COMPRA-ENTRADAS.
		 
		   PERFORM CALCULAR-COSTE-ENTRADAS 
						THRU FIN-CALCULAR-COSTE-ENTRADAS.
		   IF COSTE-TOTAL-ENTRADAS > SALDO-SELECCIONADO
			 GO TO ERROR-SALDO-ESPEC.
			 
         MOSTRAR-PANTALLA-CONF-COMPRA.   				
		   DISPLAY PANTALLA-CONFIRMAR-COMPRA-ENT.
		   PERFORM LEER-TECLA.
		   IF COB-CRT-STATUS = 2005
			 MOVE " " TO MSJ-COMPRAR-ENTRADAS
			 PERFORM RESTAURAR-CAMPOS-ESPEC
			 GO TO MENU-OPCIONES
		   ELSE
			 IF COB-CRT-STATUS NOT = 0
               GO TO MOSTRAR-PANTALLA-CONF-COMPRA
             ELSE
               GO TO HACER-COMPRA-ENTRADAS.

*> Procedimiento comprobar-espectaculo
       COMPROBAR-ESPECTACULO.
           MOVE NUM-ESPEC TO ESPEC-NUMERO.
           OPEN INPUT ESPECFILE.
           READ ESPECFILE INVALID KEY GO TO ERROR-ESPECTACULO.
           MOVE "SI" TO EXISTE-ESPECTACULO
           GO TO FIN-COMPROBAR-ESPECTACULO.

         ERROR-ESPECTACULO.
           MOVE "NO" TO EXISTE-ESPECTACULO.

       FIN-COMPROBAR-ESPECTACULO.
           CLOSE ESPECFILE.

*> Procedimiento comprobar-entradas-disponibles
       COMPROBAR-ENTRADAS-DISPO.
           OPEN INPUT ESPECFILE.
           READ ESPECFILE.
           IF NUM-ENTRADAS > ESPEC-ENT-DISPONIBLES
             MOVE "NO" TO HAY-ENTRADAS
           ELSE
             MOVE "SI" TO HAY-ENTRADAS.

           CLOSE ESPECFILE.
       FIN-COMPROBAR-ENTRADAS-DISPO.

*> Procedimiento calcular-coste-entradas
       CALCULAR-COSTE-ENTRADAS.
           OPEN INPUT ESPECFILE.
           READ ESPECFILE.
           COMPUTE COSTE-TOTAL-ENTRADAS =
                    ESPEC-PRECIO-ENTRADA * NUM-ENTRADAS.
           CLOSE ESPECFILE.
       FIN-CALCULAR-COSTE-ENTRADAS.

*> Procedimiento hacer-compra-entradas
       HACER-COMPRA-ENTRADAS.
           MOVE NUM-ESPEC TO ESPEC-NUMERO.
           OPEN I-O ESPECFILE.
           READ ESPECFILE.
           SUBTRACT NUM-ENTRADAS FROM ESPEC-ENT-DISPONIBLES.
           REWRITE REG-ESPECTACULO.
           CLOSE ESPECFILE.

           OPEN I-O USERFILE.
           READ USERFILE.
           SUBTRACT COSTE-TOTAL-ENTRADAS FROM SALDO-SELECCIONADO.
           MOVE SALDO-SELECCIONADO TO USER-SALDO(SELECCION-CUENTA).
           REWRITE REG-USUARIO.
           CLOSE USERFILE.
           
           OPEN EXTEND MOVFILE.  
           MOVE NUM-ENTRADAS TO NUM-ENTRADAS-FORMAT. 
           COMPUTE COSTE-TOTAL-ENT-MOV =     
				COSTE-TOTAL-ENTRADAS - (COSTE-TOTAL-ENTRADAS * 2).
		   STRING "Compra " NUM-ENTRADAS-FORMAT " entradas " 
			  ESPEC-NOMBRE DELIMITED BY SIZE INTO CONCEPTO-TRANSF-MOV.
			  		
 	       MOVE CUENTA-SELECCIONADA TO MOV-ID.
		   MOVE CONCEPTO-TRANSF-MOV TO MOV-CONCEPTO.
		   MOVE COSTE-TOTAL-ENT-MOV TO MOV-CANTIDAD.
		   MOVE " " TO MOV-CUENTA-DESTINO. 
		   MOVE SALDO-SELECCIONADO TO MOV-SALDO.  
		   PERFORM OBTENER-FECHA.
		   MOVE FECHAF TO MOV-FECHA.
		   MOVE HORAF TO MOV-HORA.
	       WRITE REG-MOVIMIENTOS.
	       CLOSE MOVFILE.
	     
         MOSTRAR-ENTRADAS-COMPRADAS. 
	       DISPLAY PANTALLA-ENT-ESPEC-COMPRADAS.
	       PERFORM LEER-TECLA.
	       IF COB-CRT-STATUS NOT = 0
			 GO TO MOSTRAR-ENTRADAS-COMPRADAS
	       ELSE
	         PERFORM RESTAURAR-CAMPOS-ESPEC
	         MOVE " " TO MSJ-COMPRAR-ENTRADAS
	         GO TO MENU-OPCIONES.
       
*> Procedimiento error-de-saldo-espectaculos             
       ERROR-SALDO-ESPEC.
         MOSTRAR-ERROR-SALDO-ESPEC.
           DISPLAY PANTALLA-ESPEC-SIN-SALDO
		   PERFORM LEER-TECLA
		   IF COB-CRT-STATUS NOT = 0
		     GO TO MOSTRAR-ERROR-SALDO-ESPEC
		   ELSE
		     MOVE 12 TO LINEA-ESPEC
		     MOVE " " TO MSJ-COMPRAR-ENTRADAS
		     GO TO COMPRAR-ENTRADAS.     

*> Procedimiento restaurar-campos-espectaculos       
       RESTAURAR-CAMPOS-ESPEC.
           MOVE 12 TO LINEA-ESPEC.
           MOVE 1 TO NUM-PANTALLA-ESPEC.
           MOVE 0 TO NUM-ESPEC.
           MOVE 0 TO NUM-ENTRADAS.

*> Procedimiento error-mostrar-espectaculos
       ERROR-MOSTRAR-ESPECTACULOS.
         MOSTRAR-ERROR-ESPEC.
           DISPLAY PANTALLA-SIN-ESPECTACULOS.
           PERFORM LEER-TECLA
           IF COB-CRT-STATUS NOT = 0
             GO TO MOSTRAR-ERROR-ESPEC
           ELSE
             GO TO MENU-OPCIONES.


*> Procedimiento cambiar-clave
       CAMBIAR-CLAVE.
           OPEN I-O USERFILE.
           READ USERFILE.

         MOSTRAR-PANTALLA-CC.
           DISPLAY PANTALLA-CAMBIAR-CLAVE.
           ACCEPT PANTALLA-CAMBIAR-CLAVE
             IF COB-CRT-STATUS = 2005
               CLOSE USERFILE
               GO TO MENU-OPCIONES.

           PERFORM LEER-TECLA.
           IF COB-CRT-STATUS = 2005
             PERFORM LIMPIAR-CAMPOS-CCLAVE
			 CLOSE USERFILE
	         GO TO MENU-OPCIONES
	       ELSE
             IF COB-CRT-STATUS NOT = 0
               PERFORM LIMPIAR-CAMPOS-CCLAVE
               GO TO MOSTRAR-PANTALLA-CC.

           IF CLAVE-ACTUAL NOT = USER-PIN
             PERFORM LIMPIAR-CAMPOS-CCLAVE
             COMPUTE NUM-ERRORES-CACTUAL = NUM-ERRORES-CACTUAL + 1
             IF NUM-ERRORES-CACTUAL = 1
               MOVE ERROR-CLAVE-ACTUAL TO MSJ-ERROR-CCLAVE
               MOVE MSJ-2-INTENTOS TO MSJ-INTENTOS
               DISPLAY PANTALLA-ERROR-CAMBIO-CLAVE
               ACCEPT OP
               GO TO MOSTRAR-PANTALLA-CC
             ELSE
               IF NUM-ERRORES-CACTUAL = 2
                 MOVE ERROR-CLAVE-ACTUAL TO MSJ-ERROR-CCLAVE
                 MOVE MSJ-1-INTENTOS TO MSJ-INTENTOS
                 DISPLAY PANTALLA-ERROR-CAMBIO-CLAVE
                 ACCEPT OP
                 GO TO MOSTRAR-PANTALLA-CC
               ELSE
                 MOVE ERROR-TARJ-BLOQ TO MSJ-ERROR-CCLAVE
                 MOVE MSJ-0-INTENTOS TO MSJ-INTENTOS
                 MOVE "1" TO USER-BLOQUEADA
                 MOVE 0 TO NUM-ERRORES-CNUEVA
                 MOVE 0 TO NUM-ERRORES-CACTUAL
                 DISPLAY PANTALLA-ERROR-CAMBIO-CLAVE
                 ACCEPT OP
                 REWRITE REG-USUARIO
                 CLOSE USERFILE
                 GO TO INICIO
           ELSE
             IF CLAVE-NUEVA NOT = CLAVE-NUEVA-2
               COMPUTE NUM-ERRORES-CNUEVA = NUM-ERRORES-CNUEVA + 1
               IF NUM-ERRORES-CNUEVA = 1
                 MOVE ERROR-CLAVE-NUEVA TO MSJ-ERROR-CCLAVE
                 MOVE MSJ-2-INTENTOS TO MSJ-INTENTOS
                 DISPLAY PANTALLA-ERROR-CAMBIO-CLAVE
                 ACCEPT OP
                 PERFORM LIMPIAR-CAMPOS-CCLAVE
                    GO TO MOSTRAR-PANTALLA-CC
               ELSE
                 IF NUM-ERRORES-CNUEVA = 2
                   MOVE ERROR-CLAVE-NUEVA TO MSJ-ERROR-CCLAVE
                   MOVE MSJ-1-INTENTOS TO MSJ-INTENTOS
                   DISPLAY PANTALLA-ERROR-CAMBIO-CLAVE
                   ACCEPT OP
                   PERFORM LIMPIAR-CAMPOS-CCLAVE
                   GO TO MOSTRAR-PANTALLA-CC
                 ELSE
                   MOVE ERROR-TARJ-BLOQ TO MSJ-ERROR-CCLAVE
                   MOVE MSJ-0-INTENTOS TO MSJ-INTENTOS
                   MOVE "1" TO USER-BLOQUEADA
                   MOVE 0 TO NUM-ERRORES-CNUEVA
                   MOVE 0 TO NUM-ERRORES-CACTUAL
                   DISPLAY PANTALLA-ERROR-CAMBIO-CLAVE
                   ACCEPT OP
                   REWRITE REG-USUARIO
                   CLOSE USERFILE
                   PERFORM LIMPIAR-CAMPOS-CCLAVE
                   GO TO INICIO
             ELSE
               DISPLAY PANTALLA-CLAVE-CAMBIADA
               ACCEPT OP
               MOVE 0 TO NUM-ERRORES-CNUEVA
               MOVE 0 TO NUM-ERRORES-CACTUAL
               MOVE CLAVE-NUEVA TO USER-PIN
               REWRITE REG-USUARIO
               CLOSE USERFILE
               PERFORM LIMPIAR-CAMPOS-CCLAVE
               GO TO MENU-OPCIONES.

*> Procedimiento limpiar-campos-cambio-clave
       LIMPIAR-CAMPOS-CCLAVE.
           MOVE 0 TO CLAVE-ACTUAL.
           MOVE 0 TO CLAVE-NUEVA.
           MOVE 0 TO CLAVE-NUEVA-2.


       END PROGRAM CAJERO.
