/**
 * AplicacionVista.java
 * <p>
 * Clase que representa la vista de la aplicación implementada.
 * <p>
 * Radu Constantin Robu y Alberto Pérez
 */
package P3.Vista;

import javax.swing.*;
import javax.swing.border.Border;
import javax.swing.border.EmptyBorder;
import javax.swing.border.EtchedBorder;
import javax.swing.text.SimpleAttributeSet;
import javax.swing.text.StyleConstants;
import javax.swing.text.StyledDocument;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;

import P3.Control.OyenteVista;
import P3.Modelo.Tupla;

public class AplicacionVista implements ActionListener,
        PropertyChangeListener {
    private static final int ANCHO = 600;
    private static final int ALTO = 800;
    private static final int ANCHO_PANEL_BOTONES = 200;
    private static final int ALTO_PANEL_BOTONES = 200;
    private static final int ANCHO_PANEL_TAREAS = 400;
    private static final int ALTO_PANEL_TAREAS = 200;
    private static final int INDENT_TAREAS = 70;
    private static final int TAMANYO_NOMBRE_TAREA = 16;
    private static final int TAMANYO_DESCRIPCION_TAREA = 32;
    private static final int TAMANYO_CAMPOS_TEXTO = 10;

    private static final String FORMATO_FECHA = "^[0-9]{2} [0-9]{2} [0-9]{4}$";
    private static final String PATRON_CADENA_DIGITOS = "^[0-9]+$";

    private OyenteVista oyenteVista;
    private static final String NUEVO_FICHERO = "Nuevo fichero";
    private static final String ANYADIR_TAREA = "Añadir tarea";
    private static final String ELIMINAR_TAREA = "Eliminar tarea";
    private static final String BUSCAR_TAREA = "Buscar tareas";
    private static final String LISTAR_TAREAS = "Listar tareas";
    private static final String GUARDAR_TAREAS = "Guardar tareas";
    private static final String SALIR = "Salir";
    private static final String MAINFRAME_WRAPPER = "Mainframe Wrapper";
    private static final String ACCION_NUEVO_FICHERO = "NUEVO_FICHERO";
    private static final String ACCION_ANYADIR_TAREA = "ANYADIR_TAREA";
    private static final String ACCION_ELIMINAR_TAREA = "ELIMINAR_TAREA";
    private static final String ACCION_BUSCAR_TAREAS = "BUCAR_TAREAS";
    private static final String ACCION_LISTAR_TAREAS = "LISTAR_TAREAS";
    private static final String ACCION_GUARDAR_TAREAS = "GUARDAR_TAREAS";
    private static final String ACCION_SALIR = "SALIR";
    private static final String TITULO_GUARDAR_SALIR = "Guardar y salir";
    private static final String MENSAJE_GUARDAR_CAMBIOS =
            "¿Desea guardar los cambios?";

    private static final String TITULO_VENTANA_INICIAR_SESION =
            "Conexión con el mainframe";
    private static final String[] CAMPOS_INICIAR_SESION =
            {"Host", "Usuario", "Contraseña"};
    private static final String[] OPCIONES_INICIAR_SESION =
            {"Iniciar sesión", "Cancelar"};

    private static final String TITULO_VENTANA_ANYADIR_TAREA =
            "Añadir una tarea";
    private static final String[] CAMPOS_ANYADIR_TAREA =
            {"Id", "Nombre", "Descripción", "Fecha"};
    private static final String[] OPCIONES_ANYADIR_TAREA =
            {"Añadir", "Cancelar"};

    private static final String TITULO_VENTANA_BUSCAR_TAREAS = "Buscar tareas";
    private static final String[] CAMPOS_BUSCAR_TAREAS = {"Fecha"};
    private static final String[] OPCIONES_BUSCAR_TAREAS =
            {"Buscar", "Cancelar"};

    private static final String TITULO_VENTANA_ELIMINAR_TAREA =
            "Eliminar tarea";
    private static final String[] CAMPOS_ELIMINAR_TAREA = {"Id"};
    private static final String[] OPCIONES_ELIMINAR_TAREA =
            {"Eliminar", "Cancelar"};


    private static final String ETIQUETA_VENTANA_ERROR_FECHA =
            "Fecha incorrecta";
    private static final String MENSAJE_FECHA_INCORRECTA =
            "El formato de la fecha introducida no es correcto.\n" +
            "Formato aceptado:\n" + "DD MM AAAA\n";

    private static final String ETIQUETA_VENTANA_ID_INCORRECTO =
            "ID incorrecto";
    private static final String MENSAJE_ID_INCORRECTO =
            "El id de una tarea debe contener únicamente números.";

    private static final String ETIQUETA_VENTANA_NOMBRE_INCORRECTO =
            "Nombre incorrecto";
    private static final String MENSAJE_NOMBRE_INCORRECTO =
            "El nombre de la tarea debe tener menos de " +
            TAMANYO_NOMBRE_TAREA + " caracteres.";

    private static final String ETIQUETA_VENTANA_DESCRIPCION_INCORRECTA =
            "Descripción incorrecta";
    private static final String MENSAJE_DESCRIPCION_INCORRECTA =
            "La descripción de la tarea debe tener menos de " +
            TAMANYO_DESCRIPCION_TAREA + " caracteres.";

    private String[] datosInicioSesion;

    private JButton botonNuevoFichero;
    private JButton botonAnyadirTarea;
    private JButton botonEliminarTarea;
    private JButton botonBuscarTarea;
    private JButton botonListarTareas;
    private JButton botonGuardarTareas;
    private JButton botonSalir;
    private JPanel panelTareas;
    private JTextPane areaTextoTareas;

    private enum CodigoRespuesta {
        OK, ERROR_ID_TAREA, ERROR_LONG_NOMBRE, DATOS_VACIOS,
        ERROR_FECHA_INCORRECTA, ERROR_LONG_DESCRIPCION
    }

    /**
     * Constructor de la clase.
     */
    public AplicacionVista(OyenteVista oyenteVista) {
        datosInicioSesion = iniciarSesion();
        this.oyenteVista = oyenteVista;
    }

    public String[] obtenerDatosInicioSesion() {
        return datosInicioSesion;
    }

    /**
     * Crea la ventana principal de la interfaz y sus elementos.
     */
    public void crearElementosVentanaPrincipal() {
        JFrame ventanaPrincipal = new JFrame(MAINFRAME_WRAPPER);
        ventanaPrincipal.setSize(ANCHO, ALTO);
        ventanaPrincipal.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        ventanaPrincipal.setLocationRelativeTo(null);
        ventanaPrincipal.setLayout(new BorderLayout());
        ventanaPrincipal.add(crearPanelBotones());
        ventanaPrincipal.add(crearPanelMostrarTareas(), BorderLayout.EAST);
        ventanaPrincipal.setVisible(true);

    }

    /**
     * Crea el panel de tareas de la ventana principal.
     *
     * @return
     */
    public JPanel crearPanelMostrarTareas() {
        panelTareas = new JPanel(new BorderLayout());
        Border bordePanelTareas =
                BorderFactory.createEtchedBorder(EtchedBorder.LOWERED);
        panelTareas.setBorder(bordePanelTareas);
        panelTareas.setPreferredSize(new Dimension(ANCHO_PANEL_TAREAS,
                ALTO_PANEL_TAREAS));

        JScrollPane panelDeslizable = new JScrollPane();
        areaTextoTareas = new JTextPane();
        areaTextoTareas.setEditable(false);
        areaTextoTareas.setAlignmentX(70);
        panelDeslizable.setViewportView(areaTextoTareas);
        panelTareas.add(panelDeslizable);

        StyledDocument doc = areaTextoTareas.getStyledDocument();

        SimpleAttributeSet center = new SimpleAttributeSet();
        StyleConstants.setLeftIndent(center, INDENT_TAREAS);
        doc.setParagraphAttributes(0, doc.getLength(), center, false);

        return panelTareas;
    }


    /**
     * Crea el panel de botones de la ventana principal.
     *
     * @return
     */
    private JPanel crearPanelBotones() {
        crearBotones();
        JPanel panelBotones = new JPanel(new BorderLayout());
        panelBotones.setBorder(new EmptyBorder(2, 3, 2, 3));

        JPanel layoutBotones = new JPanel(new GridBagLayout());
        layoutBotones.setBorder(new EmptyBorder(5, 5, 5, 5));
        Border bordePanelBotones =
                BorderFactory.createEtchedBorder(EtchedBorder.LOWERED);
        layoutBotones.setBorder(bordePanelBotones);

        JPanel contenedorBotones =
                new JPanel(new GridLayout(10, 1, 10, 20));

        contenedorBotones.add(botonNuevoFichero);
        contenedorBotones.add(botonAnyadirTarea);
        contenedorBotones.add(botonEliminarTarea);
        contenedorBotones.add(botonBuscarTarea);
        contenedorBotones.add(botonListarTareas);
        contenedorBotones.add(botonGuardarTareas);
        contenedorBotones.add(botonSalir);
        layoutBotones.add(contenedorBotones);
        layoutBotones.setPreferredSize(new Dimension(ANCHO_PANEL_BOTONES,
                ALTO_PANEL_BOTONES));
        panelBotones.setPreferredSize(new Dimension(ANCHO_PANEL_BOTONES,
                ALTO_PANEL_BOTONES));
        contenedorBotones.setPreferredSize(new Dimension(ANCHO_PANEL_BOTONES,
                ALTO_PANEL_BOTONES));
        panelBotones.add(layoutBotones, BorderLayout.WEST);

        return panelBotones;
    }

    /**
     * Crea los botones del panel de botones.
     */
    private void crearBotones() {
        botonNuevoFichero = new JButton(NUEVO_FICHERO);
        botonNuevoFichero.addActionListener(this);
        botonNuevoFichero.setActionCommand(ACCION_NUEVO_FICHERO);

        botonAnyadirTarea = new JButton(ANYADIR_TAREA);
        botonAnyadirTarea.addActionListener(this);
        botonAnyadirTarea.setActionCommand(ACCION_ANYADIR_TAREA);

        botonEliminarTarea = new JButton(ELIMINAR_TAREA);
        botonEliminarTarea.addActionListener(this);
        botonEliminarTarea.setActionCommand(ACCION_ELIMINAR_TAREA);

        botonBuscarTarea = new JButton(BUSCAR_TAREA);
        botonBuscarTarea.addActionListener(this);
        botonBuscarTarea.setActionCommand(ACCION_BUSCAR_TAREAS);

        botonListarTareas = new JButton(LISTAR_TAREAS);
        botonListarTareas.addActionListener(this);
        botonListarTareas.setActionCommand(ACCION_LISTAR_TAREAS);

        botonGuardarTareas = new JButton(GUARDAR_TAREAS);
        botonGuardarTareas.addActionListener(this);
        botonGuardarTareas.setActionCommand(ACCION_GUARDAR_TAREAS);

        botonSalir = new JButton(SALIR);
        botonSalir.addActionListener(this);
        botonSalir.setActionCommand(ACCION_SALIR);
    }

    /**
     * Método de tratamiento de eventos.
     *
     * @param e
     */
    @Override
    public void actionPerformed(ActionEvent e) {
        switch (e.getActionCommand()) {
            case ACCION_NUEVO_FICHERO:
                oyenteVista.eventoProducido(OyenteVista.Evento.NUEVO_FICHERO,
                        null);
                break;

            case ACCION_ANYADIR_TAREA:
                String[] datosAnyadirTarea = anyadirTarea();
                if (datosAnyadirTarea != null) {
                    Tupla<Tupla, Tupla> tupla = new Tupla(
                        new Tupla(datosAnyadirTarea[0], datosAnyadirTarea[1]),
                        new Tupla(datosAnyadirTarea[2], datosAnyadirTarea[3]));
                    oyenteVista.eventoProducido(
                            OyenteVista.Evento.ANYADIR_TAREA, tupla);
                }
                break;

            case ACCION_BUSCAR_TAREAS:
                String[] datosBuscarTareas = buscarTareas();
                if (datosBuscarTareas != null) {
                    oyenteVista.eventoProducido(OyenteVista.Evento.BUSCAR_TAREA,
                            datosBuscarTareas[0]);
                }
                break;

            case ACCION_SALIR:
                int resp = JOptionPane.showConfirmDialog(null,
                        MENSAJE_GUARDAR_CAMBIOS,
                        TITULO_GUARDAR_SALIR, JOptionPane.YES_NO_OPTION);
                if (resp == JOptionPane.YES_OPTION) {
                    oyenteVista.eventoProducido(OyenteVista.Evento.SALIR, "y");
                } else if (resp == JOptionPane.NO_OPTION) {
                    oyenteVista.eventoProducido(OyenteVista.Evento.SALIR, "n");
                }
                break;

            case ACCION_ELIMINAR_TAREA:
                String[] datosEliminarTarea = obtenerDatosEliminarTarea();
                if (datosEliminarTarea != null) {
                    oyenteVista.eventoProducido(
                            OyenteVista.Evento.ELIMINAR_TAREA,
                            datosEliminarTarea[0]);
                }
                break;

            case ACCION_LISTAR_TAREAS:
                oyenteVista.eventoProducido(OyenteVista.Evento.LISTAR_TAREAS,
                        null);
                break;

            case ACCION_GUARDAR_TAREAS:
                oyenteVista.eventoProducido(OyenteVista.Evento.GUARDAR_TAREAS,
                        null);
                break;
        }
    }

    /**
     * Método para mostrar tareas en un mainframe.
     */
    public void mostrarTareas(String tareas) {
        areaTextoTareas.setText("");
        areaTextoTareas.setText(tareas);
    }

    /**
     * Método para iniciar sesión en un mainframe.
     */
    private String[] iniciarSesion() {
        ComplexDialoguePanel ventanaIniciarSesion =
                new ComplexDialoguePanel(TITULO_VENTANA_INICIAR_SESION,
                CAMPOS_INICIAR_SESION, 16);
        String[] datosInicioSesion =
                ventanaIniciarSesion.obtenerTextoCampos(
                        OPCIONES_INICIAR_SESION);

        return datosInicioSesion;
    }

    /**
     * Método para añadir una tarea en el mainframe.
     *
     * @return
     */
    private String[] anyadirTarea() {
        String[] datosAnyadirTarea = null;

        ComplexDialoguePanel ventanaAnyadirTarea = new ComplexDialoguePanel(
                TITULO_VENTANA_ANYADIR_TAREA, CAMPOS_ANYADIR_TAREA,
                TAMANYO_DESCRIPCION_TAREA);
        datosAnyadirTarea = ventanaAnyadirTarea.obtenerTextoCampos(
                OPCIONES_ANYADIR_TAREA);

        CodigoRespuesta codigo = verificarDatosTarea(datosAnyadirTarea);

        switch (codigo) {
            case OK:
                return datosAnyadirTarea;

            case ERROR_FECHA_INCORRECTA:
                JOptionPane.showMessageDialog(new JFrame(),
                        MENSAJE_FECHA_INCORRECTA, ETIQUETA_VENTANA_ERROR_FECHA,
                        JOptionPane.ERROR_MESSAGE);
                break;

            case ERROR_ID_TAREA:
                JOptionPane.showMessageDialog(new JFrame(),
                        MENSAJE_ID_INCORRECTO, ETIQUETA_VENTANA_ID_INCORRECTO,
                        JOptionPane.ERROR_MESSAGE);
                break;

            case ERROR_LONG_NOMBRE:
                JOptionPane.showMessageDialog(new JFrame(),
                        MENSAJE_NOMBRE_INCORRECTO,
                        ETIQUETA_VENTANA_NOMBRE_INCORRECTO,
                        JOptionPane.ERROR_MESSAGE);
                break;

            case ERROR_LONG_DESCRIPCION:
                JOptionPane.showMessageDialog(new JFrame(),
                        MENSAJE_DESCRIPCION_INCORRECTA,
                        ETIQUETA_VENTANA_DESCRIPCION_INCORRECTA,
                        JOptionPane.ERROR_MESSAGE);
                break;
        }
        return null;
    }

    /**
     * Comprueba los datos que el usuario ha introducido.
     *
     * @param datosTarea
     * @return
     */
    private CodigoRespuesta verificarDatosTarea(String[] datosTarea) {
        if (datosTarea != null) {
            if (datosTarea[0].matches(PATRON_CADENA_DIGITOS)) {
                if ((datosTarea[1].length() > 0) &&
                        (datosTarea[1].length() <= TAMANYO_NOMBRE_TAREA)) {
                    if ((datosTarea[2].length() > 0) &&
                            (datosTarea[2].length() <=
                                    TAMANYO_DESCRIPCION_TAREA)) {
                        if (datosTarea[3].matches(FORMATO_FECHA)) {
                            return CodigoRespuesta.OK;
                        } else {
                            return CodigoRespuesta.ERROR_FECHA_INCORRECTA;
                        }
                    }
                    return CodigoRespuesta.ERROR_LONG_DESCRIPCION;
                } else {
                    return CodigoRespuesta.ERROR_LONG_NOMBRE;
                }
            } else {
                return CodigoRespuesta.ERROR_ID_TAREA;
            }
        } else {
            return CodigoRespuesta.DATOS_VACIOS;
        }
    }

    /**
     * Método para buscar tareas en el mainframe por fecha.
     *
     * @return
     */
    private String[] buscarTareas() {
        ComplexDialoguePanel ventanaBuscarTareas =
                new ComplexDialoguePanel(TITULO_VENTANA_BUSCAR_TAREAS,
                CAMPOS_BUSCAR_TAREAS, TAMANYO_CAMPOS_TEXTO);
        String[] datosBuscarTareas =
                ventanaBuscarTareas.obtenerTextoCampos(OPCIONES_BUSCAR_TAREAS);

        return datosBuscarTareas;
    }

    /**
     * Método para ELIMINAR una tarea.
     *
     * @return
     */
    private String[] obtenerDatosEliminarTarea() {
        ComplexDialoguePanel ventanaEliminarTareas =
                new ComplexDialoguePanel(TITULO_VENTANA_ELIMINAR_TAREA,
                CAMPOS_ELIMINAR_TAREA, TAMANYO_CAMPOS_TEXTO);
        String[] datoseliminarTareas =
                ventanaEliminarTareas.obtenerTextoCampos(
                        OPCIONES_ELIMINAR_TAREA);

        return datoseliminarTareas;
    }

    /**
     * Muestra un diálogo con el error que se ha producido.
     *
     * @param titulo
     * @param mensaje
     */
    public void notificarMensajeError(String titulo, String mensaje) {
        JOptionPane.showMessageDialog(new JFrame(), mensaje, titulo,
                JOptionPane.ERROR_MESSAGE);
    }

    /**
     * Muestra un diálogo con la confirmación de la tarea.
     *
     * @param titulo
     * @param mensaje
     */
    public void notificarMensajeConfirmacion(String titulo, String mensaje) {
        JOptionPane.showMessageDialog(new JFrame(), mensaje, titulo,
                JOptionPane.INFORMATION_MESSAGE);
    }

    /**
     * Método de cambios de propiedades de los elementos de la ventana.
     *
     * @param evt
     */
    @Override
    public void propertyChange(PropertyChangeEvent evt) {
    }
}

