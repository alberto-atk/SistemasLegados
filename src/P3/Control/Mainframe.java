/**
 * Mainframe.java
 * <p>
 * Clase que contiene la implementación de los métodos para conectarse con el mainframe y
 * ejecutar la aplicación legada.
 * <p>
 * Radu Constantin Robu y Alberto Pérez
 */
package P3.Control;

import java.io.*;

import static java.lang.Thread.sleep;

public class Mainframe implements MainframeAPI {
    private static final String NOK = "NOK";
    private static final String TASKS2JOB = "tasks2.job";
    private static final String MENU_TASKS2 = "TASK MANAGEMENT 2.0 BY TURO-SL SOFT";
    private static final int DELAY = 50;

    private Process proceso;
    private PrintWriter outStream = null;
    private BufferedReader inStream = null;

    private static Mainframe singleton = null;

    /**
     * Constructor de la clase.
     *
     * @throws IOException
     */
    private Mainframe() throws IOException {
        proceso = Runtime.getRuntime().exec(TERMINAL_SIN_PANTALLA);
        inStream = new BufferedReader(new InputStreamReader(proceso.getInputStream()));
        outStream = new PrintWriter(new OutputStreamWriter(proceso.getOutputStream()));
    }

    /**
     * Devuelve la instancia del objeto de la clase.
     *
     * @return
     * @throws IOException
     */
    public static Mainframe getInstance() throws IOException {
        if (singleton == null) {
            singleton = new Mainframe();
        }
        return singleton;
    }

    /**
     * Realiza la conexión con la máquina.
     *
     * @param host
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    private boolean conectarHost(String host) throws IOException, InterruptedException {
        outStream.println(CONNECT + host);
        outStream.flush();
        return ejecutarSiguienteComando();
    }

    /**
     * Obtiene la respuesta textual del mainframe en la terminal s3270.
     *
     * @return
     */
    public String obtenerRespuestaMaquina() throws IOException {
        String resultado = "";
        String line = "";
        do {
            line = inStream.readLine();
            if (line == null || line.matches(PATRON_RESPUESTA_MAINFRAME_ERROR)) {
                return NOK;
            }
            resultado += line + "\n";
        } while (inStream.ready());
        return resultado;
    }

    /**
     * Verifica si se inicia sesión correctamente.
     *
     * @return
     * @throws InterruptedException
     * @throws IOException
     */
    private RESPUESTAS_INICIO_SESION falloInicioSesion() throws InterruptedException, IOException {
        if (esperarPantalla(MENSAJE_USUARIO_EN_USO)) {
            if (enviarComando(COMANDO_ENTER)) {
                return RESPUESTAS_INICIO_SESION.USUARIO_EN_USO;
            }
        } else if (esperarPantalla(MENSAJE_IDIOMA_NO_SOPORTADO)) {
            if (enviarComando(COMANDO_ENTER)) {
                return RESPUESTAS_INICIO_SESION.OK;
            }
        } else if (esperarPantalla(MENSAJE_USUARIO_INCORRECTO)) {
            if (enviarComando(COMANDO_ENTER)) {
                return RESPUESTAS_INICIO_SESION.USUARIO_INCORRECTO;
            }
        } else if (esperarPantalla(MENSAJE_CONTRASENYA_INCORRECTA)) {
            if (enviarComando(COMANDO_ENTER)) {
                return RESPUESTAS_INICIO_SESION.CONTRASENYA_INCORRECTA;
            }
        }
        return RESPUESTAS_INICIO_SESION.NOK;
    }

    /**
     * Inicio de sesión en el mainframe.
     *
     * @param username
     * @param password
     * @return
     * @throws InterruptedException
     * @throws IOException
     */
    private boolean login(String username, String password) throws InterruptedException, IOException {
        if (esperarPantalla(PANTALLA_CONEXION)) {
            if (enviarComando(COMANDO_ENTER)) {
                if (esperarPantalla(PANTALLA_LOGIN)) {
                    if (enviarString(username)) {
                        if (enviarComando(COMANDO_ENTER)) {
                            if (enviarString(password)) {
                                if (enviarComando(COMANDO_ENTER)) {
                                    return true;
                                }
                            }
                        }
                    }
                }
            }
        }
        return false;
    }

