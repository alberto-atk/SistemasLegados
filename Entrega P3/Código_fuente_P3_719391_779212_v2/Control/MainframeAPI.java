/**
 * MainframeAPI.java
 * <p>
 * Interfaz que contiene los métodos para el proceso s3270.
 * <p>
 * Radu Constantin Robu y Alberto Pérez
 */
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

    String PATRON_RESPUESTA_MAINFRAME_OK = ".*ok.*";
    String PATRON_RESPUESTA_MAINFRAME_ERROR = ".*error.*";
    String PANTALLA_CONEXION =
            "Multi-User System for Interactive Computing / System Product";
    String PANTALLA_LOGIN = "*MUSIC/SP ESA/390, sign on";
    String PANTALLA_MENU_PRINCIPAL = "--------------------Full Screen " +
            "Interface for MUSIC------------------ Page 1/1";
    String MENSAJE_USUARIO_INCORRECTO = "Userid is not authorized";
    String MENSAJE_CONTRASENYA_INCORRECTA = "Password incorrect! Retry.";
    String MENSAJE_IDIOMA_NO_SOPORTADO =
            "*Your workstation cannot support requested language";
    String MENSAJE_USUARIO_EN_USO =
            "Userid is in use. Type OK to cancel previous session";

    enum RESPUESTAS_INICIO_SESION {
        OK, USUARIO_INCORRECTO, USUARIO_EN_USO, CONTRASENYA_INCORRECTA, NOK
    }

    /**
     * Método para realizar la conexión.
     *
     * @param host
     * @param username
     * @param password
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    RESPUESTAS_INICIO_SESION conexion(String host, String username,
                                      String password)
            throws IOException, InterruptedException;

    /**
     * Método para realizar la desconexión.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    boolean logout() throws IOException, InterruptedException;

    /**
     * Método para enviar un comando a la máquina.
     *
     * @param comando
     * @return
     * @throws IOException
     */
    boolean enviarComando(String comando) throws IOException;

    /**
     * Método para enviar una cadena de texto a la máquina.
     *
     * @param mensaje
     * @return
     * @throws IOException
     */
    boolean enviarString(String mensaje) throws IOException;

    /**
     * Método para sincronizar la aplicación con la máquina.
     *
     * @param lineaABuscar
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    boolean esperarPantalla(String lineaABuscar)
            throws IOException, InterruptedException;

    /**
     * Método para esperar una respuesta de la máquina.
     *
     * @return
     * @throws IOException
     */
    String obtenerRespuestaMaquina() throws IOException;

    /**
     * Método para esperar a ejecutar el siguiente comando.
     *
     * @return
     * @throws IOException
     */
    boolean ejecutarSiguienteComando() throws IOException;
}
