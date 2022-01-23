/**
 * Aplicación.java
 * <p>
 * Aplicación con interfaz gráfica para emplear una aplicación legada sobre una máquina mainframe.
 * <p>
 * Radu Constantin Robu y Alberto Pérez
 */
package P3.Control;

import P3.Control.MainframeAPI.RESPUESTAS_INICIO_SESION;
import P3.Modelo.Tarea;
import P3.Modelo.Tupla;
import P3.Vista.AplicacionVista;

import java.io.IOException;
import java.util.List;

public class Aplicacion implements OyenteVista {
    private static final String TITULO_ERROR_FICHERO_TAREAS = "Error fichero tareas";
    private static final String MENSAJE_ERROR_FICHERO_TAREAS = "No se ha creado el fichero de tareas.";
    private static final String TITULO_CONFIRMACION_FICHERO_TAREAS = "Nuevo fichero creado";
    private static final String MENSAJE_CONFIRMACION_FICHERO_TAREAS = "Fichero de tareas creado correctamente.";
    private static final String TITULO_ERROR = "ERROR";
    private static final String MENSAJE_ERROR_INESPERADO = "Error inesperado, cierre la app.";
    private static final String TITULO_ERROR_ELIMINAR_TAREA = "Error eliminar tarea";
    private static final String MENSAJE_ERROR_ELIMINAR_TAREA = "Id de la tarea no existe.";
    private static final String TITULO_CONFIRMACION_ELIMINAR_TAREA = "Tarea eliminada";
    private static final String MENSAJE_CONFIRMACION_ELIMINAR_TAREA = "Tarea eliminada correctamente.";
    private static final String TITULO_ERROR_ANYADIR_TAREA = "ID incorrecto";
    private static final String MENSAJE_ERROR_ID_INCORRECTO = "El ID introducido no es correcto.";
    private static final String TITULO_CONFIRMACION_ANYADIR_TAREA = "Tarea añadida";
    private static final String MENSAJE_CONFIRMACION_TAREA_ANYADIDA = "Tarea añadida correctamente.";
    private static final String TITULO_NO_HAY_TAREAS = "No hay tareas";
    private static final String MENSAJE_LISTA_TAREAS_VACIA = "La lista de tareas está vacía.";
    private static final String TITULO_TAREAS_NO_ENCONTRADAS = "No hay tareas";
    private static final String MENSAJE_TAREAS_NO_ENCONTRADAS = "No se han encontrado tareas para la fecha introducida.";
    private static final String TITULO_ERROR_GUARDAR = "Error guardar tareas";
    private static final String MENSAJE_ERROR_GUARDAR = "No se han guardado las tareas.";
    private static final String TITULO_CONFIRMACION_GUARDAR = "Tareas guardadas";
    private static final String MENSAJE_CONFIRMACION_GUARDAR = "Tareas guardadas correctamente.";
    private static final String TITULO_ERROR_CONTRASENYA_INCORRECTA = "Contraseña incorrecta";
    private static final String MENSAJE_ERROR_CONTRASENYA_INCORRECTA = "La contraseña introducida es incorrecta.";
    private static final String TITULO_ERROR_USUARIO_EN_USO = "Usuario en uso";
    private static final String MENSAJE_ERROR_USUARIO_EN_USO = "El usuario introducido ya está conectado a la máquina.";
    private static final String TITULO_ERROR_USUARIO_INCORRECTO = "Usuario incorrecto";
    private static final String MENSAJE_ERROR_USUARIO_INCORRECTO = "El usuario introducido no existe en la máquina.";

    private static Mainframe emulador = null;
    private static TasksJob tasks2 = null;
    private static AplicacionVista vista;

    /**
     * Main del programa.
     *
     * @param args
     * @throws IOException
     * @throws InterruptedException
     */
    public static void main(String[] args) throws IOException, InterruptedException {
        new Aplicacion();
    }

