package com.company.Control;

import com.company.Modelo.Tarea;
import com.company.Modelo.Tareas;

import java.io.IOException;
import java.util.List;

public class Tasks2job {
    public static final String NUEVO_FICHERO = "n";
    public static final String SI = "y";
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

    private Emulador emulador;
    private Tareas tareas;

    /**
     * Constructor de la clase.
     *
     * @param emulador
     */
    public Tasks2job(Emulador emulador) throws IOException, InterruptedException {
        this.emulador = emulador;
        tareas = new Tareas();
        obtenerTareas();
    }

    /**
     * Comunica con tasks2.job para crear un nuevo fichero de tareas.
     *
     * @return
     */
    public int nuevoFicheroTareas() throws InterruptedException, IOException {
        emulador.login();
        emulador.enviarString(NUEVO_FICHERO);
        emulador.enviarEnter();
        emulador.enviarAscii();
        emulador.enviarString(SI);
        emulador.enviarEnter();
        emulador.enviarEnter();
        emulador.enviarAscii();
        emulador.logout(false);
        return 1;
    }

    /**
     * Comunica con tasks2.job para guardar las tareas.
     *
     * @return
     * @throws InterruptedException
     * @throws IOException
     */
    public int guardarTareas() throws InterruptedException, IOException {
        emulador.login();
        emulador.enviarString(GUARDAR);
        emulador.enviarEnter();
        emulador.enviarEnter();
        emulador.logout(false);
        return 1;
    }

    /**
     * Comunica con tasks2.job para crear una nueva tarea.
     *
     * @param idTarea
     * @param nombreTarea
     * @param descripcionTarea
     * @param fecha
     * @return
     * @throws InterruptedException
     * @throws IOException
     */
    public int anyadirTarea(String idTarea, String nombreTarea,
                            String descripcionTarea, String fecha) throws InterruptedException, IOException {
        int resultado = comprobacionTarea(idTarea, nombreTarea, descripcionTarea);
        if (resultado == 1) {
            int resultadoExisteTarea = tareas.anyadirTarea(idTarea,new Tarea(idTarea,nombreTarea,descripcionTarea,fecha));
            if(resultadoExisteTarea == 1) {
                emulador.login();
                emulador.enviarString(ANYADIR);
                emulador.enviarEnter();
                emulador.enviarString(idTarea);
                emulador.enviarEnter();
                emulador.enviarString(nombreTarea);
                emulador.enviarEnter();
                emulador.enviarString(descripcionTarea);
                emulador.enviarEnter();
                //TODO controlar la fecha en el cliente, formato: dd mm yyyy
                emulador.enviarString(fecha);
                emulador.enviarEnter();
                emulador.enviarEnter();
                emulador.logout(true);
                return 1;
            }else{
                return resultadoExisteTarea;
            }
        } else {
            return resultado;
        }
    }

    /**
     * Realiza las verificaciones necesarias para la información de una tarea.
     *
     * @param idTarea
     * @param nombreTarea
     * @param descripcionTarea
     * @return
     */
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

    /**
     * Comunica con tasks2.job para listar las tareas.
     *
     * @return
     * @throws InterruptedException
     * @throws IOException
     */
    private void obtenerTareas() throws InterruptedException, IOException {
        int codigo_error = 0;
        emulador.login();
        emulador.enviarString(LISTAR);
        emulador.enviarEnter();
        emulador.enviarAscii();
        emulador.enviarEnter();
        List<String> resultado = emulador.obtenerRespuestaMaquina();
        emulador.logout(false);
        parsearTareas(resultado);
    }

    /**
     * Parsea la lista de tareas recibida del mainframe.
     *
     * @param resultado
     * @return
     */
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

    /**
     * Comunica con tasks2.job para eliminar una tarea.
     *
     * @param idTarea
     * @return
     * @throws InterruptedException
     * @throws IOException
     */
    public int eliminarTarea(String idTarea) throws InterruptedException, IOException {
        if (idTarea.matches(PATRON_NUMERO)) {
            int resultadoExisteTarea = tareas.eliminarTarea(idTarea);
            if(resultadoExisteTarea == 1) {
                emulador.login();
                emulador.enviarString(ELIMINAR);
                emulador.enviarEnter();
                emulador.enviarString(idTarea);
                emulador.enviarEnter();
                emulador.enviarString(SI);
                emulador.enviarEnter();
                emulador.enviarEnter();
                emulador.logout(true);
                return 1;
            }else{
                return -2;
            }
        }
        return -1;
    }

    /**
     * Comunica con tasks2.job para buscar las tareas en una fecha concreta.
     *
     * @param fecha
     * @return
     * @throws InterruptedException
     * @throws IOException
     */
    public int buscarTareas(String fecha) throws InterruptedException, IOException {
        List<Tarea> tareasBusqueda = tareas.buscarTareas(fecha.replace(" ","/"));
        if(tareasBusqueda.size() > 0){
            for(Tarea t : tareasBusqueda){
                System.out.println(t.toString());
            }
            return 1;
        }
        return -1;
    }

    public int listarTareas() {
        List<Tarea> tareasBusqueda = tareas.obtenerTareas();
        if(tareasBusqueda.size() > 0){
            for(Tarea t : tareasBusqueda){
                System.out.println(t.toString());
            }
            return 1;
        }
        return -1;
    }
}
