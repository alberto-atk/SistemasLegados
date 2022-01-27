/**
 * TasksJob.java
 * <p>
 * Clase que implementa los métodos para la ejecución de las
 * funciones de la aplicación legada.
 * <p>
 * Radu Constantin Robu y Alberto Pérez
 */
package P3.Control;

import P3.Modelo.Tarea;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class TasksJob implements TasksAPI {
    private static final String NUEVO_FICHERO = "N";
    private static final String GUARDAR = "s";
    private static final String ANYADIR = "a";
    private static final String LISTAR = "l";
    private static final String ELIMINAR = "r";
    private static final String BUSCAR = "t";
    private static final String SI = "y";

    private static final String PATRON_IDTAREA = "^data: TASK NUMBER: .*$";
    private static final String PATRON_NOMBRE = "^data: NAME.*$";
    private static final String PATRON_DESCRIPCION = "^data: DESCRIPTION.*$";
    private static final String PATRON_FECHA = "^data: DATE .*$";
    private static final String TEXTO_FECHA = "data: DATE       : ";
    private static final String TEXTO_DESCRIPCION = "data: DESCRIPTION: ";
    private static final String TEXTO_NOMBRE = "data: NAME       : ";
    private static final String TEXTO_ID_TAREA = "data: TASK NUMBER: ";

    private static final String MENU_TASKS2 = "**MENU**";
    private static final String PANTALLA_NUEVO_FICHERO_TAREAS =
            "**NEW TASK FILE**";
    private static final String FICHERO_TAREAS_CREADO =
            "NEW TASK FILE HAS BEEN CREATED";
    private static final String MENSAJE_SALIDA = "BYE";
    private static final String PANTALLA_GUARDAR_TAREAS = "SAVE TASKS";
    private static final String PANTALLA_LISTAR_TAREAS = "**LIST TASK**";
    private static final String TAREAS_GUARDADAS = "TASKS HAVE BEEN SAVED";
    private static final String FIN_LISTA = "**END**";
    private static final String PANTALLA_BUSCAR_TAREAS = "**SEARCH TASK**";
    private static final String MENSAJE_CONFIRMAR_ELIMINAR = "CONFIRM (Y/N)";
    private static final String PANTALLA_TAREA_NO_ENCONTRADA = "TASK NOT FOUND";
    private static final String PANTALLA_ELIMINAR_TAREA = "**REMOVE TASK**";
    private static final String PANTALLA_ANYADIR_TAREA = "**ADD TASK**";

    private Mainframe mainframe;

    /**
     * Constructor de la clase.
     *
     * @param mainframe
     * @throws IOException
     */
    public TasksJob(Mainframe mainframe) throws IOException {
        this.mainframe = mainframe;
    }

    /**
     * Opción de tasks2 para crear un nuevo fichero de tareas.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    @Override
    public boolean nuevoFicheroTareas()
            throws IOException, InterruptedException {
        if (mainframe.enviarString(NUEVO_FICHERO)) {
            if (mainframe.enviarComando(Mainframe.COMANDO_ENTER)) {
                if (enviarRespuestaConfirmacion() && ficheroTareasCreado()) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Método auxiliar para enviar al emulador la confirmación para crear un
     * nuevo fichero de tareas.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean enviarRespuestaConfirmacion()
            throws IOException, InterruptedException {
        if (mainframe.esperarPantalla(PANTALLA_NUEVO_FICHERO_TAREAS)) {
            if (mainframe.enviarString(SI)) {
                if (mainframe.enviarComando(Mainframe.COMANDO_ENTER)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Método auxiliar para esperar la pantalla de confirmación de la
     * creación del fichero de tareas.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean ficheroTareasCreado()
            throws IOException, InterruptedException {
        if (mainframe.esperarPantalla(FICHERO_TAREAS_CREADO)) {
            if (mainframe.enviarComando(Mainframe.COMANDO_ENTER)) {
                if (mainframe.esperarPantalla(MENU_TASKS2)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Opción de tasks2 para añadir una nueva tarea.
     *
     * @param idTarea
     * @param nombreTarea
     * @param descripcionTarea
     * @param fecha
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    @Override
    public CODIGO_ERROR anyadirTarea(String idTarea, String nombreTarea,
                                     String descripcionTarea, String fecha)
            throws IOException, InterruptedException {
        CODIGO_ERROR codigo = CODIGO_ERROR.NOK;

        if (existeIdTarea(idTarea)) {
            return CODIGO_ERROR.IDTAREA_REPETIDO;
        }

        if (mainframe.enviarString(ANYADIR)) {
            if (mainframe.enviarComando(Mainframe.COMANDO_ENTER)) {
                if (mainframe.esperarPantalla(PANTALLA_ANYADIR_TAREA)) {
                    codigo = auxiliarEnviarDatosTarea(idTarea, nombreTarea,
                            descripcionTarea, fecha);

                }
            }
        }
        return codigo;
    }

    /**
     * Método auxiliar para enviar los datos de la tarea.
     *
     * @param idTarea
     * @param nombreTarea
     * @param descripcionTarea
     * @param fecha
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    public CODIGO_ERROR auxiliarEnviarDatosTarea(
            String idTarea, String nombreTarea, String
            descripcionTarea,
            String fecha) throws IOException, InterruptedException {
        if (enviarIdTarea(idTarea) &&
                enviarNombreTarea(nombreTarea) &&
                enviarDescripcionTarea(descripcionTarea) &&
                enviarFechaTarea(fecha)) {
            if (esperarPantallaMenu()) {
                return CODIGO_ERROR.OK;
            }
        }
        return CODIGO_ERROR.NOK;
    }

    /**
     * Método auxiliar para enviar al emulador el ID de la tarea.
     *
     * @param idTarea
     * @return
     * @throws IOException
     */
    private boolean enviarIdTarea(String idTarea) throws IOException {
        if (mainframe.enviarString(idTarea)) {
            if (mainframe.enviarComando(Mainframe.COMANDO_ENTER)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Método auxiliar para enviar al emulador el nombre de la tarea.
     *
     * @param nombreTarea
     * @return
     * @throws IOException
     */
    private boolean enviarNombreTarea(String nombreTarea) throws IOException {
        if (mainframe.enviarString(nombreTarea)) {
            if (mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Método auxiliar para enviar al emulador la descripción de la tarea.
     *
     * @param descripcionTarea
     * @return
     * @throws IOException
     */
    private boolean enviarDescripcionTarea(String descripcionTarea)
            throws IOException {
        if (mainframe.enviarString(descripcionTarea)) {
            if (mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Método auxiliar para enviar al emulador la fecha de la tarea.
     *
     * @param fecha
     * @return
     * @throws IOException
     */
    private boolean enviarFechaTarea(String fecha) throws IOException {
        if (mainframe.enviarString(fecha)) {
            if (mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Método auxiliar para esperar la pantalla de menú de la aplicación
     * legada.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean esperarPantallaMenu()
            throws IOException, InterruptedException {
        if (mainframe.enviarComando(Mainframe.COMANDO_ENTER)) {
            if (mainframe.esperarPantalla(MENU_TASKS2)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Verifica si existe ya una tarea con el idTarea introducido.
     *
     * @param idTarea
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean existeIdTarea(String idTarea)
            throws IOException, InterruptedException {
        List<Tarea> tareas = listarTareas();
        for (Tarea t : tareas) {
            if (t.getId().equals(idTarea)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Opción de tasks2 para eliminar una tarea.
     *
     * @param idTarea
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    @Override
    public CODIGO_ERROR eliminarTarea(String idTarea)
            throws IOException, InterruptedException {
        CODIGO_ERROR codigo = CODIGO_ERROR.NOK;

        if (esperarPantallaEliminar()) {
            if (enviarIdTarea(idTarea)) {
                codigo = auxiliarEliminarTarea();
            }
        }
        return codigo;
    }

    /**
     * Método auxiliar que espera la pantalla de eliminación de una tarea.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean esperarPantallaEliminar()
            throws IOException, InterruptedException {
        if (mainframe.enviarString(ELIMINAR)) {
            if (mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)) {
                if (mainframe.esperarPantalla(PANTALLA_ELIMINAR_TAREA)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Método auxiliar para eliminar la tarea.
     *
     * @param idTarea
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    public CODIGO_ERROR auxiliarEliminarTarea()
            throws IOException, InterruptedException {
        if (mainframe.esperarPantalla(PANTALLA_TAREA_NO_ENCONTRADA)) {
            if (esperarPantallaMenu()) {
                return CODIGO_ERROR.IDTAREA_INCORRECTO;
            }
        } else if (esperarConfirmacionEliminar()) {
            return CODIGO_ERROR.OK;
        }
        return CODIGO_ERROR.NOK;
    }

    /**
     * Método auxiliar para esperar la confirmación de la eliminación de la
     * tarea.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean esperarConfirmacionEliminar()
            throws IOException, InterruptedException {
        if (mainframe.esperarPantalla(MENSAJE_CONFIRMAR_ELIMINAR)) {
            if (mainframe.enviarString(SI)) {
                if (mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)) {
                    if (esperarPantallaMenu()) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    /**
     * Opción de tasks2 para buscar las tareas de una fecha concreta.
     *
     * @param fecha
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    @Override
    public List<Tarea> buscarTareas(String fecha)
            throws IOException, InterruptedException {
        List<Tarea> tareas = new ArrayList();
        if (esperarPantallaBuscar()) {
            if (enviarFechaTarea(fecha)) {
                if (empezarLecturaTareas()) {
                    tareas = obtenerListaTareas();
                    if (esperarPantallaMenu()) {
                        return tareas;
                    }
                }
            }
        }
        return tareas;
    }

    /**
     * Método auxiliar que espera la pantalla de búsqueda de tareas.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean esperarPantallaBuscar()
            throws IOException, InterruptedException {
        if (mainframe.enviarString(BUSCAR)) {
            if (mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)) {
                if (mainframe.esperarPantalla(PANTALLA_BUSCAR_TAREAS)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Método auxiliar que empieza la lectura de las tareas de la aplicación
     * legada.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean empezarLecturaTareas()
            throws IOException, InterruptedException {
        if (mainframe.esperarPantalla(FIN_LISTA)) {
            if (mainframe.enviarComando(MainframeAPI.COMANDO_ASCII)) {
                return true;
            }
        }
        return false;
    }


    /**
     * Opción de tasks2 para listar las tareas.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    @Override
    public List<Tarea> listarTareas()
            throws IOException, InterruptedException {
        List<Tarea> tareas = new ArrayList();
        if (esperarPantallaListar()) {
            if (mainframe.enviarComando(Mainframe.COMANDO_ASCII)) {
                tareas = obtenerListaTareas();
                if (mainframe.enviarComando(Mainframe.COMANDO_ENTER)) {
                    if (mainframe.esperarPantalla(MENU_TASKS2)) {
                        return tareas;
                    }
                }
            }
        }
        return tareas;
    }

    /**
     * Método auxiliar que espera la pantalla de listar tareas.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean esperarPantallaListar()
            throws IOException, InterruptedException {
        if (mainframe.enviarString(LISTAR)) {
            if (mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)) {
                if (mainframe.esperarPantalla(PANTALLA_LISTAR_TAREAS)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Obtiene la lista de tareas.
     *
     * @return
     * @throws IOException
     */
    private List<Tarea> obtenerListaTareas() throws IOException {
        String resultado = mainframe.obtenerRespuestaMaquina();
        String[] lineas = resultado.split("\n");
        return parsearTareas(lineas);
    }

    /**
     * Parsea la lista de tareas recibida del mainframe.
     *
     * @param resultado
     * @return
     */
    private List<Tarea> parsearTareas(String[] resultado) {
        String idTarea = "";
        String nombre = "";
        String descripcion = "";
        String fecha = "";
        List<Tarea> tareas = new ArrayList();

        for (String line : resultado) {
            if (line.matches(PATRON_IDTAREA)) {
                idTarea = line.replace(TEXTO_ID_TAREA, "").strip();
            } else if (line.matches(PATRON_NOMBRE)) {
                nombre = line.replace(TEXTO_NOMBRE, "").strip();
            } else if (line.matches(PATRON_DESCRIPCION)) {
                descripcion = line.replace(TEXTO_DESCRIPCION, "").strip();
            } else if (line.matches(PATRON_FECHA)) {
                fecha = line.replace(TEXTO_FECHA, "").strip();
                tareas.add(new Tarea(idTarea, nombre, descripcion, fecha));
            }
        }
        return tareas;
    }

    /**
     * Opción de tasks2 para guardar las tareas.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    @Override
    public boolean guardarTareas()
            throws IOException, InterruptedException {
        if (mainframe.enviarString(GUARDAR)) {
            if (mainframe.enviarComando(Mainframe.COMANDO_ENTER)) {
                if (mainframe.esperarPantalla(TAREAS_GUARDADAS)) {
                    if (mainframe.enviarComando(Mainframe.COMANDO_ENTER)) {
                        if (mainframe.esperarPantalla(MENU_TASKS2)) {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }

    /**
     * Termina la comunicación con la terminal s3270.
     *
     * @param guardarTareas
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    @Override
    public boolean salir(String guardarTareas)
            throws IOException, InterruptedException {
        if (esperarPantallaSalir()) {
            if (realizarSalida()) {
                return true;
            } else if (esperarPantallaGuardar(guardarTareas)) {
                if (realizarSalida()) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Método auxiliar que espera la pantalla de salida de la aplicación
     * legada.
     *
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean esperarPantallaSalir()
            throws IOException, InterruptedException {
        if (mainframe.enviarString(MainframeAPI.COMANDO_EXIT)) {
            if (mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Método auxiliar que sale de la aplicación legada sin guardar cambios.
     *
     * @return
     */
    private boolean realizarSalida()
            throws IOException, InterruptedException {
        if (mainframe.esperarPantalla(MENSAJE_SALIDA)) {
            if (mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Método que espera la pantalla de guardado de tareas.
     *
     * @param guardarTareas
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean esperarPantallaGuardar(String guardarTareas)
            throws IOException, InterruptedException {
        if (mainframe.esperarPantalla(PANTALLA_GUARDAR_TAREAS)) {
            if (mainframe.enviarString(guardarTareas)) {
                if (mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)) {
                    return true;
                }
            }
        }
        return false;
    }
}
