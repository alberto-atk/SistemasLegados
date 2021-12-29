from tkinter import *


TEXTO_BOTON_NUEVO_FICHERO = "Nuevo fichero"
TEXTO_BOTON_ANYADIR_TAREA = "Añadir tarea"
TEXTO_BOTON_ELIMINAR_TAREA = "Eliminar tarea"
TEXTO_BOTON_BUSCAR_TAREA = "Buscar tarea"
TEXTO_BOTON_LISTAR_TAREAS = "Listar tareas"
TEXTO_BOTON_GUARDAR = "Guardar"
TEXTO_BOTON_SALIR = "Salir"
TITULO_VENTANA = "Task Management"
TAMANYO_VENTANA = '800x600'


def nuevo_fichero(window):
    print("New file")


def anyadir_tarea(window):
    print("add ")


def eliminar_tarea(window):
    print("remove")


def buscar_tarea(window):
    print("search")


def listar_tareas(window):
    print("list")


def guardar(window):
    print("save")


def exit():
    quit()



def generar_botones(window):
    newTaskBtn = Button(window, text=TEXTO_BOTON_NUEVO_FICHERO, command=lambda:nuevo_fichero(window))
    newTaskBtn.place(x=15, y=20, width=150, height=40)

    addTaskBtn = Button(window, text=TEXTO_BOTON_ANYADIR_TAREA, command=lambda:anyadir_tarea(window))
    addTaskBtn.place(x=15, y=70, width=150, height=40)

    eliminarBtn = Button(window, text=TEXTO_BOTON_ELIMINAR_TAREA, command=lambda:eliminar_tarea(window))
    eliminarBtn.place(x=15, y=120, width=150, height=40)

    buscarBtn = Button(window, text=TEXTO_BOTON_BUSCAR_TAREA, command=lambda:buscar_tarea(window))
    buscarBtn.place(x=15, y=170, width=150, height=40)

    listarBtn = Button(window, text=TEXTO_BOTON_LISTAR_TAREAS, command=lambda:listar_tareas(window))
    listarBtn.place(x=15, y=220, width=150, height=40)
    
    guardarBtn = Button(window, text=TEXTO_BOTON_GUARDAR, command=lambda:guardar(window))
    guardarBtn.place(x=15, y=270, width=150, height=40)

    salirBtn = Button(window, text=TEXTO_BOTON_SALIR, command=exit)
    salirBtn.place(x=15, y=320, width=150, height=40)



if __name__ == "__main__":
    window = Tk()

    window.title(TITULO_VENTANA)

    window.geometry(TAMANYO_VENTANA)

    generar_botones(window)

    window.mainloop()