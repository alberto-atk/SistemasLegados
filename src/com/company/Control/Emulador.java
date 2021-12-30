package com.company.Control;

import java.io.*;

import static java.lang.Thread.sleep;

public class Emulador {
    private Process proceso;
    private PrintWriter out = null;
    private BufferedReader inStream = null;


    public Emulador(String cadenaConexion) throws IOException {
        proceso = Runtime.getRuntime().exec(cadenaConexion);
        inStream = new BufferedReader(new InputStreamReader(proceso.getInputStream()));
        out = new PrintWriter(new OutputStreamWriter(proceso.getOutputStream()));
    }

    public int enviarString(String mensaje){
        try {
            out.println(String.format("String(\"%s\")", mensaje));
            out.flush();
            sleep(1000);
            return 1;
        }catch (InterruptedException e){
            return -1;
        }
    }

    public int enviarEnter(){
        try {
            out.println("enter");
            out.flush();
            sleep(1000);
            return 1;
        }catch (InterruptedException e){
            return -1;
        }
    }

    public int enviarAscii(){
        try {
            out.println("ascii");
            out.flush();
            sleep(1000);
            return 1;
        }catch (InterruptedException e){
            return -1;
        }
    }

    public String obtenerRespuestaMaquina(){
        String resultado = "";
        try {
            for (String line = inStream.readLine(); line != null; line = inStream.readLine()) {
                System.out.println(line);
                resultado = resultado + line;
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

    public int logout(){
        enviarString("e");
        enviarEnter();
        enviarEnter();
        enviarString("off");
        enviarEnter();

        return 0;
    }
}