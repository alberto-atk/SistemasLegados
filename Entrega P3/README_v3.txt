------------------- INSTALACIÓN -------------------

Para ejecutar TasksJobWrapper hace falta primero seguir los pasos del 
Manual VPN FortiClient 1.1 (disponible en Ayuda funcionamiento).

Se ha incluido el instalador de Windows de FortiClient por si resulta confusa 
su descarga.

------------------- EJECUCIÓN -------------------

Una vez instalado y configurado FortiClient VPN, hace falta ejecutarlo y 
conectarse a la red de Unizar con el NIP y la contraseña administrativa.

Después de conectarse, se puede ejecutar TasksJobWrapper. Para su ejecución 
hace falta Java 11.0.14.
Se ejecuta desde línea de comando con "java -jar TasksJobWrapper.jar".

------------------- FEEDBACK y ERRORES -------------------

El programa proporciona el feedback necesario en los casos de error más comunes.

En el caso de que hayan transcurrido más de 10 segundos al iniciar sesión, 
puede que la máquina no esté respondiendo. Es un problema que ocurre de forma 
aleatoria y tiene que ver con FortiClient VPN. Reiniciando Forticlient se puede
arreglar el problema.

PEOR CASO -> si no se consigue la conexión con la máquina 155.210.71.101:123, se
puede probar con la máquina 155.210.71.101:723 que no requiere conexión a través 
de FortiClient.
