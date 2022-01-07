package com.company.Control;

import java.io.IOException;
import java.util.List;

import static java.lang.Thread.sleep;

public class AdministradorTareas {

    public static final String CADENA_CONEXION = "s3270";
    private static Emulador emulador = null;


    public static void main(String[] args) throws IOException {
        try {
            emulador = new Emulador(CADENA_CONEXION);

            //tasks2job.listarTareas();
            //tasks2job.eliminarTarea("1");
            emulador.listarTareas();
            //tasks2job.nuevoFicheroTareas();
            //System.out.println(emulador.anyadirTarea("30","Prueba30","Prueba30", "28 03 2022"));
            //tasks2job.buscarTarea("10 12 2021");
            //emulador.buscarTareas("28 03 2022");

            //System.out.println(emulador.eliminarTarea("2"));
            //emulador.guardarTareas();
            //tasks2job.listarTareas();
            //emulador.buscarTareas("28 03 2022");

        } catch (InterruptedException ex) {
            System.out.println(ex.toString());
        } catch (IOException e) {
            System.out.println(e.toString());
        }
    }
}
