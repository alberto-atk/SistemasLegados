/**
 * Wrapper.java
 * <p>
 * Clase encargada de las funcionalidades estrictamente relacionadas con la comunicación con la terminal s3270.
 * <p>
 * Radu Constantin Robu y Alberto Pérez
 */
package P3.Control;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import static java.lang.Thread.sleep;

public class Wrapper {
    public static final String PATRON_OBTENER_SALIDA = "^data: .*";

    public static final String PATRON_DATA = "data:";
    public static final String USERNAME = "PROG";
    public static final String PASSWORD = "PROG123";
    public static final String CADENA_EXIT = "e";
    public static final String WAIT = "wait(";
    public static final int DELAY_WAIT = 5;
    public static final String OUTPUT = ",output)";
    public static final String UNLOCK = ",unlock)";

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
        //TODO HACERLA SINGLETON

    }

    /**
     * Realiza el login en el mainframe.
     *
     * @return
     * @throws InterruptedException
     */


}