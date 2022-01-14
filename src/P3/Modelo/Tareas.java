package P3.Modelo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Tareas {
    private Map<String, Tarea> tareas;

    public Tareas() {
        tareas = new HashMap<>();
    }

    public void almacenarTarea(String idTarea, Tarea tarea) {
        tareas.put(idTarea, tarea);
    }

    public int anyadirTarea(String idTarea, Tarea tarea) {
        if(!tareas.containsKey(idTarea)){
            tareas.put(idTarea,tarea);
            return 1;
        }else{
            return -1;
        }
    }

    public List<Tarea> buscarTareas(String fecha){
        List<Tarea> tareasBusqueda = new ArrayList<>();
        for(Tarea t: tareas.values()){
            if(t.getFecha().equals(fecha)){
                tareasBusqueda.add(t);
            }
        }
        return tareasBusqueda;
    }

    public List<Tarea> obtenerTareas(){
        List<Tarea> listaTareas = new ArrayList(tareas.values());
        return listaTareas;
    }


    public int eliminarTarea(String idTarea) {
        if(tareas.containsKey(idTarea)){
            tareas.remove(idTarea);
            return 1;
        }else{
            return -1;
        }
    }
}
