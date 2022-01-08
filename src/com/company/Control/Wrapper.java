/**
 * Emulador.java
 * <p>
 * Clase encargada de las funcionalidades estrictamente relacionadas con la comunicación con la terminal s3270.
 * <p>
 * Alberto Pérez & Radu Constantin Robu - Diciembre 2021
 */
package com.company.Control;

import com.company.Modelo.Tarea;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import static java.lang.Thread.sleep;

public class Wrapper {
    public static final String CADENA_CONECTAR_HOST = "connect 155.210.71.101:823";
    public static final String PATRON_OBTENER_SALIDA = "^data: .*";
    public static final String FORMATO_CADENA_TEXTO = "String(\"%s\")";
    public static final String COMANDO_EXIT = "exit";
    public static final String COMANDO_ENTER = "enter";
    public static final String COMANDO_ASCII = "ascii";
    public static final String PATRON_DATA = "data:";
    public static final String USERNAME = "PROG";
    public static final String PASSWORD = "PROG123";
    public static final String TASKS2JOB = "tasks2.job";
    public static final String CADENA_EXIT = "e";
    public static final String CADENA_OFF = "off";
    public static final int DELAY_ENTER = 750;
    public static final int DELAY_LOGIN_2S = 2000;
    public static final String SI = "y";
    public static final int DELAY_LOGIN_1S = 1000;
    public static final String NUEVO_FICHERO = "n";
    public static final String GUARDAR = "s";
    public static final String ANYADIR = "a";
    public static final String LISTAR = "l";
    public static final String ELIMINAR = "r";
    public static final String BUSCAR = "t";
    public static final String PATRON_NUMERO = "[+-]?\\d*(\\.\\d+)?";
    public static final String PATRON_LISTAR_TAREAS = "^ \\*\\*LIST TASK\\*\\*[ ]*$";
    public static final String PATRON_IDTAREA = "^ TASK NUMBER: .*$";
    public static final String PATRON_NOMBRE = "^ NAME.*$";
    public static final String PATRON_DESCRIPCION = "^ DESCRIPTION.*$";
    public static final String PATRON_FECHA = "^ DATE .*$";
    public static final String TEXTO_FECHA = " DATE       : ";
    public static final String TEXTO_DESCRIPCION = " DESCRIPTION: ";
    public static final String TEXTO_NOMBRE = " NAME       : ";
    public static final String TEXTO_ID_TAREA = " TASK NUMBER: ";

    private Process proceso;
    private PrintWriter out = null;
    private BufferedReader inStream = null;
    private Tasks2job tasks;


    /**
     * Constructor de la clase.
     *
     * @param cadenaConexion
     * @throws IOException
     */
    public Wrapper(String cadenaConexion) throws IOException, InterruptedException {
        proceso = Runtime.getRuntime().exec(cadenaConexion);
        inStream = new BufferedReader(new InputStreamReader(proceso.getInputStream()));
        out = new PrintWriter(new OutputStreamWriter(proceso.getOutputStream()));
    }

    /**
     * Envía una cadena de texto a la terminal s3270.
     *
     * @param mensaje
     * @return
     */
    private int enviarString(String mensaje) {
        out.println(String.format(FORMATO_CADENA_TEXTO, mensaje));
        out.flush();
        return 1;
    }

    /**
     * Envía un ENTER a la terminal s3270.
     *
     * @return
     */
    private int enviarEnter() {
        try {
            out.println(COMANDO_ENTER);
            out.flush();
            sleep(DELAY_ENTER);
            return 1;
        } catch (InterruptedException e) {
            return -1;
        }
    }

    /**
     * Envía el comando "ascii" a la terminal s3270 para obtener el vector de string.
     *
     * @return
     */
    private int enviarAscii() {
        out.println(COMANDO_ASCII);
        out.flush();
        return 1;

    }

