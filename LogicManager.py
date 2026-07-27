from PySide6.QtCore import QObject, Slot, Signal, Property
import json
import pygame as pg
import os
from mutagen.mp3 import MP3
import shutil
from tkinter import filedialog
from pathlib import Path
from PySide6.QtCore import QTimer
from datetime import datetime as dt
from zoneinfo import ZoneInfo as zi

class QMLManager (QObject):

    musicListChanged = Signal()
    songDurationChanged = Signal()
    msSongDurationChanged = Signal()
    currentSongTime = Signal()
    changeSongTime = Signal()
    updateSlideBar = Signal()

    updateClock = Signal()

    updateColors = Signal()

    audioPermission = Signal()

    def __init__(self, parent=None):
        QObject.__init__(self, parent)

        self.info = {}
        self.classTitle = "ClassTitle"
        self.currentPage = 0
        self.assignmentIndex = ""

        self.currentTime = 0


        self.files = musicFilesManager(self)
        self.audio = musicManager(self)

        self.clockTimer = QTimer(self)
        self.clockTimer.setInterval(1000)
        self.clockTimer.timeout.connect(self.clock)

        self.colorsSelected = {"General Background": "#16213e", "Main Background": "black","Border Color": "White",
                               "Rectangle Info": "red", "Buttons": "blue", "Clock": "#16213e",
                               "MP3 Colors": "red", "Icon Folder": "Full","Font": "PixelifySans-Medium.ttf",
                               "Title Font": "white", "Info Font": "white"}



    @Property(list, notify=musicListChanged)
    def musicList(self):
        return self.audio.songs()

    @Property(str, notify=songDurationChanged)
    def songDuration(self): return self.audio.totalSongDuration

    @Property(int, notify=msSongDurationChanged)
    def msDuration(self): return self.audio.msSongDuration

    @Property(str, notify=currentSongTime)
    def getMusicTime(self): return self.audio.currentTimerTime

    @Property(str, notify=changeSongTime)
    def changeMusicTime(self): return self.audio.currentTimerTime

    @Property(int, notify=updateSlideBar)
    def slideBar(self): return  self.audio.currentMsPosition

    @Property(bool, notify=audioPermission)
    def updatePermission(self):
        return self.audio.buttonPermissions


    #When the song is pressed, the name is passed and then looked for
    @Slot(str, str)
    def loadSongs(self, songName, songPosition):
        self.audio.playing = True
        print(f"SONG POSITION: {songPosition}")

        if not self.audio.buttonPermissions:
            self.audio.buttonPermissions = True
            self.audioPermission.emit()

        selectedSong = f"MP3Player/files/{songName}.mp3"

        self.audio.currentSongIndex = songPosition
        self.audio.m.load(selectedSong)

        self.audio.totalSongDuration = self.audio.songList[f"{songName}"]["duration"]
        self.audio.msSongDuration = self.audio.songList[f"{songName}"]["ms duration"]

        self.audio.songTimePosition = 0
        self.songDurationChanged.emit()
        self.msSongDurationChanged.emit()
        self.updateSlideBar.emit()

        self.audio.timer.start()

        self.audio.m.play()

    @Slot()
    def sliderSongTime(self): self.audio.timer.stop()

    @Slot()
    def playPause(self):

        if self.audio.playing:
            self.audio.m.pause()
            self.audio.playing = False
            self.audio.timer.stop()
        else:

            if self.audio.sliderState:
                self.audio.m.play(start=(self.audio.songTimePosition / 1000))
            else:
                self.audio.m.unpause()
            self.audio.playing = True
            self.audio.timer.start()


    @Slot()
    def openFile(self): self.files.chooseFile()

    @Slot(int)
    def sliderCurrentTime(self, time):
        self.audio.songTimePosition = time
        self.audio.timer.stop()
        minutes = int((time / 1000) / 60)
        seconds = int((time / 1000) % 60)
        self.audio.currentTimerTime = str("{:0}:{:02d}".format(minutes, seconds))
        self.currentSongTime.emit()

    @Slot()
    def continueTimer(self):
        if self.audio.playing:
            self.audio.timer.start()
            self.audio.m.play(start=(self.audio.songTimePosition/ 1000))
            self.audio.sliderState = False
        else:
            self.audio.sliderState = True

    @Slot()
    def timerState(self):
        self.audio.sliderState = True
    # ==================================================================================================================
    # ==================================================================================================================
    #==================================================================================================================

    #Obtain the current index of the page
    @Slot(int)
    def retrieveIndex(self, index):

        #Set the current index of the page to our class variable
        self.currentPage = index + 1
        print(f"Page: {self.currentPage}")

    # Receive the index of the assignment that we are in
    @Slot(int)
    def retrieveAssignmentIndex(self, index):
        print(index)
        self.assignmentIndex = str(index)
        print(f"Page: {self.currentPage} \nAssignment: {self.assignmentIndex}")




    #Create a space for the data of a new page
    @Slot(int)
    def newPage(self, data):

        #Declare the dictionary for saving the information
        self.info[data] = {"Class Title": "", "Class Details": "", "TodoList": {}, "Assignments": {}}

        print(self.info)

        #Save the new dictionary
        self.files.SAVE()

    #Save the assignment data.
    @Slot(dict)
    def saveAssignmentData(self, data):
        self.info[self.currentPage]["Assignments"].update(data)
        print(data)

        self.files.SAVE()

    @Slot(str)
    def assignmentTitle(self, title):
        self.info[self.currentPage]["Assignments"][self.assignmentIndex]["title"] = title

        self.files.SAVE()


    @Slot(str)
    def priority(self, status):
        self.info[self.currentPage]["Assignments"][self.assignmentIndex]["status"] = status

        print(status)

        self.files.SAVE()

    #Save the title of the page
    @Slot(str)
    def title(self, title):

        #Store the title on the json file that we are using under a specific key
        self.info[self.currentPage]["Class Title"] = title

        #Save the information of the assignments

        self.files.SAVE()

    @Slot(str)
    def saveTime(self, time):
        self.info[self.currentPage]["Assignments"][self.assignmentIndex]["time"] = time
        print(time)

        self.files.SAVE()

    @Slot(str)
    def classDetails(self, details):
        self.info[self.currentPage]["Class Details"] = details

        self.files.SAVE()

    @Slot(dict)
    def classTodoList(self, todo):
        self.info[self.currentPage]["TodoList"].update(todo)

        self.files.SAVE()

    @Slot(str, str)
    def specificTodoList(self, toDoInfo, todoIndex):

        self.info[self.currentPage]["TodoList"][todoIndex]["todoInfo"] = toDoInfo

        self.files.SAVE()

    @Slot()
    def startClockTimer(self):
        self.clockTimer.start()
        self.updateColors.emit()
        print("STARTS")


    @Property(str, notify=updateClock)
    def clockUpdate(self):
        return dt.now().strftime("%#I:%M:%S %p")

    def clock(self):
        self.updateClock.emit()

    @Property(dict, notify=updateColors)
    def sendingColors(self):
        print("sending colors!!!")
        return self.colorsSelected


    @Slot(str, str)
    def receiveOptionColor(self, currentOption, color):
        self.colorsSelected[currentOption] = color
        print(self.colorsSelected)
        self.updateColors.emit()



