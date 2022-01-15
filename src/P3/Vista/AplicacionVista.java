package P3.Vista;

import javax.swing.*;
import javax.swing.border.Border;
import javax.swing.border.EmptyBorder;
import javax.swing.border.EtchedBorder;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.util.Date;
import java.util.GregorianCalendar;

import P3.Control.OyenteVista;

public class AplicacionVista implements ActionListener, PropertyChangeListener {
    private static final int ANCHO_PANEL_BOTONES = 200;
    private static final int ALTO_PANEL_BOTONES = 200;
    public static final int OK = 0;
    public static final int ERROR_LONG_DESCRIPCION = 3;
    public static final int ERROR_LONG_NOMBRE = 2;
    public static final int ERROR_ID_TAREA = 1;
    private OyenteVista oyenteVista;
    private static final String INICIAR_SESION = "Iniciar sesión";
    private static final String NUEVO_FICHERO = "Nuevo fichero";
    private static final String ANYADIR_TAREA = "Añadir tarea";
    private static final String ELIMINAR_TAREA = "Eliminar tarea";
    private static final String BUSCAR_TAREA = "Buscar tareas";
    private static final String LISTAR_TAREAS = "Listar tareas";
    private static final String GUARDAR_TAREAS = "Guardar tareas";
    private static final String SALIR = "Salir";
    private static final int ANCHO = 800;
    private static final int ALTO = 1000;
    private static final String MAINFRAME_WRAPPER = "Mainframe Wrapper";
    private static final String ACCION_NUEVO_FICHERO = "NUEVO_FICHERO";
    private static final String ACCION_INICIAR_SESION = "INICIAR_SESION";
    private static final String ACCION_ANYADIR_TAREA = "ANYADIR_TAREA";
    private static final String ACCION_ELIMINAR_TAREA = "ELIMINAR_TAREA";
    private static final String ACCION_BUSCAR_TAREAS = "BUCAR_TAREAS";
    private static final String ACCION_LISTAR_TAREAS = "LISTAR_TAREAS";
    private static final String ACCION_GUARDAR_TAREAS = "GUARDAR_TAREAS";
    private static final String ACCION_SALIR = "SALIR";

    private static final String TITULO_VENTANA_INICIAR_SESION = "Conexión con el mainframe";
    private static final String[] CAMPOS_INICIAR_SESION = {"Host", "Usuario", "Contraseña"};
    private static final String[] OPCIONES_INICIAR_SESION = {"Iniciar sesión", "Cancelar"};

    private static final String TITULO_VENTANA_ANYADIR_TAREA = "Añadir una tarea";
    private static final String[] CAMPOS_ANYADIR_TAREA = {"Id", "Nombre", "Descripción", "Fecha"};
    private static final String[] OPCIONES_ANYADIR_TAREA = {"Confirmar", "Cancelar"};

    private static final String TITULO_VENTANA_BUSCAR_TAREAS = "Buscar tareas";
    private static final String[] CAMPOS_BUSCAR_TAREAS = {"Fecha"};
    private static final String[] OPCIONES_BUSCAR_TAREAS = {"Buscar", "Cancelar"};

    private JButton botonIniciarSesion;
    private JButton botonNuevoFichero;
    private JButton botonAnyadirTarea;
    private JButton botonEliminarTarea;
    private JButton botonBuscarTarea;
    private JButton botonListarTareas;
    private JButton botonGuardarTareas;
    private JButton botonSalir;

    private enum Errores {
        OK, ERROR_ID_TAREA, ERROR_LONG_NOMBRE, ERROR_LONG_DESCRIPCION
    }
    
    /**
     * Constructor de la clase.
     */
    public AplicacionVista(OyenteVista oyenteVista) {
        crearElementosVentanaPrincipal();
        this.oyenteVista = oyenteVista;
    }

    /**
     * Crea la ventana principal de la interfaz y sus elementos.
     */
    private void crearElementosVentanaPrincipal() {
        JFrame ventanaPrincipal = new JFrame(MAINFRAME_WRAPPER);
        ventanaPrincipal.setSize(ANCHO, ALTO);
        ventanaPrincipal.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        ventanaPrincipal.setLocationRelativeTo(null);
        ventanaPrincipal.setLayout(new BorderLayout());
        ventanaPrincipal.add(crearPanelBotones());
        ventanaPrincipal.setVisible(true);
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
        Border bordePanelBotones = BorderFactory.createEtchedBorder(EtchedBorder.LOWERED);
        layoutBotones.setBorder(bordePanelBotones);

        JPanel contenedorBotones = new JPanel(new GridLayout(10, 1, 10, 20));
        contenedorBotones.add(botonIniciarSesion);
        contenedorBotones.add(botonNuevoFichero);
        contenedorBotones.add(botonAnyadirTarea);
        contenedorBotones.add(botonEliminarTarea);
        contenedorBotones.add(botonBuscarTarea);
        contenedorBotones.add(botonListarTareas);
        contenedorBotones.add(botonGuardarTareas);
        contenedorBotones.add(botonSalir);
        layoutBotones.add(contenedorBotones);
        layoutBotones.setPreferredSize(new Dimension(ANCHO_PANEL_BOTONES, ALTO_PANEL_BOTONES));
        panelBotones.add(layoutBotones, BorderLayout.WEST);

        return panelBotones;
    }

