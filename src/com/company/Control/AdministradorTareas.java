package com.company.Control;

import java.io.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import static java.lang.Thread.sleep;
import java.util.logging.Level;
import java.util.logging.Logger;

import static java.lang.Thread.sleep;

public class AdministradorTareas {

    public static final String CADENA_CONEXION = "s3270 155.210.71.101:123";
    private static Emulador emulador = null;

    public static int login() throws InterruptedException {
        emulador.enviarString("PROG");
        emulador.enviarEnter();
        emulador.enviarString("PROG123");
        emulador.enviarEnter();
        emulador.enviarEnter();
        emulador.enviarString("tasks2.job");
        emulador.enviarEnter();
        sleep(2000); //TODO cambiar el delay este y ponerlo bien
        return 0;
    }

    public static int logout(){
        emulador.enviarString("e");
        emulador.enviarEnter();
        emulador.enviarEnter();
        emulador.enviarString("off");
        emulador.enviarEnter();

        return 0;
    }

    public static void main(String[] args) throws IOException {
        try {
            emulador = new Emulador(CADENA_CONEXION);
            emulador.enviarEnter();

            login();

            emulador.enviarAscii();

            logout();

            String resultado = emulador.obtenerRespuestaMaquina();
            System.out.println(resultado);
        } catch (InterruptedException ex) {
            System.out.println(ex.toString());
        }
    }
}
