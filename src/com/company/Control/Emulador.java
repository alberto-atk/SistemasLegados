/**
 * Emulador.java
 * <p>
 * Clase encargada de las funcionalidades estrictamente relacionadas con la comunicación con la terminal s3270.
 * <p>
 * Alberto Pérez & Radu Constantin Robu - Diciembre 2021
 */
package com.company.Control;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import static java.lang.Thread.sleep;

public class Emulador {
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
    public Emulador(String cadenaConexion) throws IOException {
        proceso = Runtime.getRuntime().exec(cadenaConexion);
        inStream = new BufferedReader(new InputStreamReader(proceso.getInputStream()));
        out = new PrintWriter(new OutputStreamWriter(proceso.getOutputStream()));

        tasks = new Tasks2job(this);
    }

    /**
     * Envía una cadena de texto a la terminal s3270.
     *
     * @param mensaje
     * @return
     */
    public int enviarString(String mensaje) {
        out.println(String.format(FORMATO_CADENA_TEXTO, mensaje));
        out.flush();
        return 1;
    }

    /**
     * Envía un ENTER a la terminal s3270.
     *
     * @return
     */
    public int enviarEnter() {
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
    public int enviarAscii() {
        out.println(COMANDO_ASCII);
        out.flush();
        return 1;

    }

    /**
     * Obtiene la respuesta textual del mainframe en la terminal s3270.
     *
     * @return
     */
    public List<String> obtenerRespuestaMaquina() {
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
    public int login() throws InterruptedException {
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
        sleep(DELAY_LOGIN_2S); //TODO cambiar el delay este y ponerlo bien, tambien a su vez cambiar el throws
        return 0;
    }

    /**
     * Realiza la salida controlada del mainframe a través de la terminal s3270.
     *
     * @return
     * @throws IOException
     */
    public int logout(boolean guardar) throws IOException {
        enviarString(CADENA_EXIT);
        enviarEnter();

        if (guardar) {
            enviarString(SI);
            enviarEnter();
            enviarEnter();
        }

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

    public void nuevoFicheroTareas() throws IOException, InterruptedException {
        // TODO Comprobar si existen tareas y confirmar con usuario el nuevo fichero.
        tasks.nuevoFicheroTareas();
    }

    public void anyadirTarea(String idTarea, String nombreTarea,
                             String descripcionTarea, String fecha) throws IOException, InterruptedException {
        tasks.anyadirTarea(idTarea, nombreTarea, descripcionTarea, fecha);
    }

    public void eliminarTarea(String idTarea) throws IOException, InterruptedException {
        tasks.eliminarTarea(idTarea);
    }

    public void buscarTareas(String fecha) throws IOException, InterruptedException {
        tasks.buscarTarea(fecha);
    }

    public void listarTareas() throws IOException, InterruptedException {
        tasks.listarTareas();
    }

    public void guardarTareas() throws IOException, InterruptedException {
        tasks.guardarTareas();
    }
}