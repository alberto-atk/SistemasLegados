from py3270 import *
import tkinter as tk

# Constantes conexión
MACHINE_IP = "155.210.71.101:"
MACHINE_PORT = "123"
USERNAME = "prog"
PASSWORD = "prog123"

# Constantes comandos
COMM_TAB = 'Tab'
COMM_ASCII = 'ascii'
COMM_OFF = 'off'

# Constantes formatos
ASCII = 'ASCII'


def show_screen_result():
    print(emulator.exec_command(COMM_ASCII.encode(ASCII)).data)


def connect():
    emulator.connect(MACHINE_IP + MACHINE_PORT)
    emulator.send_enter()
    emulator.send_enter()
    emulator.send_enter()


def login():
    emulator.send_string(USERNAME)
    emulator.exec_command(COMM_TAB.encode(ASCII))
    emulator.send_string(PASSWORD)
    emulator.send_enter()
    emulator.send_enter()
    emulator.send_enter()
    emulator.send_enter()
    emulator.send_enter()
    emulator.send_enter()


def logout():
    emulator.send_string(COMM_OFF)
    emulator.send_enter()
    emulator.send_enter()
    emulator.send_enter()
    emulator.terminate()


class Vista:
    gui = tk.Tk()
    gui.title("Mainframe GUI")

    gui.mainloop()


vista = Vista()
vista.mainloop()
emulator = Emulator()
connect()
login()

show_screen_result()
logout()
