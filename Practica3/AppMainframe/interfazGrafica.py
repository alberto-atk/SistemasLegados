from tkinter import *

def newTaskFile(window):
    print("New file")


def addTask(window):
    print("add ")


def removeTask(window):
    print("remove")


def searchTask(window):
    print("search")


def listTask(window):
    print("list")


def saveTask(window):
    print("save")


def exit():
    quit()



def generarBotones(window):
    newTaskBtn = Button(window, text="Nuevo fichero", command=lambda:newTaskFile(window))
    newTaskBtn.place(x=15, y=20, width=150, height=40)

    addTaskBtn = Button(window, text="Añadir tarea", command=lambda:addTask(window))
    addTaskBtn.place(x=15, y=70, width=150, height=40)

    eliminarBtn = Button(window, text="Eliminar tarea", command=lambda:removeTask(window))
    eliminarBtn.place(x=15, y=120, width=150, height=40)

    buscarBtn = Button(window, text="Buscar tarea", command=lambda:searchTask(window))
    buscarBtn.place(x=15, y=170, width=150, height=40)

    listarBtn = Button(window, text="Listar tareas", command=lambda:listTask(window))
    listarBtn.place(x=15, y=220, width=150, height=40)
    
    guardarBtn = Button(window, text="Guardar", command=lambda:saveTask(window))
    guardarBtn.place(x=15, y=270, width=150, height=40)

    salirBtn = Button(window, text="Salir", command=exit)
    salirBtn.place(x=15, y=320, width=150, height=40)



if __name__ == "__main__":
    window = Tk()

    window.title("Task Management")

    window.geometry('800x600')

    generarBotones(window)

    window.mainloop()