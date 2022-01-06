package com.company.Control;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import static java.lang.Thread.sleep;

public class Emulador {
    private Process proceso;
    private PrintWriter out = null;
    private BufferedReader inStream = null;
    public static final String PATRON_OBTENER_SALIDA = "^data: .*";



    public Emulador(String cadenaConexion) throws IOException {
        proceso = Runtime.getRuntime().exec(cadenaConexion);
        inStream = new BufferedReader(new InputStreamReader(proceso.getInputStream()));
        out = new PrintWriter(new OutputStreamWriter(proceso.getOutputStream()));
    }

    public int enviarString(String mensaje){
            out.println(String.format("String(\"%s\")", mensaje));
            out.flush();
            return 1;
    }

    public int salir(){
        out.println("exit");
        out.flush();
        return 1;
    }

    public int enviarEnter(){
        try {
            out.println("enter");
            out.flush();
            sleep(750);
            return 1;
        }catch (InterruptedException e){
            return -1;
        }
    }

    public int enviarAscii(){
            out.println("ascii");
            out.flush();
            return 1;

    }

    public List<String> obtenerRespuestaMaquina(){
        List<String> resultado = new ArrayList();
        String line = "";
        try {
            while(inStream.ready() && (line = inStream.readLine()) != null){
                if(line.matches(PATRON_OBTENER_SALIDA)) {
                    resultado.add(line.replace("data:",""));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return resultado;

    }

    public int login() throws InterruptedException {
        enviarString("PROG");
        enviarEnter();
        enviarString("PROG123");
        enviarEnter();
        enviarEnter();
        enviarString("tasks2.job");
        enviarEnter();
        sleep(2000); //TODO cambiar el delay este y ponerlo bien, tambien a su vez cambiar el throws
        return 0;
    }

    public int logout() throws IOException {
        enviarString("e");
        enviarEnter();
        enviarEnter();
        enviarString("off");
        enviarEnter();
        salir();
        out.close();
        inStream.close();

        return 0;
    }
}