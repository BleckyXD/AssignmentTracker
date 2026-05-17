from PySide6.QtCore import QObject, Slot, Signal, Property
from PySide6.QtCore import QObject

class QMLManager (QObject):

    def __init__(self, parent=None):
        QObject.__init__(self, parent)

    @Slot()
    def rightChangePage(self):
        print("Change right")

    @Slot()
    def addPage(self):
        print("1 page added")

    @Slot()
    def leftChangePage(self):
        print("Change left")

    @Slot()
    def openDetails(self):
        print("Details")
    # @Slot()
    # def rightChangePage(self):
LogicManager = QMLManager()
