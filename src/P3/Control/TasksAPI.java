/**
 * TasksAPI.java
 * <p>
 * Interfaz para la ejecución de las funciones de la aplicación legada.
 * <p>
 * Radu Constantin Robu y Alberto Pérez
 */
package P3.Control;

import P3.Modelo.Tarea;

import java.io.IOException;
import java.util.List;

public interface TasksAPI {
    enum CODIGO_ERROR {
        IDTAREA_INCORRECTO, IDTAREA_REPETIDO, OK, NOK
    }

    /**
     * Método para crear el nuevo fichero de tarea.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    boolean nuevoFicheroTareas() throws IOException, InterruptedException;

    /**
     * Método para añadir una tarea.
     *
     * @param idTarea
     * @param nombreTarea
     * @param descripcionTarea
     * @param fecha
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    CODIGO_ERROR anyadirTarea(String idTarea, String nombreTarea, String descripcionTarea, String fecha)
            throws IOException, InterruptedException;

    /**
     * Método para eliminar una tarea.
     *
     * @param idTarea
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    CODIGO_ERROR eliminarTarea(String idTarea) throws IOException, InterruptedException;

    /**
     * Método para buscar tareas.
     *
     * @param fecha
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    List<Tarea> buscarTareas(String fecha) throws IOException, InterruptedException;

    /**
     * Método para listar tareas.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    List<Tarea> listarTareas() throws IOException, InterruptedException;

    /**
     * Método para guardar tareas.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    boolean guardarTareas() throws IOException, InterruptedException;

    /**
     * Método para salir.
     *
     * @param guardarTareas
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    boolean salir(String guardarTareas) throws IOException, InterruptedException;

}