    /**
     * Crea los botones del panel de botones.
     */
    private void crearBotones() {
        botonIniciarSesion = new JButton(INICIAR_SESION);
        botonIniciarSesion.addActionListener(this);
        botonIniciarSesion.setActionCommand(ACCION_INICIAR_SESION);

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
        botonGuardarTareas.setActionCommand(GUARDAR_TAREAS);

        botonSalir = new JButton(SALIR);
        botonSalir.addActionListener(this);
        botonSalir.setActionCommand(SALIR);
    }

    /**
     * Método de tratamiento de eventos.
     *
     * @param e
     */
    @Override
    public void actionPerformed(ActionEvent e) {
        switch (e.getActionCommand()) {
            case ACCION_INICIAR_SESION:
                String[] datosInicioSesion = iniciarSesion();
                oyenteVista.eventoProducido(OyenteVista.Evento.INICIAR_SESION, datosInicioSesion);
                break;

            case ACCION_ANYADIR_TAREA:
                String[] datosAnyadirTarea = anyadirTarea();
                break;

            case ACCION_BUSCAR_TAREAS:
                String[] datosBuscarTareas = buscarTareas();
                break;
        }
    }

    /**
     * Método para iniciar sesión en un mainframe.
     */
    private String[] iniciarSesion() {
        /*
        JTextField host = new JTextField(15);
        JTextField usuario = new JTextField(10);
        JPasswordField contrasenya = new JPasswordField(10);


        JPanel myPanel = new JPanel(new GridLayout(0, 3));
        myPanel.add(new JLabel("Host"));
        myPanel.add(host);
        myPanel.add(Box.createVerticalStrut(15)); // a spacer
        myPanel.add(new JLabel("Usuario"));
        myPanel.add(usuario);
        myPanel.add(Box.createVerticalStrut(15)); // a spacer
        myPanel.add(new JLabel("Contraseña"));
        myPanel.add(contrasenya);


        int result = JOptionPane.showConfirmDialog(null, myPanel,
                "Introduzca usuario y contraseña", JOptionPane.OK_CANCEL_OPTION);
        if (result == JOptionPane.OK_OPTION) {
            System.out.println("host: " + host.getText());
            System.out.println("Usuario: " + usuario.getText());
            System.out.println("Contraseña: " + contrasenya.getText());
        }

         */
        ComplexDialoguePanel ventanaIniciarSesion = new ComplexDialoguePanel(TITULO_VENTANA_INICIAR_SESION,
                CAMPOS_INICIAR_SESION, 16);
        String[] datosInicioSesion = ventanaIniciarSesion.obtenerTextoCampos(OPCIONES_INICIAR_SESION);

        if (datosInicioSesion != null) {
            return datosInicioSesion;
        }
        return null;
    }

    /**
     * Método para añadir una tarea en el mainframe.
     *
     * @return
     */
    private String[] anyadirTarea() {
        ComplexDialoguePanel ventanaAnyadirTarea = new ComplexDialoguePanel(TITULO_VENTANA_ANYADIR_TAREA,
                CAMPOS_ANYADIR_TAREA, 32);
        String[] datosAnyadirTarea = ventanaAnyadirTarea.obtenerTextoCampos(OPCIONES_ANYADIR_TAREA);

        verificarDatosTarea(datosAnyadirTarea);

        return datosAnyadirTarea;
    }

    /**
     * Comprueba los datos que el usuario ha introducido.
     *
     * @param datosTarea
     * @return
     */
    private Errores verificarDatosTarea(String[] datosTarea) {
        if (datosTarea[0].matches("^[0-9]+]$")) {
            if ((datosTarea[1].length() > 0) && (datosTarea[1].length() <= 16)) {
                if ((datosTarea[2].length() > 0) && (datosTarea[2].length() <= 32)) {
                    //TODO devolver error fecha aqui?
                    return Errores.OK;
                }
                return Errores.ERROR_LONG_DESCRIPCION;
            } else {
                return Errores.ERROR_LONG_NOMBRE;
            }
        } else {
            return Errores.ERROR_ID_TAREA;
        }
    }

    private String[] parsearFecha(String fecha) {
        String[] valoresFecha = fecha.split(" ");

        return valoresFecha;
    }

    /**
     * Método para buscar tareas en el mainframe por fecha.
     *
     * @return
     */
    private String[] buscarTareas() {
        ComplexDialoguePanel ventanaBuscarTareas = new ComplexDialoguePanel(TITULO_VENTANA_BUSCAR_TAREAS,
                CAMPOS_BUSCAR_TAREAS, 10);
        String[] datosBuscarTareas = ventanaBuscarTareas.obtenerTextoCampos(OPCIONES_BUSCAR_TAREAS);

        return datosBuscarTareas;
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

