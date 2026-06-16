from PySide6.QtCore import QObject, Slot, Signal, Property
from PySide6.QtCore import QObject
import json
import pygame as pg
import os
from mutagen.mp3 import MP3
import shutil
from tkinter import filedialog
from pathlib import Path
from PySide6.QtCore import QTimer
# import MP3Player.mp3MainControl as mp3




class QMLManager (QObject):

    musicListChanged = Signal()
    # songTimeChanged = Signal(int)
    # songPositionChanged = Signal(int)
    songDurationChanged = Signal()
    msSongDurationChanged = Signal()
    currentSongTime = Signal()
    changeSongTime = Signal()
    updateSlideBar = Signal()




    def __init__(self, parent=None):
        QObject.__init__(self, parent)

        self.info = {}
        self.classTitle = "ClassTitle"
        self.currentPage = 0
        self.assignmentIndex = ""

        self.currentTime = 0



        pg.init()
        self.playing = True
        self.m = pg.mixer.music
        self.songTimePosition = 0

        self.m.set_volume(0.1)
        self.songList = {}

        self.files = musicFilesManager(self)
        self.audio = musicManager(self)

        self.totalSongDuration = "00:00"
        self.msSongDuration = 0
        self.currentSongIndex = 0
        self.songProgress = 0
        self.currentTimerTime = "00:00"
        self.timePosition = 0
        self.currentMsPosition = 0

    @Property(list, notify=musicListChanged)
    def musicList(self):
        return self.audio.songs()

    @Property(str, notify=songDurationChanged)
    def songDuration(self):
        return self.totalSongDuration

    @Property(int, notify=msSongDurationChanged)
    def msDuration(self):
        return self.msSongDuration

    @Property(str, notify=currentSongTime)
    def getMusicTime(self):

        return self.currentTimerTime

    @Property(str, notify=changeSongTime)
    def changeMusicTime(self):
        return self.currentTimerTime

    @Property(int, notify=updateSlideBar)
    def slideBar(self):
        return  self.currentMsPosition

    @Slot(str, str)
    def loadSongs(self, songName, songPosition):
        selectedSong = f"MP3Player/files/{songName}.mp3"
        self.currentSongIndex = songPosition
        self.m.load(selectedSong)

        for key, value in self.songList.items():
            if str(value["audio"]) == songName:
                self.totalSongDuration = value["duration"]
                self.msSongDuration = value["ms duration"]

        self.songTimePosition = 0
        self.songDurationChanged.emit()
        self.msSongDurationChanged.emit()
        self.updateSlideBar.emit()

        # self.progressBar.setRange(0, self.data[f"song{index + 1}"]["ms duration"])
        print(self.msSongDuration)
        self.audio.timer.start()



        self.m.play()




    @Slot()
    def sliderSongTime(self):
        self.audio.timer.stop()
        # time = self.mp3Class.updateSlideBar()

    def updateSlider(self):
        # self.sendTime.emit(self.currentTime)
        pass

    @Slot()
    def playPause(self):

        if self.playing:
            self.m.pause()
            self.playing = False
            self.audio.timer.stop()
        else:
            self.m.unpause()
            self.playing = True
            self.audio.timer.start()

    @Slot()
    def openFile(self):
        self.files.chooseFile()


    def updateSongTime(self):
        time = int(self.m.get_pos() + self.songTimePosition)
        self.currentMsPosition = time
        if time >= int(self.msSongDuration) or self.m.get_pos() == -1:
            self.audio.timer.stop()

            self.currentMsPosition = 0
            return

        else:
            self.audio.timer.start()
            minutes = int((time / 1000) / 60)
            seconds = int((time / 1000) % 60)
            self.currentTimerTime = str("{:0}:{:02d}".format(minutes, seconds))

            self.currentSongTime.emit()
            self.updateSlideBar.emit()

        print(self.currentMsPosition)


    @Slot(int)
    def sliderCurrentTime(self, time):
        self.songTimePosition = time
        self.audio.timer.stop()
        minutes = int((time / 1000) / 60)
        seconds = int((time / 1000) % 60)
        self.currentTimerTime = str("{:0}:{:02d}".format(minutes, seconds))
        self.currentSongTime.emit()

    @Slot()
    def continueTimer(self):
        self.audio.timer.start()
        self.m.play(start=(self.songTimePosition/ 1000))

    # ==================================================================================================================
    # ==================================================================================================================
    #==================================================================================================================

    def SAVE(self):
        with open("assignmentData.json", "w") as f:
            json.dump(self.info, f, indent=4)
        print("File Saved!")

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
        self.info[data] = {"Class Title": "", "Assignments": {}}

        print(self.info)

        #Save the new dictionary
        self.SAVE()

    #Save the assignment data.
    @Slot(dict)
    def saveAssignmentData(self, data):
        self.info[self.currentPage]["Assignments"].update(data)
        print(data)

        self.SAVE()

    @Slot(str)
    def assignmentTitle(self, title):
        self.info[self.currentPage]["Assignments"][self.assignmentIndex]["title"] = title

        self.SAVE()


    @Slot(str)
    def priority(self, status):
        self.info[self.currentPage]["Assignments"][self.assignmentIndex]["status"] = status

        print(status)

        self.SAVE()

    #Save the title of the page
    @Slot(str)
    def title(self, title):

        #Store the title on the json file that we are using under a specific key
        self.info[self.currentPage]["Class Title"] = title

        #Save the information of the assignments

        self.SAVE()

    @Slot(str)
    def saveTime(self, time):
        self.info[self.currentPage]["Assignments"][self.assignmentIndex]["time"] = time

        self.SAVE()



