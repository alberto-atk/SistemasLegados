package P3.Control;

import P3.Modelo.Tarea;

import java.io.IOException;
import java.util.List;

public interface TasksAPI {
    enum CODIGO_ERROR {
        IDTAREA_INCORRECTO,IDTAREA_REPETIDO, OK, NOK
    }


    boolean nuevoFicheroTareas() throws IOException, InterruptedException;

    CODIGO_ERROR anyadirTarea(String idTarea, String nombreTarea, String descripcionTarea, String fecha) throws IOException, InterruptedException;

    CODIGO_ERROR eliminarTarea(String idTarea) throws IOException, InterruptedException;

    List<Tarea> buscarTareas(String fecha) throws IOException, InterruptedException;

    List<Tarea> listarTareas() throws IOException, InterruptedException;

    boolean guardarTareas() throws IOException, InterruptedException;

    boolean salir(String guardarTareas) throws IOException, InterruptedException;

}
