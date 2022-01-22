/**
 * Tarea.java
 * <p>
 * Clase que representa una tarea de la interfaz gráfica de usuario de la aplicación.
 * <p>
 * Radu Constantin Robu y Alberto Pérez
 */
package P3.Modelo;

public class Tarea {
    private String id;
    private String nombre;
    private String descripcion;
    private String fecha;

    /**
     * Constructor de la clase.
     *
     * @param id
     * @param nombre
     * @param descripcion
     * @param fecha
     */
    public Tarea(String id, String nombre, String descripcion, String fecha) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.fecha = fecha;
    }

    /**
     * Método que devuelve el identificador de la tarea.
     *
     * @return
     */
    public String getId() {
        return id;
    }

    /**
     * Método sobreescrito toString().
     *
     * @return
     */
    @Override
    public String toString() {
        return "Num tarea  : " + id + "\n" +
                "Nombre     : " + nombre + "\n" +
                "Descripcion: " + descripcion + "\n" +
                "Fecha      : " + fecha + "\n" + "\n";
    }
}
