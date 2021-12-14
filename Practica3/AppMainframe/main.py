# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
from py3270 import *

emulator = Emulator()
emulator.connect("155.210.71.101:123")
emulator.send_enter()
print(emulator.exec_command("ascii".encode('ASCII')).data)


# See PyCharm help at https://www.jetbrains.com/help/pycharm/
