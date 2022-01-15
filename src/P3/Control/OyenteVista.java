/**
 * OyenteVista.java
 * ccatalan (03/2020)
 */
package P3.Control;


/**
 *  Interfaz de oyente para recibir eventos de la interfaz de usuario
 */
public interface OyenteVista {
    public enum Evento {
        INICIAR_SESION, CERRAR_SESION, NUEVO_FICHERO, ANYADIR_TAREA, LISTAR_TAREAS, BUSCAR_TAREA,
        GUARDAR_TAREAS, ELIMINAR_TAREA, SALIR
    }

    /**
     *  Llamado para notificar un evento de la interfaz de usuario
     */
    public void eventoProducido(Evento evento, Object obj);
}
