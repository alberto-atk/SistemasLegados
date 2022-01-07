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

            //tasks2job.anyadirTarea("999", "Prueba999", "Prueba999", "28 03 2022");
            //tasks2job.listarTareas();
            //tasks2job.eliminarTarea("1");
            //tasks2job.listarTareas();
            //tasks2job.nuevoFicheroTareas();
            //System.out.println(tasks2job.anyadirTarea("30","Prueba30","Prueba30", "28 03 2022"));
            //tasks2job.buscarTarea("10 12 2021");
            //tasks2job.listarTareas();
            //tasks2job.eliminarTarea("999");
            //tasks2job.listarTareas();
            //tasks2job.buscarTarea("10 12 2021");

        } catch (InterruptedException ex) {
            System.out.println(ex.toString());
        } catch (IOException e) {
            System.out.println(e.toString());
        }
    }
}
