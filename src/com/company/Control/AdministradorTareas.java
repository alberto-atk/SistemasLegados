package com.company.Control;

import java.io.IOException;
import java.util.List;

import static java.lang.Thread.sleep;

public class AdministradorTareas {

    public static final String CADENA_CONEXION = "s3270 155.210.71.101:823";
    private static Emulador emulador = null;


    public static void main(String[] args) throws IOException {
       try {
            emulador = new Emulador(CADENA_CONEXION);
            emulador.enviarEnter();

            emulador.login();
            Tasks2job tasks2job = new Tasks2job(emulador);
            //tasks2job.listarTareas();
            //tasks2job.nuevoFicheroTareas();
            //System.out.println(tasks2job.anyadirTarea("1","asdfasdfasdfasdf","asdfasdfasdfasdfasdfasdfasdfasdf", "10 12 2021"));
            //tasks2job.buscarTarea("10 12 2021");
            tasks2job.listarTareas();
            //tasks2job.eliminarTarea("1");
           //tasks2job.listarTareas();
            //tasks2job.buscarTarea("10 12 2021");

            emulador.logout();
           System.exit(0);
       } catch (InterruptedException ex) {
            System.out.println(ex.toString());
        }catch (IOException e){
           System.out.println(e.toString());
       }
    }
}
