package com.company.Control;

import java.io.IOException;

import static java.lang.Thread.sleep;

public class AdministradorTareas {

    public static final String CADENA_CONEXION = "s3270";
    private static Wrapper emulador = null;


    public static void main(String[] args) throws IOException {
        try {
            emulador = new Wrapper(CADENA_CONEXION);

            //tasks2job.listarTareas();
            //tasks2job.eliminarTarea("1");
            //emulador.listarTareas();
            //tasks2job.nuevoFicheroTareas();
            //System.out.println(emulador.anyadirTarea("30","Prueba30","Prueba30", "28 03 2022"));
            //tasks2job.buscarTarea("10 12 2021");
            //emulador.buscarTareas("28 03 2022");

            //System.out.println(emulador.eliminarTarea("2"));
            //emulador.guardarTareas();
            //emulador.listarTareas();
            //emulador.buscarTareas("28 03 2022");

        } catch (InterruptedException ex) {
            System.out.println(ex.toString());
        } catch (IOException e) {
            System.out.println(e.toString());
        }
    }
}
