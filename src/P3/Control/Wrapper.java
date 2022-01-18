/**
 * Emulador.java
 * <p>
 * Clase encargada de las funcionalidades estrictamente relacionadas con la comunicación con la terminal s3270.
 * <p>
 * Alberto Pérez & Radu Constantin Robu - Diciembre 2021
 */
package P3.Control;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import static java.lang.Thread.sleep;

public class Wrapper {
    public static final String TERMINAL_SIN_PANTALLA = "s3270";
    public static final String CONNECT = "connect ";
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
    public static final String WAIT = "wait(";
    public static final int DELAY_WAIT = 5;
    public static final String OUTPUT = ",output)";
    public static final String UNLOCK = ",unlock)";
    public static final String SI = "y";
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
    public static final Long TIEMPO_EJEC_MAXIMO = 500L;

    private Process proceso;
    private PrintWriter outStream = null;
    private BufferedReader inStream = null;

    private enum CODIGO_ERROR {
        IDTAREA_INCORRECTO,
        NOMBRE_INCORRECTO,
        DESCRIPCION_INCORRECTA,
        FECHA_INCORRECTA,
        DATOS_TAREA_OK,
        OK
    }

    /**
     * Constructor de la clase.
     *
     * @throws IOException
     */
    public Wrapper() throws IOException, InterruptedException {
        proceso = Runtime.getRuntime().exec(TERMINAL_SIN_PANTALLA);
        inStream = new BufferedReader(new InputStreamReader(proceso.getInputStream()));
        outStream = new PrintWriter(new OutputStreamWriter(proceso.getOutputStream()));
    }

    /**
     * Envía una cadena de texto a la terminal s3270.
     *
     * @param mensaje
     * @return
     */
    private boolean enviarString(String mensaje) throws IOException {
        outStream.println(String.format(FORMATO_CADENA_TEXTO, mensaje));
        outStream.flush();
        return ejecutarSiguienteComando();
    }

    /**
     * Envía el comando ENTER a la terminal s3270.
     *
     * @return
     */
    private Boolean enviarEnter() throws IOException {
        outStream.println(COMANDO_ENTER);
        outStream.flush();
        return ejecutarSiguienteComando();
    }

    /**
     * Envía el comando WAIT(output) a la terminal s3270.
     *
     * @return
     */
    private int enviarWaitOutput() {
        outStream.println(WAIT + DELAY_WAIT + OUTPUT);
        outStream.flush();
        return 1;
    }

    /**
     * Envía el comando "ascii" a la terminal s3270 para obtener el vector de string.
     *
     * @return
     */
    private void enviarAscii() throws IOException {
        outStream.println(COMANDO_ASCII);
        outStream.flush();
    }


    private Boolean esperarPantalla(String lineaABuscar) throws IOException, InterruptedException {
        Long maxTime = TIEMPO_EJEC_MAXIMO + System.currentTimeMillis();
        String resultado = "";
        do{
            enviarAscii();
            sleep(50);
            resultado = obtenerRespuestaMaquina();
            if(resultado.contains(lineaABuscar)){
                //System.out.println(resultado);
                return true;
            }

        }while(maxTime > System.currentTimeMillis());
        System.out.println("No hay nada");

        return false;
    }


    /**
     * Obtiene la respuesta textual del mainframe en la terminal s3270.
     *
     * @return
     */
    private String obtenerRespuestaMaquina() throws IOException {
        String resultado = "";
        String line = "";
        do{
            line = inStream.readLine();
            //TODO esto mirar a ver lo del OK y lo de UUC
            resultado += line + "\n";
        } while (inStream.ready());
        return resultado;
    }

    private void conectarHost(String host) throws IOException, InterruptedException {
        outStream.println(CONNECT + host);
        outStream.flush();

    }

    private boolean ejecutarSiguienteComando() throws IOException {
        String line = "";
        Long maxTime = TIEMPO_EJEC_MAXIMO + System.currentTimeMillis();
        while (maxTime > System.currentTimeMillis()) {
            line = inStream.readLine();
            if(line.matches(".*ok.*")){
                return true;
            }
        }
        return false;
        /*
        while(!line.matches(".*ok.*")){
            line = inStream.readLine();
        }
        return true;*/
    }


    /**
     * Realiza el login en el mainframe.
     *
     * @return
     * @throws InterruptedException
     */
    protected int login(String host, String username, String password) throws InterruptedException, IOException {
        conectarHost(host);
        //out.println(CONNECT + host);
        //out.flush();
        if(ejecutarSiguienteComando()) {
            System.out.println("Entro");
            //enviarEnter();
            if (esperarPantalla("data:          Multi-User System for Interactive Computing / System Product           ")) {
                if (enviarEnter()) {
                    if (esperarPantalla("data:  *MUSIC/SP ESA/390, sign on                                                     ")) {
                        if(enviarString(username)){
                            if(enviarEnter()) {
                                if(enviarString(password)){
                                   if(enviarEnter()) {
                                       /* CON ESTO SE REVIENTAN LAS MAQUINAS, 678 MUERTAS
                                       if (esperarPantalla("data: Userid is in use. Type OK to cancel previous session                            ")){
                                           if(enviarString("OK")){
                                               if(enviarEnter()) {
                                                   enviarAscii();
                                                   System.out.println(obtenerRespuestaMaquina());
                                               }
                                           }
                                       }*/
                                   }
                                }
                            }
                        }
                    }
                }
            }
        }
        /*
        enviarEnter();
        enviarString(USERNAME);
        enviarAscii();
        enviarEnter();
        enviarString(PASSWORD);
        enviarAscii();
        enviarEnter();
        enviarEnter();
        enviarString(TASKS2JOB);
        enviarAscii();
        enviarEnter();
        sleep(500);
        */
        return 0;
    }

