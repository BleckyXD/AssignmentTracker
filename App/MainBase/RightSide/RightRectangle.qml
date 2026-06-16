import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls

Rectangle
{
    Layout.preferredWidth: mainWindow.width / 4
    Layout.fillHeight: true
    color: "transparent"

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 12

        Rectangle
        {
            Layout.preferredWidth:250
            Layout.preferredHeight:300
            color: "#0f3460"
            radius: 8

            ColumnLayout
            {
                anchors.fill: parent
                anchors.margins: 3
                spacing: 5

                AbstractButton
                {
                    id: hourTime
                    height: 70
                    Layout.fillWidth: true
                    background: Rectangle
                    {
                        color: hourTime.down ? "blue" : "white"
                        radius: 8
                    }
                }

                AbstractButton
                {
                    id:a
                    height: 20
                    Layout.fillWidth: true
                    background: Rectangle
                    {
                        color: "black"
                        radius: 8
                    }
                }
                Rectangle
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "red"
                    radius: 8

                    ColumnLayout
                    {
                        anchors.fill: parent
                        anchors.margins: 4


                        AbstractButton
                        {
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
                                color: "black"
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
                                color: "blue"
                                height: parent.height
                                radius: parent.radius
                                width: musicTime.visualPosition * parent.width
                            }

                        }
                        Rectangle
                        {
                            height: 2
                            Layout.fillWidth: true
                            color: "white"
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
                                    color: "black"
                                    radius: height / 2
                                }
                            }
                            AbstractButton
                            {
                                id:playpause
                                height: 30
                                width: 30
                                background: Rectangle
                                {
                                    color: "blue"
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
                                    color: "black"
                                    radius: height / 2
                                }
                            }
                        }
                    }

                }
                AbstractButton
                {
                    height: 20
                    width: 20
                    Layout.alignment: Qt.AlignRight
                    background: Rectangle
                    {
                        color: "white"
                        radius: 8
                    }

                }
            }
        }

        Rectangle
        {

            id: pageRightButton
            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            border.width: 1
            Layout.alignment: Qt.AlignRight
            // color: "black"
            radius: width / 2
            color: clickArea.pressed ? "#20ffffff" : "white"
            scale: clickArea.pressed ? 0.9 : 1.0
            border.color: clickArea.pressed ? "green": "black"
            Shape
            {
                anchors.fill: parent
                antialiasing: true

                ShapePath
                {
                    strokeColor: "gray"
                    strokeWidth: 4
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap // Makes the ends round instead of square
                    joinStyle: ShapePath.RoundJoin // Smoothes the "V" joint
                    startX:20; startY:10
                    PathLine { x: 35; y: 25 }
                    PathLine { x: 20; y: 40 }
                }
            }
            MouseArea
            {
                id: clickArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                // Sending action to Python
                onClicked:
                {

                    if (view.currentIndex < view.count - 1)
                    {
                        view.currentIndex++
                    }
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
            Layout.fillHeight: true
        }
        Rectangle
        {
            id: creatorButton
            Layout.alignment: Qt.AlignBottom | Qt.AlignRight
            Layout.preferredWidth: 35
            Layout.preferredHeight: 35
            radius: width / 2
            color: addPage.pressed ? "#20ffffff" : "white"
            scale: addPage.pressed ? 0.9 : 1.0
            border.color: addPage.pressed ? "green": "white"
            Shape
            {
                anchors.fill: parent
                antialiasing: true

                ShapePath
                {
                    strokeColor: "gray"
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
        parent: Overlay.overlay
        x: ((mainWindow.width - width) / 2)
        y: (mainWindow.height - height) / 2
        z: 50
        width: mainWindow.width * 0.95
        height: mainWindow.height * 0.80
        ListView
        {
            id:songListView
            anchors.fill: parent
            clip: true

            model: f.musicList

            delegate: AbstractButton
            {
                id: song
                width: 100
                height: 100
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