    /**
     * Obtiene la respuesta textual del mainframe en la terminal s3270.
     *
     * @return
     */
    private List<String> obtenerRespuestaMaquina() {
        List<String> resultado = new ArrayList();
        String line = "";
        try {
            while (inStream.ready() && (line = inStream.readLine()) != null) {
                if (line.matches(PATRON_OBTENER_SALIDA)) {
                    resultado.add(line.replace(PATRON_DATA, ""));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return resultado;

    }

    /**
     * Realiza el login en el mainframe.
     *
     * @return
     * @throws InterruptedException
     */
    private int login() throws InterruptedException {
        out.println(CADENA_CONECTAR_HOST);
        out.flush();
        sleep(DELAY_LOGIN_1S);
        enviarEnter();
        enviarString(USERNAME);
        enviarEnter();
        enviarString(PASSWORD);
        enviarEnter();
        enviarEnter();
        enviarString(TASKS2JOB);
        enviarEnter();
        sleep(DELAY_LOGIN_2S);
        return 0;
    }

    /**
     * Realiza la salida controlada del mainframe a través de la terminal s3270.
     *
     * @return
     * @throws IOException
     */
    private int logout() throws IOException {
        enviarString(CADENA_EXIT);
        enviarEnter();

        enviarString(CADENA_OFF);
        enviarEnter();
        salir();
        out.close();
        inStream.close();

        return 0;
    }

    /**
     * Termina la comunicación con la terminal s3270.
     *
     * @return
     */
    private int salir() {
        out.println(COMANDO_EXIT);
        out.flush();
        return 1;
    }


    /**
     * FUNCIONALIDADES TASKS2.JOB
     */

    public void nuevoFicheroTareas() throws IOException, InterruptedException {
        // TODO Comprobar si existen tareas y confirmar con usuario el nuevo fichero.
        login();
        enviarString(NUEVO_FICHERO);
        enviarEnter();
        enviarAscii();
        enviarString(SI);
        enviarEnter();
        enviarEnter();
        enviarAscii();
        logout();
    }

    public void anyadirTarea(String idTarea, String nombreTarea,
                            String descripcionTarea, String fecha) throws IOException, InterruptedException {
        login();
        enviarString(ANYADIR);
        enviarEnter();
        enviarString(idTarea);
        enviarEnter();
        enviarString(nombreTarea);
        enviarEnter();
        enviarString(descripcionTarea);
        enviarEnter();
        //TODO controlar la fecha en el cliente, formato: dd mm yyyy
        enviarString(fecha);
        enviarEnter();
        enviarEnter();
        guardarTarea();
        logout();
    }

    private void guardarTarea() {
        enviarString(GUARDAR);
        enviarEnter();
        enviarEnter();
    }


    public void eliminarTarea(String idTarea) throws IOException, InterruptedException {
        login();
        enviarString(ELIMINAR);
        enviarEnter();
        enviarString(idTarea);
        enviarEnter();
        enviarString(SI);
        enviarEnter();
        enviarEnter();
        guardarTarea();
        logout();
    }

    public void buscarTareas(String fecha) throws IOException, InterruptedException {
        tasks.buscarTareas(fecha);
    }

    public void listarTareas() throws IOException, InterruptedException {
        tasks.listarTareas();
    }

    public void guardarTareas() throws IOException, InterruptedException {
        login();
        enviarString(GUARDAR);
        enviarEnter();
        enviarEnter();
        logout();
    }


    /**

    private void obtenerTareas() throws InterruptedException, IOException {
        int codigo_error = 0;
        emulador.login();
        emulador.enviarString(LISTAR);
        emulador.enviarEnter();
        emulador.enviarAscii();
        emulador.enviarEnter();
        List<String> resultado = emulador.obtenerRespuestaMaquina();
        emulador.logout();
        parsearTareas(resultado);
    }
     private void parsearTareas(List<String> resultado) {
        String idTarea = "";
        String nombre = "";
        String descripcion = "";
        String fecha = "";

        for (String line : resultado) {
            if (line.matches(PATRON_IDTAREA)) {
                idTarea = line.replace(TEXTO_ID_TAREA, "").strip();
            } else if (line.matches(PATRON_NOMBRE)) {
                nombre = line.replace(TEXTO_NOMBRE, "").strip();
            } else if (line.matches(PATRON_DESCRIPCION)) {
                descripcion = line.replace(TEXTO_DESCRIPCION, "").strip();
            } else if (line.matches(PATRON_FECHA)) {
                fecha = line.replace(TEXTO_FECHA, "").strip();
                tareas.almacenarTarea(idTarea, new Tarea(idTarea, nombre, descripcion, fecha));
            }
        }
    }
    private int comprobacionTarea(String idTarea, String nombreTarea, String descripcionTarea) {
        if (idTarea.matches(PATRON_NUMERO)) {
            if (nombreTarea.length() > 0 && nombreTarea.length() <= 16) {
                if (descripcionTarea.length() > 0 && descripcionTarea.length() <= 32) {
                    return 1;
                } else {
                    return -3;
                }
            } else {
                return -2;
            }
        } else {
            return -1;
        }
    }
     */

}