import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls

Rectangle
{
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: "transparent"

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 12

        Rectangle
        {

            height: 70
            Layout.fillWidth: true
            color: globalTheme.clockColor
            radius: 8
            border.width: 3
            border.color:globalTheme.borderColor
            Text
            {
                text: f.clockUpdate
                color: "white"
                font.pixelSize: 40
                anchors.centerIn: parent

            }
        }
        Rectangle
        {
            Layout.fillWidth: true
            Layout.preferredHeight:180
            color: globalTheme.backgroundRectangleMain
            border.color: globalTheme.borderColor
            border.width: 3
            radius: 8


            ColumnLayout
            {
                anchors.fill: parent
                anchors.margins: 3
                spacing: 5

                // AbstractButton
                // {
                //     height: 20
                //     Layout.fillWidth: true
                //     background: Rectangle
                //     {
                //         color: "black"
                //         radius: 8
                //     }
                // }
                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: globalTheme.backgroundRectangleMain
                    radius: 8

                    ColumnLayout
                    {
                        anchors.fill: parent
                        anchors.margins: 4


                        AbstractButton
                        {
                            id: openSongList
                            height: 50

                            Layout.fillWidth: true
                            background: Rectangle
                            {
                                color: "black"
                            }

                            Text
                            {
                                anchors.centerIn: parent
                                text: "song playing"
                                color: "white"
                            }
                            onPressed:
                            {
                                songList.open()
                            }


                        }
                        AbstractButton
                        {
                            height: 25
                            width: 80

                            Layout.alignment: Qt.AlignHCenter
                            background: Rectangle
                            {
                                color: "white"
                                radius: height/2
                            }

                            Text
                            {
                                anchors.centerIn: parent
                                text: "Add Song..."
                                color: "black"
                            }
                            onPressed:
                            {
                                f.openFile()
                            }
                        }
                        Rectangle
                        {
                            height:15
                            width: 45
                            color: "transparent"
                            // Layout.fillWidth: true
                            // Layout.fillHeight: true
                            Layout.alignment: Qt.AlignRight
                            Row
                            {
                                anchors.bottom: parent.bottom
                                anchors.right: parent.right
                                Text
                                {
                                    id: movingTime
                                    text: f.getMusicTime
                                    color: "white"
                                }
                                Text
                                {

                                    text: "/"
                                    color: "white"
                                }
                                Text
                                {
                                    id: totalTime
                                    text: f.songDuration
                                    color: "white"
                                }
                            }
                        }
                        Slider
                        {
                            id:musicTime
                            from: 0
                            to: f.msDuration
                            value: f.slideBar
                            Layout.fillWidth: true
                            Layout.preferredHeight: 5
                            Layout.alignment: Qt.AlignHCenter

                            onPressedChanged:
                            {
                                if (musicTime.pressed) {}
                                else
                                {
                                    f.continueTimer()
                                }
                            }
                            onPositionChanged:
                            {
                                if(musicTime.pressed)
                                {
                                    f.sliderCurrentTime(musicTime.value)
                                }
                            }


                            handle: Rectangle
                            {
                                height: 12
                                width: 12
                                radius: height/2
                                x: musicTime.leftPadding + musicTime.visualPosition * (musicTime.availableWidth - width)
                                y: musicTime.topPadding + (musicTime.availableHeight - height) / 2
                                color: globalTheme.mp3Slider
                            }
                            background: Rectangle
                            {
                                x: musicTime.leftPadding
                                y: musicTime.topPadding + (musicTime.availableHeight - height) / 2
                                implicitWidth: 200
                                implicitHeight: 5
                                width: musicTime.availableWidth
                                height: implicitHeight
                                radius: 3
                            }
                            Rectangle
                            {
                                color: globalTheme.sliderBackground
                                height: parent.height
                                radius: parent.radius
                                width: musicTime.visualPosition * parent.width
                            }

                        }

                        RowLayout
                        {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 45
                            Layout.alignment: Qt.AlignHCenter
                            AbstractButton
                            {
                                height: 15
                                width: 30
                                background: Rectangle
                                {
                                    color: globalTheme.buttons
                                    radius: height / 2
                                }
                                onPressed:
                                {
                                    songListView.currentIndex -=1
                                }
                            }
                            AbstractButton
                            {
                                id:playpause
                                height: 30
                                width: 30
                                background: Rectangle
                                {
                                    color:
                                    {

                                        playpause.down ? "blue" : globalTheme.buttons
                                    }
                                    radius: height / 2
                                }
                                onPressed:
                                {
                                    f.playPause()
                                }

                            }
                            AbstractButton
                            {
                                height: 15
                                width: 30

                                background: Rectangle
                                {
                                    color: globalTheme.buttons
                                    radius: height / 2
                                }
                                onPressed:
                                {
                                    songListView.currentIndex +=1
                                }
                            }
                        }

                    }
                }

            }
        }
        Rectangle
        {
            Layout.fillWidth: true
            Layout.preferredHeight: 125
            color: globalTheme.backgroundRectangleMain
            border.width: 3
            border.color: globalTheme.borderColor
            radius: 8

            ColumnLayout
            {
                anchors.fill: parent
                anchors.margins: 6
                // Rectangle
                // {
                //     Layout.preferredHeight: 35
                //     Layout.fillWidth: true
                //     radius: 8
                //     color: "transparent"
                //     border.width: 3
                //     border.color: globalTheme.borderColor
                //     Text
                //     {
                //         text: "Controls"
                //         font.pixelSize: 25
                //         anchors.centerIn: parent

                //     }
                // }
                RowLayout
                {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 6

                    AbstractButton
                    {
                        id: leftPage
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50

                        background: Rectangle
                        {
                            radius: width / 2

                            color: leftPage.pressed ? "#20ffffff" : globalTheme.buttons
                            scale: leftPage.pressed ? 0.9 : 1.0
                            border.color: leftPage.pressed ? "green": globalTheme.borderColor
                        }
                        Shape
                        {
                            anchors.fill: parent
                            antialiasing: true

                            ShapePath
                            {
                                strokeColor: "black"
                                strokeWidth: 4
                                fillColor: "transparent"
                                capStyle: ShapePath.RoundCap // Makes the ends round instead of square
                                joinStyle: ShapePath.RoundJoin // Smoothes the "V" joint
                                startX: 30; startY: 10
                                PathLine { x:15 ; y:25 }
                                PathLine { x:30 ; y:40 }
                                // PathLine { x:40 ; y:15 }

                            }
                        }
                        onClicked:
                        {
                            if (view.currentIndex > 0)
                            {
                                view.currentIndex--
                            }
                        }
                        Behavior on scale
                        {
                            NumberAnimation
                            {
                                duration: 100
                                easing.type: Easing.OutBack // Adds a little "bounce" effect
                            }
                        }
                    }

                    AbstractButton
                    {
                        id: pageRightButton
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50

                        Layout.alignment: Qt.AlignLeft
                        background: Rectangle
                        {
                            border.width: 1
                            radius: width / 2
                            color: pageRightButton.down ? "#20ffffff" : globalTheme.buttons
                            scale: pageRightButton.down ? 0.9 : 1.0
                            border.color: pageRightButton.down ? "green": globalTheme.borderColor
                        }
                        Shape
                        {
                            anchors.fill: parent
                            antialiasing: true

                            ShapePath
                            {
                                strokeColor: "black"
                                strokeWidth: 4
                                fillColor: "transparent"
                                capStyle: ShapePath.RoundCap // Makes the ends round instead of square
                                joinStyle: ShapePath.RoundJoin // Smoothes the "V" joint
                                startX:20; startY:10
                                PathLine { x: 35; y: 25 }
                                PathLine { x: 20; y: 40 }
                            }
                        }
                        onClicked:
                        {
                            if (view.currentIndex < view.count - 1)
                            {
                                view.currentIndex++
                            }
                        }
                        Behavior on scale
                        {
                            NumberAnimation
                            {
                                duration: 100
                                easing.type: Easing.OutBack // Adds a little "bounce" effect
                            }
                        }
                    }
                    Item
                    {
                        Layout.fillWidth: true
                    }
                    AbstractButton
                    {
                        id: settingsOpen
                        height: 45
                        width: 45
                        Layout.alignment: Qt.AlignLeft
                        background: Rectangle
                        {
                            color: settingsOpen.down ? "black" : globalTheme.buttons
                            radius: width / 4
                            border.color: globalTheme.borderColor
                            border.width: 3
                        }
                        onClicked:
                        {
                            settingsLoader.source = "Settings.qml";
                        }

                    }
                }
                AbstractButton
                {
                    height: 35
                    Layout.fillWidth: true
                    background: Rectangle
                    {
                        color: "black"
                        radius: 8
                        border.width: 3
                        border.color: globalTheme.borderColor
                    }
                    // Text
                    // {
                    //     text: "Color Themes"
                    //     font.pixelSize: 18
                    //     color: "white"
                    //     anchors.centerIn: parent
                    // }
                }
            }
        }
        Item
        {
            Layout.fillHeight: true
        }
        Rectangle
        {
            id: creatorButton
            Layout.alignment: Qt.AlignBottom | Qt.AlignRight
            Layout.preferredWidth: 35
            Layout.preferredHeight: 35
            radius: width / 2
            color: addPage.pressed ? "#20ffffff" : globalTheme.buttons
            scale: addPage.pressed ? 0.9 : 1.0
            border.color: addPage.pressed ? "green": globalTheme.borderColor
            Shape
            {
                anchors.fill: parent
                antialiasing: true

                ShapePath
                {
                    strokeColor: "black"
                    strokeWidth: 4
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap // Makes the ends round instead of square
                    joinStyle: ShapePath.RoundJoin // Smoothes the "V" joint
                    startX: 18; startY: 5
                    PathLine { x:18 ; y:30}
                    // PathMove { x:5 ; y:25}
                    // PathLine { x:45 ; y:25}

                }
            }
            MouseArea
            {
                id: addPage
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                // Sending action to Python
                onClicked:
                {
                    generalPages.append({})
                    // f.newPage({"lastPage": view.count})
                    f.newPage(view.count)
                }
            }
            Behavior on scale
            {
                NumberAnimation
                {
                    duration: 100
                    easing.type: Easing.OutBack // Adds a little "bounce" effect
                }
            }

        }
    }
    Popup
    {
        id: songList
        parent: openSongList

        x: 0
        y: 0
        z: 50

        width: parent.width
        height: 100

        ListView
        {
            id:songListView
            anchors.fill: parent
            clip: true

            model: f.musicList

            spacing: 74
            snapMode: ListView.SnapOneItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            boundsBehavior: Flickable.StopAtBounds

            maximumFlickVelocity: 0
            delegate: AbstractButton
            {
                id: song
                width: parent.width
                height: 74
                Text
                {
                    text: modelData.audio
                    color: "white"
                    anchors.centerIn: parent
                }
                background: Rectangle
                {
                    color: song.down ? "white" : "blue"
                }
                onPressed:
                {
                    f.loadSongs(modelData.audio, index)
                }
            }
        }

    }
}

