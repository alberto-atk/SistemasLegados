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

    public static int nuevoFicheroTareas(){
        emulador.enviarString("n");
        emulador.enviarEnter();
        emulador.enviarAscii();
        emulador.enviarString("y");
        emulador.enviarEnter();
        emulador.enviarEnter();
        emulador.enviarAscii();
        return 1;
    }

    public static int guardarTareas(){
        emulador.enviarString("s");
        emulador.enviarEnter();
        emulador.enviarEnter();
        return 1;
    }

    public static int comprobacionTarea(String numTarea, String nombreTarea, String descripcionTarea){
        if(numTarea.matches("[+-]?\\d*(\\.\\d+)?")){
            if(nombreTarea.length() > 0 && nombreTarea.length() <= 16){
                if(descripcionTarea.length() > 0 && descripcionTarea.length() <= 32){
                    return 1;
                }else{
                    return -3;
                }
            }else{
                return -2;
            }
        }else{
            return -1;
        }
    }

    public static int anyadirTarea(String numTarea, String nombreTarea, String descripcionTarea, String fecha){
        int resultado = comprobacionTarea(numTarea,nombreTarea,descripcionTarea);
        if( resultado == 1) {
            emulador.enviarString("a");
            emulador.enviarEnter();
            emulador.enviarString(numTarea);
            emulador.enviarEnter();
            emulador.enviarString(nombreTarea);
            emulador.enviarEnter();
            emulador.enviarString(descripcionTarea);
            emulador.enviarEnter();
            //TODO controlar la fecha en el cliente, formato: dd mm yyyy
            emulador.enviarString(fecha);
            emulador.enviarEnter();
            emulador.enviarEnter();
            guardarTareas();
            return 1;
        }else{
            //TODO comprobar errores
            return resultado;
        }
    }

    public static int listarTareas(){
        emulador.enviarString("l");
        emulador.enviarEnter();
        emulador.enviarAscii();
        emulador.enviarEnter();
        return 0;
    }

    public static void main(String[] args) throws IOException {
       try {
            emulador = new Emulador(CADENA_CONEXION);
            emulador.enviarEnter();

            emulador.login();

            //nuevoFicheroTareas();
            //System.out.println(anyadirTarea("1","asdfasdfasdfasdf","asdfasdfasdfasdfasdfasdfasdfasdf", "10 20 2021"));
            listarTareas();

            emulador.logout();
            String resultado = emulador.obtenerRespuestaMaquina();
            System.out.println(resultado);
        } catch (InterruptedException ex) {
            System.out.println(ex.toString());
        }
    }
}