class musicFilesManager:
    def __init__(self, main_app):
        self.main = main_app



    def SAVE(self):
        with open("assignmentData.json", "w") as f:
            json.dump(self.main.info, f, indent=4)
        print("File Saved!")

    #use the enum way for the for loop
    def setFile(self):
        files = os.listdir("C:/PROJECTS/MP3Player/files")

        with open('songData.json', 'r') as f:
            songs = json.load(f)

        # i = 1
        # for value in files:
        #     audio = MP3("MP3Player/files/" + value)
        #
        #     duration_seconds = audio.info.length
        #     ms = int(duration_seconds * 1000)
        #     minutes = int((ms / 1000) / 60)
        #     seconds = int((ms / 1000) % 60)
        #     duration = f"{minutes:0}:{seconds:02d}"
        #
        #     firstKey = f"song{i}"
        #     songs.update(
        #         {firstKey:
        #               {
        #                 "audio": value.rsplit(".", 1)[0],
        #                 "ms duration": ms,
        #                 "duration": duration
        #             }
        #         })
        #
        #     i += 1
        #
        # with open("songData.json", "w") as f:
        #     json_str = json.dumps(songs, indent=4)
        #     f.write(json_str)


        return songs

    def mList(self):
        return self.main.audio.songs()

    def chooseFile(self):

        # Open the window for selecting the wanted file. There will be a filter for showing only the MP3 files, but there
        # is also an option  for all files
        filepath = filedialog.askopenfilename(filetypes=(("Mp3 Files", "*.Mp3"), ("all files", "*.*")))
        if filepath:
            # Use split for separating the path from the title name. It starts reading from right to left. It makes a split
            # when it finds the first '/'. After finding the first one, it stops. Now it contains two index, 0 (being the
            # path) and 1 (being the title). We select 0 and store the file path.
            path = (filepath.rsplit("/", 1)[0] + '/')

            # Similar to the path, except this one starts splitting from the left.
            name = str(filepath.split("/")[-1])
            print(f"Filename: {name} | Path: {path}")
            self.fileControl(path, name)

    #When pressing the "add song" button
    def fileControl(self, sourceDir, fileName):
        print(fileName)

        # Define the path to where the file I want to move is located
        base_dir = Path(__file__).resolve().parent
        destination = base_dir / "MP3Player/files"
        print(destination)
        # Relative full path to the file
        sourcePath = os.path.join(sourceDir, fileName)
        print(sourcePath)
        # Create the new path to for the file, in which will be moved
        destinationPath = os.path.join(destination, fileName)
        print(destinationPath)
        # Move the file from one directory to another
        shutil.copy(sourcePath, destinationPath)

        print(f"File moved from {sourcePath} to {destinationPath}")



        audio = MP3("MP3Player/files/" + fileName)

        duration_seconds = audio.info.length
        ms = int(duration_seconds * 1000)
        minutes = int((ms / 1000) / 60)
        seconds = int((ms / 1000) % 60)
        duration = f"{minutes:0}:{seconds:02d}"

        firstKey = f"{fileName.rsplit(".", 1)[0]}"
        self.main.audio.songList.update(
            {firstKey:
                  {
                    # "audio": fileName.rsplit(".", 1)[0],
                    "ms duration": ms,
                    "duration": duration
                }
            })


        with open("songData.json", "w") as f:
            json_str = json.dumps(self.main.audio.songList, indent=4)
            f.write(json_str)

        self.mList()

        self.main.musicListChanged.emit()

