package P3.Control;

import java.io.IOException;

public interface TasksAPI {
    enum CODIGO_ERROR {
        IDTAREA_INCORRECTO, NOMBRE_INCORRECTO, DESCRIPCION_INCORRECTA, FECHA_INCORRECTA, DATOS_TAREA_OK, OK
    }


    boolean nuevoFicheroTareas() throws IOException;

    CODIGO_ERROR anyadirTarea(String idTarea, String nombreTarea, String descripcionTarea, String fecha) throws IOException;

    CODIGO_ERROR eliminarTarea(String idTarea) throws IOException;

    boolean buscarTareas(String fecha) throws IOException;

    boolean listarTareas() throws IOException;

    boolean guardarTareas() throws IOException;

    boolean salir() throws IOException;

}
