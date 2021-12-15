from py3270 import *

emulator = Emulator()
emulator.connect("155.210.71.101:123")
emulator.send_enter()
print(emulator.exec_command("ascii".encode(
    'ASCII')).data)  # Muestra en pantalla la información recibida del emulador