    /**
     * Constructor de la clase.
     *
     * @throws IOException
     * @throws InterruptedException
     */
    public Aplicacion() throws IOException, InterruptedException {
        vista = new AplicacionVista(this);
        String[] datosInicioSesion = vista.obtenerDatosInicioSesion();

        if (datosInicioSesion != null) {
            falloConexion(datosInicioSesion);
        } else {
            System.exit(0);
        }
    }

    /**
     * Verifica la conexión con la máquina.
     *
     * @param datos
     * @throws IOException
     * @throws InterruptedException
     */
    private void falloConexion(String[] datos) throws IOException, InterruptedException {
        emulador = Mainframe.getInstance();
        RESPUESTAS_INICIO_SESION resultadoConexion = emulador.
                conexion(datos[0], datos[1], datos[2]);

        switch (resultadoConexion) {
            case OK:
                tasks2 = new TasksJob(emulador);
                vista.crearElementosVentanaPrincipal();
                break;
            case CONTRASENYA_INCORRECTA:
                vista.notificarMensajeError(TITULO_ERROR_CONTRASENYA_INCORRECTA, MENSAJE_ERROR_CONTRASENYA_INCORRECTA);
                System.exit(0);
                break;
            case USUARIO_EN_USO:
                vista.notificarMensajeError(TITULO_ERROR_USUARIO_EN_USO, MENSAJE_ERROR_USUARIO_EN_USO);
                System.exit(0);
                break;
            case USUARIO_INCORRECTO:
                vista.notificarMensajeError(TITULO_ERROR_USUARIO_INCORRECTO, MENSAJE_ERROR_USUARIO_INCORRECTO);
                System.exit(0);
                break;
            case NOK:
                vista.notificarMensajeError(TITULO_ERROR, MENSAJE_ERROR_INESPERADO);
                System.exit(0);
        }
    }

