package com.company.Control;

public class Tasks2job {
    public static final String NUEVO_FICHERO = "n";
    public static final String SI = "y";
    public static final String GUARDAR = "s";
    public static final String ANYADIR = "a";
    public static final String LISTAR = "l";
    public static final String ELIMINAR = "r";
    public static final String BUSCAR = "t";
    public static final String PATRON_NUMERO = "[+-]?\\d*(\\.\\d+)?";
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
        return 0;
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
