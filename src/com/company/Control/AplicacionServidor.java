package com.company.Control;

import java.io.IOException;

import static java.lang.Thread.sleep;

public class AplicacionServidor {
    private static Wrapper emulador = null;






    public static void main(String[] args) throws IOException {
        try {
            emulador = new Wrapper();


            //emulador.listarTareas();
            //emulador.anyadirTarea("1","Prueba1","Prueba1", "28 03 2022");
            //emulador.buscarTareas("28 03 2022");

            //emulador.eliminarTarea("999");
            //emulador.guardarTareas();
            //emulador.listarTareas();
            emulador.buscarTareas("28 03 2022");

        } catch (InterruptedException ex) {
            System.out.println(ex.toString());
        } catch (IOException e) {
            System.out.println(e.toString());
        }
    }
}