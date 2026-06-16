import pygame as pg
import os
import json
from mutagen.mp3 import MP3
import shutil
from tkinter import filedialog
from pathlib import Path
from PySide6.QtCore import QTimer

class mp3Data:
    def __init__(self):
        pg.init()
        self.playing = True
        self.m = pg.mixer.music
        self.songTimePosition = 0
        self.timer = QTimer()
        self.timer.setInterval(200)
        self.timer.timeout.connect(self.updateSlideBar)
        self.m.set_volume(0.1)
        # self.songs = {}
        self.setFile()


    def playPause(self):
        if self.playing:
            self.m.pause()
            self.playing = False
        else:
            self.m.unpause()
            self.playing = True

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
            print(duration)
            firstKey = f"song{i}"

            songs.update(
                {firstKey:
                    {
                        "audio": value.split(".")[0],
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

    def openFile(self):

        # Open the window for selecting the wanted file. There will be aiflter for showing only the MP3 files, but there
        # is also an option  for all files
        filepath = filedialog.askopenfilename(filetypes=(("Mp3 Files", "*.Mp3"), ("all files", "*.*")))

        # Use split for separating the path from the title name. It starts reading from right to left. It makes a split
        # when it finds the first '/'. After finding the first one, it stops. Now it contains two index, 0 (being the
        # path) and 1 (being the title). We select 0 and store the file path.
        path = (filepath.rsplit("/", 1)[0] + '/')

        # Similar to the path, except this one starts splitting from the left.
        name = str(filepath.split("/")[-1])
        self.fileControl(path, name)

    def fileControl(self, sourceDir, fileName):
        print("Source: ", sourceDir)
        print(fileName)

        # Define the path to where the file I want to move is located
        base_dir = Path(__file__).resolve().parent
        destination = base_dir / "files"

        # Relative full path to the file
        sourcePath = os.path.join(sourceDir, fileName)

        # Create the new path to for the file, in which will be moved
        destinationPath = os.path.join(destination, fileName)

        # Move the file from one directory to another
        shutil.copy(sourcePath, destinationPath)

        print(f"File moved from {sourcePath} to {destinationPath}")

    def updateSlideBar(self):
        return self.m.get_pos() + self.songTimePosition

























