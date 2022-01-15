package P3.Vista;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.util.HashMap;
import java.util.Map;
import javax.swing.*;

/**
 * Clase que permite crear una ventana para introducir varios datos
 * por teclado.
 */
public class ComplexDialoguePanel extends JPanel {
    private static final String ETIQUETA_VENTANA = "Introducir información";
    private static final String ETIQUETA_CONTRASEÑA = "Contraseña";
    private static final String ETIQUETA_FECHA = "Fecha";
    public static final String MENSAJE_FECHA_INCORRECTA = "La fecha introducida no es correcta.";
    public static final String ETIQUETA_VENTANA_ERROR_FECHA = "Fecha incorrecta";
    public static final int FECHA = 3;
    private String[] etiquetasDatos;
    private Map<String, JTextField> camposTexto = new HashMap<>();

    /**
     * Construye un ComplexDialogPanel.
     *
     * @param textoVentana
     * @param etiquetasDatos
     * @param tamanyoCamposTexto
     */
    public ComplexDialoguePanel(String textoVentana, String[] etiquetasDatos,
                                int tamanyoCamposTexto) {
        setLayout(new GridBagLayout());
        inicializar(etiquetasDatos, tamanyoCamposTexto);
        setBorder(BorderFactory.createTitledBorder(textoVentana));
        this.etiquetasDatos = etiquetasDatos;
    }

    /**
     * Inicializa el ComplexDialoguePanel.
     *
     * @param etiquetasDatos
     * @param tamanyo
     */
    private void inicializar(String[] etiquetasDatos, int tamanyo) {
        for (int i = 0; i < etiquetasDatos.length; i++) {
            String etiqueta = etiquetasDatos[i];
            add(new JLabel(etiqueta), createGbc(0, i));

            if (etiqueta != ETIQUETA_CONTRASEÑA) {
                JTextField textField = new JTextField(tamanyo);
                camposTexto.put(etiqueta, textField);
                add(textField, createGbc(1, i));
            } else if (etiqueta == ETIQUETA_CONTRASEÑA) {
                JPasswordField passwordField = new JPasswordField(tamanyo);
                camposTexto.put(etiqueta, passwordField);
                add(passwordField, createGbc(1, i));
            }
        }
    }

    /**
     * Devuelve el camposTexto introducido en el campo correspondiente
     * a la etiqueta.
     *
     * @param etiqueta
     * @return
     */
    public String getText(String etiqueta) {
        JTextField campoTexto = camposTexto.get(etiqueta);
        if (campoTexto != null) {
            return campoTexto.getText();
        } else {
            throw new IllegalArgumentException(etiqueta);
        }
    }

    /**
     * Crea las dimendiones del GridBagLayout.
     *
     * @param x
     * @param y
     * @return
     */
    public static GridBagConstraints createGbc(int x, int y) {
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = x;
        gbc.gridy = y;
        gbc.weightx = 1.0;
        gbc.weighty = gbc.weightx;
        if (x == 0) {
            gbc.anchor = GridBagConstraints.LINE_START;
            gbc.fill = GridBagConstraints.BOTH;
            gbc.insets = new Insets(5, 5, 5, 8);
        } else {
            gbc.anchor = GridBagConstraints.LINE_END;
            gbc.fill = GridBagConstraints.HORIZONTAL;
            gbc.insets = new Insets(5, 5, 5, 5);
        }
        return gbc;
    }

    /**
     * Obtiene los datos del viajero a través de un ComplexDialoguePanel.
     *
     * @param opciones
     * @return
     */
    public String[] obtenerTextoCampos(String[] opciones) {
        int numDatos = this.etiquetasDatos.length;
        boolean datosVacios = true;
        while (datosVacios) {
            int datosValidos = 0;
            String[] datos = new String[numDatos];

            int tipoOpcion = JOptionPane.DEFAULT_OPTION;
            int tipoMensaje = JOptionPane.PLAIN_MESSAGE;
            Icon icono = null;
            Object valorInicial = opciones[0];

            int respuesta
                    = JOptionPane
                    .showOptionDialog(null, this, ETIQUETA_VENTANA,
                            tipoOpcion, tipoMensaje, icono,
                            opciones, valorInicial);

            if (respuesta == 0) {
                for (int i = 0; i < numDatos; i++) {
                    datos[i] = this.getText(this.etiquetasDatos[i]);
                }
                //TODO no dejar al usuario pasar hasta que no se introduzca una fecha correcta.
/*
                if ((datos[FECHA] != null) && (!(datos[FECHA].matches("^[0-9]{2}( |\\/|-)[0-9]{2}( |\\/|-)[0-9]{4}$")))) {
                    datosValidos = -1;
                    JOptionPane.showMessageDialog(new JFrame(), MENSAJE_FECHA_INCORRECTA,
                            ETIQUETA_VENTANA_ERROR_FECHA, JOptionPane.ERROR_MESSAGE);
                }
*/
                for (String texto : datos) {
                    if (!(texto.equals(""))) {
                        datosValidos++;
                    }
                }

                if (datosValidos == datos.length) {
                    datosVacios = false;
                    return datos;
                }
            } else {
                datosVacios = false;
            }
        }
        return null;
    }
}