class musicFilesManager:
    def __init__(self, main_app):
        self.main = main_app

    def setFile(self):
        files = os.listdir("C:/PROJECTS/MP3Player/files")

        songs = {}
        i = 1
        for value in files:
            audio = MP3("MP3Player/files/" + value)

            duration_seconds = audio.info.length
            ms = int(duration_seconds * 1000)
            minutes = int((ms / 1000) / 60)
            seconds = int((ms / 1000) % 60)
            duration = f"{minutes:02d}:{seconds:02d}"

            firstKey = f"song{i}"
            songs.update(
                {firstKey:
                      {
                        "audio": value.rsplit(".", 1)[0],
                        "ms duration": ms,
                        "duration": duration
                    }
                })

            i += 1

        # with open("sample.json", "w") as f:
        #     json_str = json.dumps(songs, indent=4)
        #     f.write(json_str)
        # self.songs = songs

        return songs

    def chooseFile(self):

        # Open the window for selecting the wanted file. There will be a filter for showing only the MP3 files, but there
        # is also an option  for all files
        filepath = filedialog.askopenfilename(filetypes=(("Mp3 Files", "*.Mp3"), ("all files", "*.*")))

        # Use split for separating the path from the title name. It starts reading from right to left. It makes a split
        # when it finds the first '/'. After finding the first one, it stops. Now it contains two index, 0 (being the
        # path) and 1 (being the title). We select 0 and store the file path.
        path = (filepath.rsplit("/", 1)[0] + '/')

        # Similar to the path, except this one starts splitting from the left.
        name = str(filepath.split("/")[-1])
        print(f"Filename: {name} | Path: {path}")
        self.fileControl(path, name)

    def fileControl(self, sourceDir, fileName):
        # print("Source: ", sourceDir)
        # print(fileName)

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
        self.main.musicList()

        self.main.musicListChanged.emit()

class musicManager:
    def __init__(self, main_app):
        self.main = main_app

        self.timer = QTimer()
        self.timer.setInterval(200)
        self.timer.timeout.connect(self.main.updateSongTime)

    def songs(self):
        self.main.songList = self.main.files.setFile()
        music = (list(self.main.songList.values()))
        print("activated!")

        return music

    def time(self):
        pass


LogicManager = QMLManager()
