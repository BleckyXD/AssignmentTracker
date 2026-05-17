import sys
import os
import LogicManager as lm
from PySide6.QtCore import QObject, Slot, Signal, Property
from PySide6.QtCore import QObject
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine


app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()


# Point to the App subfolder
qml_file = os.path.join(os.path.dirname(__file__), "App", "main.qml")
engine.rootContext().setContextProperty("f", lm.LogicManager)
engine.load(qml_file)

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())