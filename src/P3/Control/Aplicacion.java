package P3.Control;

import P3.Modelo.Tarea;
import P3.Vista.AplicacionVista;
import com.sun.tools.javac.Main;

import java.io.IOException;
import java.util.List;

import static java.lang.Thread.sleep;

public class Aplicacion implements OyenteVista {
    private static Mainframe emulador = null;
    private static TasksJob tasks2 = null;
    private static AplicacionVista vista;

    public static void main(String[] args) throws IOException {
        //new Aplicacion();

        try {

            emulador = Mainframe.getInstance();
            tasks2 = new TasksJob(emulador);

            System.out.println(emulador.conexion("155.210.71.101:323", "PROG", "PROG123"));


            List<Tarea> tareas = tasks2.listarTareas();
            if(tareas.size() != 0) {
                System.out.println(tareas.size());
                for (Tarea t : tareas) {
                    System.out.println(t.toString());
                }
            }else{
                System.out.println("Esta vacio");
            }

            //System.out.println(tasks2.eliminarTarea("455"));
/*

            List<Tarea> tareas2 = tasks2.listarTareas();
            if(tareas2.size() != 0) {
                System.out.println(tareas2.size());
                for (Tarea t : tareas2) {
                    System.out.println(t.toString());
                }
            }else{
                System.out.println("Esta vacio");
            }*/

            //System.out.println(tasks2.guardarTareas());



            System.out.println(tasks2.salir("y"));
            System.out.println(emulador.logout());
        } catch (InterruptedException ex) {
            System.out.println(ex.toString());
        } catch (IOException e) {
            System.out.println(e.toString());
        }
    }

    public Aplicacion() {

        vista = new AplicacionVista(this);
        vista.obtenerDatosInicioSesion();
        /*
        emulador = new Wrapper();

        if(emulador.login("155.210.71.101:323", "PROG", "PROG123")){
            vista.crearElementosVentanaPrincipal()
        }
       */
        vista.crearElementosVentanaPrincipal();

        /*
        Tarea t = new Tarea("a", "a", "s", "s");
        System.out.println(t);
        System.out.println(t);*/
    }

    @Override
    public void eventoProducido(Evento evento, Object obj) {
        switch (evento) {
            /*
            case INICIAR_SESION:
                String[] datos = (String[]) obj;
                for (String dato : datos) {
                    System.out.println(dato);
                }
        }*/
            case SALIR:
                //emulador.logout();
                System.exit(0);
        }
       /*
        try {
            emulador = new Wrapper();
            emulador.login("155.210.71.101:823", "prog", "prog123");

            //emulador.listarTareas();
            //emulador.listarTareas();
            //emulador.anyadirTarea("1","Prueba1","Prueba1", "28 03 2022");
            //emulador.buscarTareas("28 03 2022");

            //emulador.eliminarTarea("999");
            //emulador.guardarTareas();
            //emulador.listarTareas();
            //emulador.buscarTareas("28 03 2022");
            emulador.logout();
        } catch (InterruptedException ex) {
            System.out.println(ex.toString());
        } catch (IOException e) {
            System.out.println(e.toString());
        }
    }*/
    }
}