class musicManager:
    def __init__(self, main_app):
        self.main = main_app

        pg.init()
        self.m = pg.mixer.music
        self.m.set_volume(0.1)

        self.timer = QTimer()
        self.timer.setInterval(200)
        self.timer.timeout.connect(self.updateSongTime)

        self.songList = {}
        self.playing = True
        self.sliderState = False
        self.buttonPermissions = False

        self.totalSongDuration = "0:00"
        self.msSongDuration = 0
        self.currentSongIndex = 0
        #self.songProgress = 0
        self.currentTimerTime = "0:00"
        #self.timePosition = 0
        self.songTimePosition = 0
        self.currentMsPosition = 0

    def songs(self):
        self.songList = self.main.files.setFile()
        music = (list(self.songList))

        print("activated!")

        return music

    def time(self):
        pass
    def updateSongTime(self):
        time = int(self.m.get_pos() + self.songTimePosition)
        self.currentMsPosition = time
        print(self.totalSongDuration)
        if time >= int(self.msSongDuration) or self.m.get_pos() == -1:
            self.main.audio.timer.stop()

            self.currentMsPosition = int(self.msSongDuration)
            self.currentTimerTime = str(self.totalSongDuration)


            self.main.currentSongTime.emit()
            self.main.updateSlideBar.emit()

            self.currentMsPosition = 0
            return

        else:
            self.main.audio.timer.start()
            minutes = int((time / 1000) / 60)
            seconds = int((time / 1000) % 60)
            self.currentTimerTime = str("{:0}:{:02d}".format(minutes, seconds))

            self.main.currentSongTime.emit()
            self.main.updateSlideBar.emit()

        print(self.currentMsPosition)


LogicManager = QMLManager()
