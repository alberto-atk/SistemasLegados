package com.company.Control;

import com.company.Modelo.Tarea;

import java.util.ArrayList;
import java.util.List;

public class Tasks2job {
    public static final String NUEVO_FICHERO = "n";
    public static final String SI = "y";
    public static final String GUARDAR = "s";
    public static final String ANYADIR = "a";
    public static final String LISTAR = "l";
    public static final String ELIMINAR = "r";
    public static final String BUSCAR = "t";
    public static final String PATRON_NUMERO = "[+-]?\\d*(\\.\\d+)?";
    public static final String PATRON_LISTAR_TAREAS = "^ \\*\\*LIST TASK\\*\\*[ ]*$";
    public static final String PATRON_IDTAREA = "^ TASK NUMBER: .*$";
    public static final String PATRON_NOMBRE = "^ NAME.*$";
    public static final String PATRON_DESCRIPCION = "^ DESCRIPTION.*$";
    public static final String PATRON_FECHA = "^ DATE.*$";
    public static final String TEXTO_FECHA = " DATE       : ";
    public static final String TEXTO_DESCRIPCION = " DESCRIPTION: ";
    public static final String TEXTO_NOMBRE = " NAME       : ";
    public static final String TEXTO_ID_TAREA = " TASK NUMBER: ";


    private Emulador emulador;

    public Tasks2job(Emulador emulador) {
        this.emulador = emulador;
    }


    public int nuevoFicheroTareas(){
        emulador.enviarString(NUEVO_FICHERO);
        emulador.enviarEnter();
        emulador.enviarAscii();
        emulador.enviarString(SI);
        emulador.enviarEnter();
        emulador.enviarEnter();
        emulador.enviarAscii();
        return 1;
    }

    public int guardarTareas(){
        emulador.enviarString(GUARDAR);
        emulador.enviarEnter();
        emulador.enviarEnter();
        return 1;
    }

    public int comprobacionTarea(String idTarea, String nombreTarea, String descripcionTarea){
        if(idTarea.matches(PATRON_NUMERO)){
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

    public int anyadirTarea(String idTarea, String nombreTarea, String descripcionTarea, String fecha){
        int resultado = comprobacionTarea(idTarea,nombreTarea,descripcionTarea);
        if( resultado == 1) {
            emulador.enviarString(ANYADIR);
            emulador.enviarEnter();
            emulador.enviarString(idTarea);
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
            return resultado;
        }
    }

    public int listarTareas(){
        emulador.enviarString(LISTAR);
        emulador.enviarEnter();
        emulador.enviarAscii();
        emulador.enviarEnter();
        List<String> resultado = emulador.obtenerRespuestaMaquina();
        List<Tarea> tareas = parsearListaTareas(resultado);
        if(tareas.size() == 0){
            return 0;
        }else if(tareas.size() > 0){
            for (Tarea tarea :tareas) {
                System.out.println(tarea.toString());
            }
            return 1;
        }else{
            return -1;
        }
    }

    public List<Tarea> parsearListaTareas(List<String> resultado) {
        List<Tarea> tareas = new ArrayList<>();
        String idTarea = "";
        String nombre = "";
        String descripcion = "";
        String fecha = "";

        for (String line : resultado) {
            if (line.matches(PATRON_IDTAREA)) {
                idTarea = line.replace(TEXTO_ID_TAREA, "").strip();
            } else if (line.matches(PATRON_NOMBRE)) {
                nombre = line.replace(TEXTO_NOMBRE, "").strip();
            } else if (line.matches(PATRON_DESCRIPCION)) {
                descripcion = line.replace(TEXTO_DESCRIPCION, "").strip();
            } else if (line.matches(PATRON_FECHA)) {
                fecha = line.replace(TEXTO_FECHA, "").strip();
                tareas.add(new Tarea(idTarea, nombre, descripcion, fecha));
            }
        }
        return tareas;
    }

    public int eliminarTarea(String idTarea){
        if(idTarea.matches(PATRON_NUMERO)) {
            emulador.enviarString(ELIMINAR);
            emulador.enviarEnter();
            emulador.enviarString(idTarea);
            emulador.enviarEnter();
            emulador.enviarString(SI);
            emulador.enviarEnter();
            emulador.enviarEnter();
            guardarTareas();
            return 1;
        }else {
            return 0;
        }
    }

    public int buscarTarea(String fecha){
        emulador.enviarString(BUSCAR);
        emulador.enviarEnter();
        emulador.enviarString(fecha);
        emulador.enviarEnter();
        emulador.enviarAscii();
        emulador.enviarEnter();
        return 1;
    }

}
