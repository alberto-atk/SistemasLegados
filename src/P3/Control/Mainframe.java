package P3.Control;

import jdk.swing.interop.SwingInterOpUtils;

import java.io.*;

import static java.lang.Thread.sleep;

public class Mainframe implements MainframeAPI {
    private static final String NOK = "NOK";
    private static final String TASKS2JOB = "tasks2.job";

    private Process proceso;
    private PrintWriter outStream = null;
    private BufferedReader inStream = null;

    public Mainframe() throws IOException {
        //TODO HACER SINGLETON
        proceso = Runtime.getRuntime().exec(TERMINAL_SIN_PANTALLA);
        inStream = new BufferedReader(new InputStreamReader(proceso.getInputStream()));
        outStream = new PrintWriter(new OutputStreamWriter(proceso.getOutputStream()));
    }

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
    private String obtenerRespuestaMaquina() throws IOException {
        String resultado = "";
        String line = "";
        do {
            line = inStream.readLine();
            if (line == null || line.matches(PATRON_RESPUESTA_MAINFRAME_ERROR)) {
                return NOK;
            }
            //TODO esto mirar a ver lo del OK y lo de UUC
            resultado += line + "\n";
        } while (inStream.ready());
        return resultado;
    }


    private int falloInicioSesion() throws InterruptedException, IOException {
        if (esperarPantalla(MENSAJE_USUARIO_EN_USO)) {
            if (enviarString(OK)) {
                if (enviarComando(COMANDO_ENTER)) {
                    falloInicioSesion();
                }
            }
        } else if (esperarPantalla(MENSAJE_IDIOMA_NO_SOPORTADO)) {
            if (enviarComando(COMANDO_ENTER)) {
                return 1;
            }
        } else if (esperarPantalla(MENSAJE_USUARIO_INCORRECTO)) {
            //TODO el nombre de usuario es incorrecto
        } else if (esperarPantalla(MENSAJE_CONTRASENYA_INCORRECTA)) {
            //TODO la password es incorrecta
        }
        return 0;
    }

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

    public int conexion(String host, String username, String password) throws InterruptedException, IOException {
        int resultadoInicioSesion = 0;
        if (conectarHost(host)) {
            if (login(username, password)) {
                resultadoInicioSesion = falloInicioSesion();
                if (resultadoInicioSesion == 1) {
                    ejecutarTasksJob();
                } else {
                    return resultadoInicioSesion;
                }
            }
        }
        return 0;
    }

    public void ejecutarTasksJob() throws InterruptedException, IOException {
        if (esperarPantalla(PANTALLA_MENU_PRINCIPAL)) {
            if (enviarString(TASKS2JOB)) {
                if (enviarComando(COMANDO_ENTER)) {
                    if(esperarPantalla("TASK MANAGEMENT 2.0 BY TURO-SL SOFT")) {
                        enviarComando(COMANDO_ASCII);
                        System.out.println(obtenerRespuestaMaquina());
                        //TODO QUITARRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
                        enviarString("e");
                        enviarComando(COMANDO_ENTER);
                    }
                }
            }
        }
    }

    /**
     * Realiza la salida controlada del mainframe a través de la terminal s3270.
     *
     * @return
     * @throws IOException
     */
    public boolean logout() throws IOException {
        enviarString(CADENA_OFF);
        enviarComando(COMANDO_ENTER);
        enviarComando(COMANDO_EXIT);
        return true;
    }


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
    public boolean enviarString(String mensaje) throws IOException {
        outStream.println(String.format(FORMATO_CADENA_TEXTO, mensaje));
        outStream.flush();
        return ejecutarSiguienteComando();
    }

    @Override
    public boolean esperarPantalla(String lineaABuscar) throws IOException, InterruptedException {
        Long maxTime = TIEMPO_EJEC_MAXIMO + System.currentTimeMillis();
        String resultado = "";
        do {
            enviarComando(COMANDO_ASCII);
            sleep(50);
            resultado = obtenerRespuestaMaquina();
            if (resultado.contains(lineaABuscar)) {
                //System.out.println(resultado);
                return true;
            }

        } while (maxTime > System.currentTimeMillis());

        return false;
    }


    private boolean ejecutarSiguienteComando() throws IOException {
        String line = "";
        Long maxTime = TIEMPO_EJEC_MAXIMO + System.currentTimeMillis();
        while (maxTime > System.currentTimeMillis()) {
            line = inStream.readLine();
            if (line == null || line.matches(PATRON_RESPUESTA_MAINFRAME_ERROR)) {
                return false;
            } else if (line.matches(PATRON_RESPUESTA_MAINFRAME_OK)) {
                return true;
            }
        }
        return false;
    }

}
