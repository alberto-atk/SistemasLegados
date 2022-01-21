package P3.Modelo;

public class Tarea {
    private String id;
    private String nombre;
    private String descripcion;
    private String fecha;

    public Tarea(String id, String nombre, String descripcion, String fecha) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.fecha = fecha;
    }

    public String getFecha() {
        return fecha;
    }

    public String getId() {
        return id;
    }


    @Override
    public String toString() {
        return  "Num tarea  : " + id + "\n" +
                "Nombre     : " + nombre + "\n" +
                "Descripcion: " + descripcion + "\n" +
                "Fecha      : " + fecha + "\n" + "\n";
    }
}