    /**
     * Realiza la salida controlada del mainframe a través de la terminal s3270.
     *
     * @return
     * @throws IOException
     */
    protected int logout() throws IOException, InterruptedException {
        //enviarString(CADENA_EXIT);
        //enviarEnter();

        enviarString(CADENA_OFF);
        enviarEnter();
        salir();

        return 0;
    }

    /**
     * Termina la comunicación con la terminal s3270.
     *
     * @return
     */
    private int salir() {
        outStream.println(COMANDO_EXIT);
        outStream.flush();
        return 1;
    }


    /**
     * FUNCIONALIDADES TASKS2.JOB
     */

    /**
     * Opción de tasks2 para crear un nuevo fichero de tareas.
     *
     * @throws IOException
     * @throws InterruptedException
     */
    public void nuevoFicheroTareas() throws IOException, InterruptedException {
        // TODO Comprobar si existen tareas y confirmar con usuario el nuevo fichero.
        login("", "", "");
        enviarString(NUEVO_FICHERO);
        enviarEnter();
        enviarAscii();
        enviarString(SI);
        enviarEnter();
        enviarEnter();
        enviarAscii();
        logout();
    }

    /**
     * Opción de tasks2 para añadir una nueva tarea.
     *
     * @param idTarea
     * @param nombreTarea
     * @param descripcionTarea
     * @param fecha
     * @throws IOException
     * @throws InterruptedException
     */
    public CODIGO_ERROR anyadirTarea(String idTarea, String nombreTarea,
                                     String descripcionTarea, String fecha) throws IOException, InterruptedException {
        CODIGO_ERROR resultado = comprobacionAnyadirTarea(idTarea, nombreTarea, descripcionTarea, fecha);
        if (resultado == CODIGO_ERROR.DATOS_TAREA_OK) {
            login("", "", "");
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
            return CODIGO_ERROR.OK;
        } else {
            return resultado;
        }
    }

    /**
     * Opción de tasks2 para eliminar una tarea.
     *
     * @param idTarea
     * @throws IOException
     * @throws InterruptedException
     */
    public CODIGO_ERROR eliminarTarea(String idTarea) throws IOException, InterruptedException {
        CODIGO_ERROR resultado = comprobacionEliminarTarea(idTarea);
        if (resultado == CODIGO_ERROR.DATOS_TAREA_OK) {
            login("", "", "");
            enviarString(ELIMINAR);
            enviarEnter();
            enviarString(idTarea);
            enviarEnter();
            enviarString(SI);
            enviarEnter();
            enviarEnter();
            guardarTarea();
            logout();
            return CODIGO_ERROR.OK;
        } else {
            return resultado;
        }
    }

    /**
     * Opción de tasks2 para buscar las tareas de una fecha concreta.
     *
     * @param fecha
     * @throws IOException
     * @throws InterruptedException
     */
    public void buscarTareas(String fecha) throws IOException, InterruptedException {
        login("", "", "");
        enviarString(BUSCAR);
        enviarEnter();
        enviarString(fecha);
        enviarEnter();
        enviarAscii();
        enviarEnter();
        //List<String> resultado = obtenerRespuestaMaquina();
        logout();
        //for (String line : resultado) {
      //      System.out.println(line);
      //  }
    }

    /**
     * Opción de tasks2 para listar las tareas.
     *
     * @throws IOException
     * @throws InterruptedException
     */
    public void listarTareas() throws IOException, InterruptedException {
        //login("", "", "");
        enviarString(LISTAR);
        enviarEnter();
        enviarAscii();
        enviarEnter();
        //List<String> resultado = obtenerRespuestaMaquina();
        logout();
        //for (String line : resultado) {
     //       System.out.println(line);
       // }
        //parsearTareas(resultado);
    }

    /**
     * Opción de tasks2 para guardar las tareas.
     *
     * @throws IOException
     * @throws InterruptedException
     */
    public void guardarTareas() throws IOException, InterruptedException {
        login("", "", "");
        enviarString(GUARDAR);
        enviarEnter();
        enviarEnter();
        logout();
    }

    /**
     * Guarda de forma implícita una tarea añadida o eliminada.
     */
    private void guardarTarea() throws InterruptedException, IOException {
        enviarString(GUARDAR);
        enviarEnter();
        enviarEnter();
    }


    private CODIGO_ERROR comprobacionAnyadirTarea(String idTarea, String nombre, String descripcion, String fecha) {
        if (idTarea.matches(PATRON_NUMERO)) {
            if (nombre.length() > 0 && nombre.length() <= 16) {
                if (descripcion.length() > 0 && descripcion.length() <= 32) {
                    //TODO TRATAR LA FECHAA
                    return CODIGO_ERROR.DATOS_TAREA_OK;
                } else {
                    return CODIGO_ERROR.DESCRIPCION_INCORRECTA;
                }
            } else {
                return CODIGO_ERROR.NOMBRE_INCORRECTO;
            }
        } else {
            return CODIGO_ERROR.IDTAREA_INCORRECTO;
        }
    }

    private CODIGO_ERROR comprobacionEliminarTarea(String idTarea) {
        if (idTarea.matches(PATRON_NUMERO)) {
            return CODIGO_ERROR.DATOS_TAREA_OK;
        } else {
            return CODIGO_ERROR.IDTAREA_INCORRECTO;
        }

    }

    private void comprobacionBuscarTarea() {
        //TODO TRATAR LA FECHA
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

     */

}