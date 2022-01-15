package P3.Control;

import P3.Vista.AplicacionVista;

import java.io.IOException;

import static java.lang.Thread.sleep;

public class Aplicacion implements OyenteVista {
    private static Wrapper emulador = null;
    private static AplicacionVista vista;

    public static void main(String[] args) throws IOException {
        new Aplicacion();
    }

    public Aplicacion() {
        vista = new AplicacionVista(this);
    }

    @Override
    public void eventoProducido(Evento evento, Object obj) {
        switch (evento) {
            case INICIAR_SESION:
                String[] datos = (String[]) obj;
                for (String dato : datos) {
                    System.out.println(dato);
                }
        }
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
