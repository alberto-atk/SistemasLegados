package P3.Control;

import java.io.IOException;

public interface MainframeAPI {
    String TERMINAL_SIN_PANTALLA = "s3270";
    Long TIEMPO_EJEC_MAXIMO = 5000L;
    String COMANDO_ENTER = "enter";
    String COMANDO_EXIT = "exit";
    String COMANDO_ASCII = "ascii";
    String CADENA_OFF = "off";
    String FORMATO_CADENA_TEXTO = "String(\"%s\")";
    String CONNECT = "connect ";
    String OK = "ok";
    String PATRON_RESPUESTA_MAINFRAME_OK = ".*ok.*";
    String PATRON_RESPUESTA_MAINFRAME_ERROR = ".*error.*";

    String PANTALLA_CONEXION = "Multi-User System for Interactive Computing / System Product";
    String PANTALLA_LOGIN = "*MUSIC/SP ESA/390, sign on";
    String PANTALLA_MENU_PRINCIPAL = "--------------------Full Screen Interface for MUSIC------------------ Page 1/1";
    String MENSAJE_USUARIO_INCORRECTO = "Userid is not authorized";
    String MENSAJE_CONTRASENYA_INCORRECTA = "Password incorrect! Retry.";
    String MENSAJE_IDIOMA_NO_SOPORTADO = "*Your workstation cannot support requested language";
    String MENSAJE_USUARIO_EN_USO = "Userid is in use. Type OK to cancel previous session";


    int conexion(String host, String username, String password) throws IOException, InterruptedException;

    boolean logout() throws IOException, InterruptedException;

    boolean enviarComando(String comando) throws IOException;

    boolean enviarString(String mensaje) throws IOException;

    boolean esperarPantalla(String lineaABuscar) throws IOException, InterruptedException;

    String obtenerRespuestaMaquina() throws IOException;

}
