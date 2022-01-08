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

    private Wrapper emulador;
    private Tareas tareas;

    /**
     * Constructor de la clase.
     *
     * @param emulador
     */
    public Tasks2job(Wrapper emulador) throws IOException, InterruptedException {
        this.emulador = emulador;
        tareas = new Tareas();
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
        emulador.logout();
        return 1;
    }

    /**
     * Comunica con tasks2.job para guardar las tareas.
     *
     * @return
     * @throws InterruptedException
     * @throws IOException
     */
    public int opcionGuardarTareas() throws InterruptedException, IOException {
        emulador.login();
        emulador.enviarString(GUARDAR);
        emulador.enviarEnter();
        emulador.enviarEnter();
        emulador.logout();
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
            int resultadoExisteTarea = tareas.anyadirTarea(idTarea, new Tarea(idTarea, nombreTarea, descripcionTarea, fecha));
            if (resultadoExisteTarea == 1) {
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
                emulador.logout();
                return 1;
            } else {
                return resultadoExisteTarea;
            }
        } else {
            return resultado;
        }
    }

    private void guardarTarea() {
        emulador.enviarString(GUARDAR);
        emulador.enviarEnter();
        emulador.enviarEnter();

    }

    /**
     * Realiza las verificaciones necesarias para la información de una tarea.
     *
     * @param idTarea
     * @param nombreTarea
     * @param descripcionTarea
     * @return
     */




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
            if (resultadoExisteTarea == 1) {
                emulador.login();
                emulador.enviarString(ELIMINAR);
                emulador.enviarEnter();
                emulador.enviarString(idTarea);
                emulador.enviarEnter();
                emulador.enviarString(SI);
                emulador.enviarEnter();
                emulador.enviarEnter();
                emulador.logout();
                return 1;
            } else {
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
        List<Tarea> tareasBusqueda = tareas.buscarTareas(fecha.replace(" ", "/"));
        if (tareasBusqueda.size() > 0) {
            for (Tarea t : tareasBusqueda) {
                System.out.println(t.toString());
            }
            return 1;
        }
        return -1;
    }

    public int listarTareas() {
        List<Tarea> tareasBusqueda = tareas.obtenerTareas();
        if (tareasBusqueda.size() > 0) {
            for (Tarea t : tareasBusqueda) {
                System.out.println(t.toString());
            }
            return 1;
        }
        return -1;
    }
}
