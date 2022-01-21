package P3.Control;

import P3.Modelo.Tarea;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import static java.lang.Thread.sleep;


public class TasksJob implements TasksAPI {
    private static final String NUEVO_FICHERO = "N";
    private static final String GUARDAR = "s";
    private static final String ANYADIR = "a";
    private static final String LISTAR = "l";
    private static final String ELIMINAR = "r";
    private static final String BUSCAR = "t";
    private static final String SI = "y";

    private static final String PATRON_NUMERO = "[+-]?\\d*(\\.\\d+)?";
    public static final String PATRON_IDTAREA = "^data: TASK NUMBER: .*$";
    public static final String PATRON_NOMBRE = "^data: NAME.*$";
    public static final String PATRON_DESCRIPCION = "^data: DESCRIPTION.*$";
    public static final String PATRON_FECHA = "^data: DATE .*$";
    public static final String TEXTO_FECHA = "data: DATE       : ";
    public static final String TEXTO_DESCRIPCION = "data: DESCRIPTION: ";
    public static final String TEXTO_NOMBRE = "data: NAME       : ";
    public static final String TEXTO_ID_TAREA = "data: TASK NUMBER: ";

    public static final String MENSAJE_NUEVO_FICHERO = "**NEW TASK FILE**";
    public static final String FICHERO_TAREAS_CREADO = "NEW TASK FILE HAS BEEN CREATED";
    public static final String MENSAJE_SALIDA = "BYE";
    public static final String MENSAJE_GUARDAR_TAREAS = "SAVE TASKS";
    public static final String MENSAJE_LISTAR_TAREAS = "**LIST TASK**";
    public static final String TAREAS_GUARDADAS = "TASKS HAVE BEEN SAVED";
    public static final String MENSAJE_FIN_LISTA = "**END**";
    public static final String MENSAJE_BUSCAR_TAREAS = "**SEARCH TASK**";

    private Mainframe mainframe;


    public TasksJob(Mainframe mainframe) throws IOException {
        //TODO HACER SINGLETON
        this.mainframe = mainframe;
    }


    /**
     * Opción de tasks2 para crear un nuevo fichero de tareas.
     *
     * @Override
     */
    public boolean nuevoFicheroTareas() throws IOException, InterruptedException {
        if(mainframe.enviarString(NUEVO_FICHERO)){
            if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
                if(mainframe.esperarPantalla(MENSAJE_NUEVO_FICHERO)){
                    if(mainframe.enviarString(SI)){
                        if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
                            if(mainframe.esperarPantalla(FICHERO_TAREAS_CREADO)){
                                if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
                                    return true;
                                }
                            }
                        }
                    }
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
     * @throws IOException
     * @throws InterruptedException
     * @Override
     */
    public CODIGO_ERROR anyadirTarea(String idTarea, String nombreTarea, String descripcionTarea, String fecha)
            throws IOException, InterruptedException{
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


    private CODIGO_ERROR comprobacionAnyadirTarea(String idTarea, String nombre, String descripcion, String fecha)
    throws IOException, InterruptedException{
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
    public CODIGO_ERROR eliminarTarea(String idTarea) throws IOException, InterruptedException {
        if(mainframe.enviarString(ELIMINAR)){
            if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
                if(mainframe.esperarPantalla("**REMOVE TASK**")){
                    if(mainframe.enviarString(idTarea)){
                        if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
                            if(mainframe.esperarPantalla("TASK NOT FOUND")){
                                if(mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)){
                                    return CODIGO_ERROR.IDTAREA_INCORRECTO;
                                }
                            }else if(mainframe.esperarPantalla("CONFIRM (Y/N)")){
                                if(mainframe.enviarString(SI)){
                                    if(mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)){
                                        if(mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)){
                                            return CODIGO_ERROR.OK;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return CODIGO_ERROR.NOK;
    }

    /**
     * Opción de tasks2 para buscar las tareas de una fecha concreta.
     *
     * @param fecha
     * @throws IOException
     * @throws InterruptedException
     * @Override
     */
    public List<Tarea> buscarTareas(String fecha) throws IOException, InterruptedException{
        List<Tarea> tareas = new ArrayList();
        if(mainframe.enviarString(BUSCAR)){
            if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
                if(mainframe.esperarPantalla(MENSAJE_BUSCAR_TAREAS)){
                    if(mainframe.enviarString(fecha)){
                        if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
                            if(mainframe.esperarPantalla(MENSAJE_FIN_LISTA)){
                                if(mainframe.enviarComando(Mainframe.COMANDO_ASCII)){
                                    tareas = obtenerListaTareas();
                                    if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
                                        return tareas;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return tareas;
    }

    /**
     * Opción de tasks2 para listar las tareas.
     *
     * @throws IOException
     * @throws InterruptedException
     * @Override
     */
    public List<Tarea> listarTareas() throws IOException, InterruptedException{
        List<Tarea> tareas = new ArrayList();
        if(mainframe.enviarString(LISTAR)){
           if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
               if(mainframe.esperarPantalla(MENSAJE_LISTAR_TAREAS)){
                   if(mainframe.enviarComando(Mainframe.COMANDO_ASCII)){
                       tareas = obtenerListaTareas();
                       if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
                           return tareas;
                       }
                   }
               }
           }
        }
        return tareas;
    }

    private List<Tarea> obtenerListaTareas() throws IOException {
        String resultado = mainframe.obtenerRespuestaMaquina();
        String[] lineas = resultado.split(System.getProperty("line.separator"));
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
     * @throws IOException
     * @throws InterruptedException
     * @Override
     */
    public boolean guardarTareas() throws IOException, InterruptedException {
        if(mainframe.enviarString(GUARDAR)){
            if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
                if(mainframe.esperarPantalla(TAREAS_GUARDADAS)){
                    if(mainframe.enviarComando(Mainframe.COMANDO_ENTER)){
                        return true;
                    }
                }
            }
        }
        return false;
    }

    /**
     * Termina la comunicación con la terminal s3270.
     *
     * @return
     * @Override
     */
    public boolean salir(String guardarTareas) throws IOException, InterruptedException {
        if(mainframe.enviarString(Mainframe.COMANDO_EXIT)){
            if(mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)){
                if(mainframe.esperarPantalla(MENSAJE_SALIDA)){
                    if(mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)){
                        return true;
                    }
                }else if(mainframe.esperarPantalla(MENSAJE_GUARDAR_TAREAS)){
                    if(mainframe.enviarString(guardarTareas)){
                        if(mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)){
                            if(mainframe.esperarPantalla(MENSAJE_SALIDA)){
                                if(mainframe.enviarComando(MainframeAPI.COMANDO_ENTER)){
                                    return true;
                                }
                            }
                        }
                    }
                }
            }
        }
        return false;
    }

}
