package P3.Control;

import java.io.*;


public class TasksJob implements TasksAPI {
    private static final String NUEVO_FICHERO = "n";
    private static final String GUARDAR = "s";
    private static final String ANYADIR = "a";
    private static final String LISTAR = "l";
    private static final String ELIMINAR = "r";
    private static final String BUSCAR = "t";
    private static final String SI = "y";

    private static final String PATRON_NUMERO = "[+-]?\\d*(\\.\\d+)?";

    private Mainframe mainframe;


    public TasksJob() throws IOException {
        //TODO HACER SINGLETON
        mainframe = new Mainframe();
    }


    /**
     * Opción de tasks2 para crear un nuevo fichero de tareas.
     *
     * @Override
     */
    public boolean nuevoFicheroTareas() throws IOException {
        // TODO Comprobar si existen tareas y confirmar con usuario el nuevo fichero.
        mainframe.enviarString(NUEVO_FICHERO);
        mainframe.enviarComando(Mainframe.COMANDO_ENTER);
        mainframe.enviarString(SI);
        mainframe.enviarComando(Mainframe.COMANDO_ENTER);
        mainframe.enviarComando(Mainframe.COMANDO_ENTER);
        return true;
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
     * @Override
     */
    public CODIGO_ERROR anyadirTarea(String idTarea, String nombreTarea, String descripcionTarea, String fecha)  throws IOException{
        CODIGO_ERROR resultado = comprobacionAnyadirTarea(idTarea, nombreTarea, descripcionTarea, fecha);
        if (resultado == CODIGO_ERROR.DATOS_TAREA_OK) {
            mainframe.enviarString(ANYADIR);
            mainframe.enviarComando(Mainframe.COMANDO_ENTER);
            mainframe.enviarString(idTarea);
            mainframe.enviarComando(Mainframe.COMANDO_ENTER);
            mainframe.enviarString(nombreTarea);
            mainframe.enviarComando(Mainframe.COMANDO_ENTER);
            mainframe.enviarString(descripcionTarea);
            mainframe.enviarComando(Mainframe.COMANDO_ENTER);
            //TODO controlar la fecha en el cliente, formato: dd mm yyyy
            mainframe.enviarString(fecha);
            mainframe.enviarComando(Mainframe.COMANDO_ENTER);
            mainframe.enviarComando(Mainframe.COMANDO_ENTER);
            return CODIGO_ERROR.OK;
        } else {
            return resultado;
        }
    }


    private CODIGO_ERROR comprobacionAnyadirTarea(String idTarea, String nombre, String descripcion, String fecha) throws IOException{
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

    /**
     * Opción de tasks2 para eliminar una tarea.
     *
     * @param idTarea
     * @Override
     */
    public CODIGO_ERROR eliminarTarea(String idTarea) throws IOException {
        CODIGO_ERROR resultado = comprobacionIDTarea(idTarea);
        if (resultado == CODIGO_ERROR.DATOS_TAREA_OK) {
            mainframe.enviarString(ELIMINAR);
            mainframe.enviarComando(Mainframe.COMANDO_ENTER);
            mainframe.enviarString(idTarea);
            mainframe.enviarComando(Mainframe.COMANDO_ENTER);
            mainframe.enviarString(SI);
            mainframe.enviarComando(Mainframe.COMANDO_ENTER);
            mainframe.enviarComando(Mainframe.COMANDO_ENTER);
            mainframe.enviarComando(Mainframe.COMANDO_ENTER);
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
     * @Override
     */
    public boolean buscarTareas(String fecha) throws IOException{
        mainframe.enviarString(BUSCAR);
        mainframe.enviarComando(Mainframe.COMANDO_ENTER);
        mainframe.enviarString(fecha);
        mainframe.enviarComando(Mainframe.COMANDO_ENTER);
        mainframe.enviarComando(Mainframe.COMANDO_ASCII);
        mainframe.enviarComando(Mainframe.COMANDO_ENTER);
        //List<String> resultado = obtenerRespuestaMaquina();
        //for (String line : resultado) {
        //      System.out.println(line);
        //  }
        return true;

    }

    /**
     * Opción de tasks2 para listar las tareas.
     *
     * @throws IOException
     * @throws InterruptedException
     * @Override
     */
    public boolean listarTareas() throws IOException{
        mainframe.enviarString(LISTAR);
        mainframe.enviarComando(Mainframe.COMANDO_ENTER);
        mainframe.enviarComando(Mainframe.COMANDO_ASCII);
        mainframe.enviarComando(Mainframe.COMANDO_ENTER);
        //List<String> resultado = obtenerRespuestaMaquina();
        //for (String line : resultado) {
        //       System.out.println(line);
        // }
        //parsearTareas(resultado);
        return true;

    }

    /**
     * Opción de tasks2 para guardar las tareas.
     *
     * @throws IOException
     * @throws InterruptedException
     * @Override
     */
    public boolean guardarTareas() throws IOException {
        mainframe.enviarString(GUARDAR);
        mainframe.enviarComando(Mainframe.COMANDO_ENTER);
        mainframe.enviarComando(Mainframe.COMANDO_ENTER);
        return true;

    }

    /**
     * Termina la comunicación con la terminal s3270.
     *
     * @return
     * @Override
     */
    public boolean salir() throws IOException {
        mainframe.enviarString(Mainframe.COMANDO_EXIT);
        return true;
    }

    private CODIGO_ERROR comprobacionIDTarea(String idTarea) {
        if (idTarea.matches(PATRON_NUMERO)) {
            return CODIGO_ERROR.DATOS_TAREA_OK;
        } else {
            return CODIGO_ERROR.IDTAREA_INCORRECTO;
        }
    }

}
