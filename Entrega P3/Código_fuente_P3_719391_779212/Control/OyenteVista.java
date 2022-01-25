/**
 * OyenteVista.java
 * <p>
 * Interfaz oyente para la comunicación MVC.
 * <p>
 * Radu Constantin Robu y Alberto Pérez
 */
package P3.Control;

public interface OyenteVista {
    enum Evento {
        INICIAR_SESION, CERRAR_SESION, NUEVO_FICHERO, ANYADIR_TAREA,
        LISTAR_TAREAS, BUSCAR_TAREA, GUARDAR_TAREAS, ELIMINAR_TAREA, SALIR
    }

    /**
     * Llamado para notificar un evento de la interfaz de usuario.
     *
     * @param evento
     * @param obj
     */
    void eventoProducido(Evento evento, Object obj);
}
