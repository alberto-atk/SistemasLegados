package com.company.Modelo;

import java.util.HashMap;
import java.util.Map;

public class Tareas {
    private Map<String, Tarea> tareas;

    public Tareas() {
        tareas = new HashMap<>();
    }

    public void almacenarTarea(String idString, Tarea tarea) {
        tareas.put(idString, tarea);
    }

    public int anyadirTarea(String idTarea, Tarea tarea) {
        if(!tareas.containsKey(idTarea)){
            tareas.put(idTarea,tarea);
            return 1;
        }else{
            return -1;
        }
    }

    public void eliminarTarea() {

    }
}
