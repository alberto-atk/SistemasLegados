package P3.Vista;


import javax.swing.*;
import javax.swing.border.BevelBorder;
import javax.swing.border.Border;
import javax.swing.border.EmptyBorder;
import javax.swing.border.EtchedBorder;
import java.awt.*;

public class MainframeVista extends javax.swing.JFrame {
    public static final String NUEVO_FICHERO = "Nuevo fichero";
    public static final String NUEVA_TAREA = "Nueva tarea";
    public static final String ELIMINAR_TAREA = "Eliminar tarea";
    public static final String BUSCAR_TAREA = "Buscar tarea";
    public static final String LISTAR_TAREAS = "Listar tareas";
    public static final String GUARDAR_TAREAS = "Guardar tareas";
    public static final String SALIR = "Salir";
    private JButton nuevoFichero;
    private JButton anyadirTarea;
    private JButton eliminarTarea;
    private JButton buscarTarea;
    private JButton listarTareas;
    private JButton guardarTareas;
    private JButton salir;


    public MainframeVista() {
        //pantallaPrincipal();
        login();
    }

    private void login() {
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


        String[] campos = {"Host", "Usuario", "Contraseña"};
        String[] opciones = {"Conectar", "Cancelar"};

        ComplexDialoguePanel c = new ComplexDialoguePanel("Conexión con el mainframe", campos, 16);
        String[] prueba = c.obtenerDatosViajero(opciones);

        if (prueba != null) {
            for (String i : prueba) {
                System.out.println(i);
            }
        }
    }

    private void pantallaPrincipal() {

        // Crea un nuevo contenedor JFrame.
        JFrame pantalla = new JFrame("Mainframe Wrapper");

        // Se le da al cuadro un tamaño inicial.
        pantalla.setSize(800, 1000);

        // Termine el programa cuando el usuario cierre la aplicación.
        pantalla.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        pantalla.setLayout(new BorderLayout());

        pantalla.add(crearPanelBotones());

        // Visualiza el marco.
        pantalla.setVisible(true);
    }

    private JPanel crearPanelBotones() {
        inicializarBotones();
        JPanel panelBotones = new JPanel(new BorderLayout());
        panelBotones.setBorder(new EmptyBorder(2, 3, 2, 3));


        JPanel layoutBotones = new JPanel(new GridBagLayout());
        layoutBotones.setBorder(new EmptyBorder(5, 5, 5, 5));
        Border loweredetched = BorderFactory.createEtchedBorder(EtchedBorder.LOWERED);
        layoutBotones.setBorder(loweredetched);

        JPanel btnPanel = new JPanel(new GridLayout(10, 1, 10, 20));
        btnPanel.add(nuevoFichero);
        btnPanel.add(anyadirTarea);
        btnPanel.add(eliminarTarea);
        btnPanel.add(buscarTarea);
        btnPanel.add(listarTareas);
        btnPanel.add(guardarTareas);
        btnPanel.add(salir);
        layoutBotones.add(btnPanel);
        panelBotones.add(layoutBotones, BorderLayout.WEST);

        return panelBotones;
    }

    private void inicializarBotones() {
        nuevoFichero = new JButton(NUEVO_FICHERO);
        anyadirTarea = new JButton(NUEVA_TAREA);
        eliminarTarea = new JButton(ELIMINAR_TAREA);
        buscarTarea = new JButton(BUSCAR_TAREA);
        listarTareas = new JButton(LISTAR_TAREAS);
        guardarTareas = new JButton(GUARDAR_TAREAS);
        salir = new JButton(SALIR);
        salir.setPreferredSize(new Dimension(200, 200));
    }


}