    /**
     * Conexión con el host.
     *
     * @param host
     * @param username
     * @param password
     * @return
     * @throws InterruptedException
     * @throws IOException
     */
    public RESPUESTAS_INICIO_SESION conexion(String host, String username, String password)
            throws InterruptedException, IOException {
        RESPUESTAS_INICIO_SESION resultadoInicioSesion;
        if (conectarHost(host)) {
            if (login(username, password)) {
                resultadoInicioSesion = falloInicioSesion();
                if (resultadoInicioSesion == RESPUESTAS_INICIO_SESION.OK) {
                    if (ejecutarTasksJob()) {
                        return RESPUESTAS_INICIO_SESION.OK;
                    }
                } else {
                    return resultadoInicioSesion;
                }
            }
        }
        return RESPUESTAS_INICIO_SESION.NOK;
    }

    /**
     * Ejecuta la aplicación legada.
     *
     * @throws InterruptedException
     * @throws IOException
     */
    public boolean ejecutarTasksJob() throws InterruptedException, IOException {
        if (esperarPantalla(PANTALLA_MENU_PRINCIPAL)) {
            if (enviarString(TASKS2JOB)) {
                if (enviarComando(COMANDO_ENTER)) {
                    if (esperarPantalla(MENU_TASKS2)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    /**
     * Realiza la salida controlada del mainframe a través de la terminal s3270.
     *
     * @return
     * @throws IOException
     */
    public boolean logout() throws IOException, InterruptedException {
        enviarString(CADENA_OFF);
        enviarComando(COMANDO_ENTER);
        enviarComando(COMANDO_EXIT);

        return true;
    }

    /**
     * Método sobreescrito para enviar un comando al mainframe.
     *
     * @param comando
     * @return
     * @throws IOException
     */
    @Override
    public boolean enviarComando(String comando) throws IOException {
        outStream.println(comando);
        outStream.flush();
        if (comando.equals(COMANDO_ASCII)) {
            return true;
        } else {
            return ejecutarSiguienteComando();
        }
    }

    /**
     * Envía una cadena de texto a la terminal s3270.
     *
     * @param mensaje
     * @return
     * @Override
     */
    @Override
    public boolean enviarString(String mensaje) throws IOException {
        outStream.println(String.format(FORMATO_CADENA_TEXTO, mensaje));
        outStream.flush();
        return ejecutarSiguienteComando();
    }

    /**
     * Método sobreecrito para esperar una pantalla del emulador.
     *
     * @param lineaABuscar
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    @Override
    public boolean esperarPantalla(String lineaABuscar) throws IOException, InterruptedException {
        Long maxTime = TIEMPO_EJEC_MAXIMO + System.currentTimeMillis();
        String resultado = "";
        do {
            enviarComando(COMANDO_ASCII);
            sleep(DELAY);
            resultado = obtenerRespuestaMaquina();
            if (resultado.contains(lineaABuscar)) {
                return true;
            }

        } while (maxTime > System.currentTimeMillis());

        return false;
    }

    /**
     * Método para esperar para poder ejecutar el siguiente comando.
     *
     * @return
     * @throws IOException
     */
    private boolean ejecutarSiguienteComando() throws IOException {
        String line = "";
        Long maxTime = TIEMPO_EJEC_MAXIMO + System.currentTimeMillis();
        while (maxTime > System.currentTimeMillis()) {
            line = inStream.readLine();
            if (line == null || line.matches(PATRON_RESPUESTA_MAINFRAME_ERROR)) {
                System.out.println(line);
                return false;
            } else if (line.matches(PATRON_RESPUESTA_MAINFRAME_OK)) {
                return true;
            }
        }
        return false;
    }

}