    /**
     * Método sobreescrito para tratamiento de errores.
     *
     * @param evento
     * @param obj
     */
    @Override
    public void eventoProducido(Evento evento, Object obj) {
        try {
            switch (evento) {
                case NUEVO_FICHERO:
                    nuevoFicheroTareas();
                    break;

                case ANYADIR_TAREA:
                    anyadirTarea(obj);
                    break;

                case ELIMINAR_TAREA:
                    String idTarea = (String) obj;
                    eliminarTarea(idTarea);
                    break;

                case LISTAR_TAREAS:
                    listarTareas();
                    break;

                case BUSCAR_TAREA:
                    String fecha = (String) obj;
                    buscarTarea(fecha);
                    break;

                case GUARDAR_TAREAS:
                    guardarTareas();
                    break;

                case SALIR:
                    String guardarCambios = (String) obj;
                    salir(guardarCambios);

            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * Crear un nuevo fichero de tareas en la aplicación legada.
     *
     * @throws IOException
     * @throws InterruptedException
     */
    public void nuevoFicheroTareas() throws IOException, InterruptedException {
        if (!tasks2.nuevoFicheroTareas()) {
            vista.notificarMensajeError(TITULO_ERROR_FICHERO_TAREAS, MENSAJE_ERROR_FICHERO_TAREAS);
        } else {
            vista.notificarMensajeConfirmacion(TITULO_CONFIRMACION_FICHERO_TAREAS,
                    MENSAJE_CONFIRMACION_FICHERO_TAREAS);
        }
    }

    /**
     * Añade una nueva tarea en la aplicación legada.
     *
     * @param obj
     * @throws IOException
     * @throws InterruptedException
     */
    public void anyadirTarea(Object obj) throws IOException, InterruptedException {
        Tupla<Tupla, Tupla> tuplaTarea = (Tupla<Tupla, Tupla>) obj;
        Tupla<String, String> tuplaIdNombre = tuplaTarea.a;
        Tupla<String, String> tuplaDescFecha = tuplaTarea.b;

        TasksAPI.CODIGO_ERROR codigoAnyadir = tasks2.anyadirTarea(tuplaIdNombre.a, tuplaIdNombre.b,
                tuplaDescFecha.a, tuplaDescFecha.b);

        switch (codigoAnyadir) {
            case NOK:
                vista.notificarMensajeError(TITULO_ERROR, MENSAJE_ERROR_INESPERADO);
                break;
            case IDTAREA_INCORRECTO:
                vista.notificarMensajeError(TITULO_ERROR_ANYADIR_TAREA, MENSAJE_ERROR_ID_INCORRECTO);
                break;
            case OK:
                vista.notificarMensajeConfirmacion(TITULO_CONFIRMACION_ANYADIR_TAREA,
                        MENSAJE_CONFIRMACION_TAREA_ANYADIDA);
                break;
        }
    }

    /**
     * Elimina una tarea de la aplicación legada.
     *
     * @param idTarea
     * @throws IOException
     * @throws InterruptedException
     */
    public void eliminarTarea(String idTarea) throws IOException, InterruptedException {
        TasksAPI.CODIGO_ERROR codigoEliminar = tasks2.eliminarTarea(idTarea);

        switch (codigoEliminar) {
            case NOK:
                vista.notificarMensajeError(TITULO_ERROR, MENSAJE_ERROR_INESPERADO);
                break;
            case IDTAREA_INCORRECTO:
                vista.notificarMensajeError(TITULO_ERROR_ELIMINAR_TAREA, MENSAJE_ERROR_ELIMINAR_TAREA);
                break;
            case OK:
                vista.notificarMensajeConfirmacion(TITULO_CONFIRMACION_ELIMINAR_TAREA,
                        MENSAJE_CONFIRMACION_ELIMINAR_TAREA);
                break;
        }
    }

    /**
     * Lista las tareas de la aplicación legada.
     *
     * @throws IOException
     * @throws InterruptedException
     */
    public void listarTareas() throws IOException, InterruptedException {
        List<Tarea> tareasListar = tasks2.listarTareas();
        String cadenaTareasListar = "";
        if (tareasListar.size() == 0) {
            vista.notificarMensajeError(TITULO_NO_HAY_TAREAS, MENSAJE_LISTA_TAREAS_VACIA);
        } else {
            for (Tarea tarea : tareasListar) {
                cadenaTareasListar += tarea.toString();
            }
            vista.mostrarTareas(cadenaTareasListar);
        }
    }

    /**
     * Busca tareas en la aplicación legada.
     *
     * @param fecha
     * @throws IOException
     * @throws InterruptedException
     */
    public void buscarTarea(String fecha) throws IOException, InterruptedException {
        String cadenaTareasBuscar = "";
        List<Tarea> tareasBuscar = tasks2.buscarTareas(fecha);
        if (tareasBuscar.size() == 0) {
            vista.notificarMensajeError(TITULO_TAREAS_NO_ENCONTRADAS, MENSAJE_TAREAS_NO_ENCONTRADAS);
        } else {
            for (Tarea tarea : tareasBuscar) {
                cadenaTareasBuscar += tarea.toString();
            }
            vista.mostrarTareas(cadenaTareasBuscar);

        }
    }

    /**
     * Guarda las tareas de la aplicación legada.
     *
     * @throws IOException
     * @throws InterruptedException
     */
    public void guardarTareas() throws IOException, InterruptedException {
        if (!tasks2.guardarTareas()) {
            vista.notificarMensajeError(TITULO_ERROR_GUARDAR, MENSAJE_ERROR_GUARDAR);
        } else {
            vista.notificarMensajeConfirmacion(TITULO_CONFIRMACION_GUARDAR, MENSAJE_CONFIRMACION_GUARDAR);
        }
    }

    /**
     * Desconexión de la máquina y cierre de aplicación.
     *
     * @param respuesta
     * @throws IOException
     * @throws InterruptedException
     */
    public void salir(String respuesta) throws IOException, InterruptedException {
        tasks2.salir(respuesta);
        emulador.logout();
        System.exit(0);
    }
}
