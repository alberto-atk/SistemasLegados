package P3.Control;

import P3.Modelo.Tarea;
import P3.Modelo.Tupla;
import P3.Vista.AplicacionVista;
import com.sun.tools.javac.Main;

import java.io.IOException;
import java.util.List;

import static java.lang.Thread.sleep;

public class Aplicacion implements OyenteVista {
    private static Mainframe emulador = null;
    private static TasksJob tasks2 = null;
    private static AplicacionVista vista;

    public static void main(String[] args) throws IOException, InterruptedException {
        new Aplicacion();
/*
        try {

            emulador = Mainframe.getInstance();
            tasks2 = new TasksJob(emulador);

            System.out.println(emulador.conexion("155.210.71.101:323", "PROG", "PROG123"));


            System.out.println(tasks2.anyadirTarea("6", "prueba5", "prueba5", "10 12 2021"));


            List<Tarea> tareas = tasks2.listarTareas();
            if (tareas.size() != 0) {
                for (Tarea t : tareas) {
                    System.out.println(t.toString());
                }
            } else {
                System.out.println("Esta vacio");
            }



            List<Tarea> tareas2 = tasks2.listarTareas();
            if(tareas2.size() != 0) {
                System.out.println(tareas2.size());
                for (Tarea t : tareas2) {
                    System.out.println(t.toString());
                }
            }else{
                System.out.println("Esta vacio");
            }

            //System.out.println(tasks2.guardarTareas());


            System.out.println(tasks2.salir("y"));
            System.out.println(emulador.logout());
        } catch (InterruptedException ex) {
            System.out.println(ex.toString());
        } catch (IOException e) {
            System.out.println(e.toString());
        }*/
    }

    public Aplicacion() throws IOException, InterruptedException {

        vista = new AplicacionVista(this);
        String[] datosInicioSesion = vista.obtenerDatosInicioSesion();

        emulador = Mainframe.getInstance();

        switch (emulador.conexion(datosInicioSesion[0], datosInicioSesion[1], datosInicioSesion[2])) {
            case 0:
                tasks2 = new TasksJob(emulador);
                vista.crearElementosVentanaPrincipal();
                break;
            //TODO COMPROBAR TODAS POSIBILIDADES
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
                    if (!tasks2.nuevoFicheroTareas()) {
                        vista.notificarMensajeError("Error fichero tareas", "No se ha creado el fichero de tareas.");
                    }
                    break;

                case ANYADIR_TAREA:
                    Tupla<Tupla, Tupla> tuplaTarea = (Tupla<Tupla, Tupla>) obj;
                    Tupla<String, String> tuplaIdNombre = tuplaTarea.a;
                    Tupla<String, String> tuplaDescFecha = tuplaTarea.b;

                    TasksAPI.CODIGO_ERROR codigoAnyadir = tasks2.anyadirTarea(tuplaIdNombre.a, tuplaIdNombre.b,
                            tuplaDescFecha.a, tuplaDescFecha.b);
                    switch (codigoAnyadir) {
                        case NOK:
                            break;
                        case IDTAREA_INCORRECTO:
                            break;
                        case OK:
                            break;
                    }
                    break;

                case ELIMINAR_TAREA:
                    String idTarea = (String) obj;
                    TasksAPI.CODIGO_ERROR codigoEliminar = tasks2.eliminarTarea(idTarea);
                    switch (codigoEliminar) {
                        case NOK:
                            break;
                        case IDTAREA_REPETIDO:
                            break;
                        case OK:
                            break;
                    }
                    break;

                case LISTAR_TAREAS:
                    List<Tarea> tareasListar = tasks2.listarTareas();
                    String cadenaTareasListar = "";
                    if (tareasListar.size() == 0) {
                        System.out.println("Esta vacio");
                    } else {
                        for (Tarea tarea : tareasListar) {
                            System.out.println(tarea.toString());
                            cadenaTareasListar += tarea.toString();
                        }
                        vista.mostrarTareas(cadenaTareasListar);
                    }
                    break;

                case BUSCAR_TAREA:
                    String fecha = (String) obj;
                    String cadenaTareasBuscar = "";
                    List<Tarea> tareasBuscar = tasks2.buscarTareas(fecha);
                    if (tareasBuscar.size() == 0) {

                    } else {
                        for (Tarea tarea : tareasBuscar) {
                            cadenaTareasBuscar += tarea.toString();
                        }
                        vista.mostrarTareas(cadenaTareasBuscar);

                    }
                    break;

                case GUARDAR_TAREAS:
                    if (!tasks2.guardarTareas()) {
                        vista.notificarMensajeError("Error guardar tareas", "No se han guardado las tareas.");
                    }

                case SALIR:
                    String guardarCambios = (String) obj;
                    tasks2.salir(guardarCambios);
                    emulador.logout();
                    System.exit(0);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
