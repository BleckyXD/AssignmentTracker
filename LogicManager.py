from PySide6.QtCore import QObject, Slot, Signal, Property
from PySide6.QtCore import QObject
import json

class QMLManager (QObject):

    def __init__(self, parent=None):
        QObject.__init__(self, parent)
        self.info = {"": {"Assignments": {}}}
        self.classTitle = "ClassTitle"

    @Slot(dict)
    def initializeData(self, data):
        print(data)
        with open("assignmentData.json", "w") as f:
            json.dump(data, f, indent=4)
        print("File Saved!")


    # @Slot(list)
    # def saveData(self, data):
    #     self.info[self.classTitle]["Assignments"] = data
    #
    #     with open("assignmentData.json", "w") as f:
    #         json.dump(self.info, f, indent=4)
    #     print("File Saved!")
    #
    # @Slot(str)
    # def title(self, title):
    #
    #     # Erase the key and only add the new ones. That way we can add multiple classes at once, without erasing them
    #     if "" in self.info:
    #         self.info[title] = self.info.pop("")
    #         self.classTitle = title
    #
    #
    #
    #     else:
    #         self.info[title] = self.info.pop(self.classTitle)
    #         self.classTitle = title
    #
    #
    #     with open("assignmentData.json", "w") as f:
    #         json.dump(self.info, f, indent=4)
    #     print("File Saved!")

LogicManager = QMLManager()
