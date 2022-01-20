/**
 * OyenteVista.java
 *
 * Interfaz oyente para la comunicación MVC.
 *
 * Radu Constantin Robu y Alberto Pérez
 */
package P3.Control;


/**
 *  Interfaz de oyente para recibir eventos de la interfaz de usuario
 */
public interface OyenteVista {
    enum Evento {
        INICIAR_SESION, CERRAR_SESION, NUEVO_FICHERO, ANYADIR_TAREA, LISTAR_TAREAS, BUSCAR_TAREA,
        GUARDAR_TAREAS, ELIMINAR_TAREA, SALIR
    }

    /**
     *  Llamado para notificar un evento de la interfaz de usuario
     */
    void eventoProducido(Evento evento, Object obj);
}
