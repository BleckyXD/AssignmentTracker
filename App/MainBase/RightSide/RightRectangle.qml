import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
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
            Layout.preferredHeight:160
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

                        //CHANGE TO RECTANGLE
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
                                text: songListView.model[songListView.currentIndex]
                                color: "white"
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
                            enabled: f.updatePermission

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
                            // enabled: f.updatePermission
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
                                    if (songListView.currentIndex > 0)
                                    {
                                        songListView.currentIndex -=1
                                        f.loadSongs(songListView.model[songListView.currentIndex], songListView.currentIndex)
                                    }
                                }
                            }
                            AbstractButton
                            {
                                id:playpause
                                height: 30
                                width: 30
                                icon.source: `../../iconTemplates/${globalTheme.iconFolder}/PlayIcon`
                                background: Rectangle
                                {
                                    color:
                                    {
                                        playpause.down ? "blue" : "transparent"
                                    }
                                    radius: height / 2
                                    Image {
                                        // id: rightArrowIcon
                                        source: playpause.icon.source
                                        sourceSize.width: playpause.width
                                        sourceSize.height: playpause.height
                                        anchors.centerIn: parent
                                        fillMode: Image.PreserveAspectFit
                                    }
                                    ColorOverlay
                                    {
                                        anchors.fill: playpause
                                        source: playpause

                                        color: playpause.down ? "green" : globalTheme.borderColor
                                    }
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
                                    if (songListView.currentIndex < songListView.count - 1)
                                    {
                                        songListView.currentIndex +=1
                                        f.loadSongs(songListView.model[songListView.currentIndex], songListView.currentIndex)
                                    }
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
            Layout.preferredHeight: 140
            color: globalTheme.backgroundRectangleMain
            border.width: 3
            border.color: globalTheme.borderColor
            radius: 8
            clip: true


            ListView
            {
                id:songListView
                anchors.fill: parent
                clip: true
                model: f.musicList

                anchors.margins: 15
                spacing: 5

                highlightRangeMode: ListView.NoHighlightRange
                snapMode: ListView.NoSnap
                boundsBehavior: Flickable.StopAtBounds

                maximumFlickVelocity: 0
                delegate: AbstractButton
                {
                    id: song
                    width: parent.width
                    height: 50
                    Text
                    {
                        // text: modelData.audio
                        text: modelData
                        color: "white"
                        anchors.centerIn: parent
                    }
                    background: Rectangle
                    {
                        color: song.down ? "white" : "blue"
                        radius: 8
                    }
                    onPressed:
                    {
                        f.loadSongs(modelData, index)
                        songListView.currentIndex = index
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
                        id: pageLeftButton
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                        icon.source: `../../iconTemplates/${globalTheme.iconFolder}/ArrowIcon`

                        background: Rectangle
                        {
                            radius: width / 2

                            color: pageLeftButton.pressed ? "#20ffffff" : "transparent"
                            scale: pageLeftButton.pressed ? 0.9 : 1.0
                            border.color: pageLeftButton.pressed ? "green": "transparent"
                            Image {
                                // id: rightArrowIcon
                                source: pageLeftButton.icon.source
                                sourceSize.width: pageLeftButton.width
                                sourceSize.height: pageLeftButton.height
                                anchors.centerIn: parent
                                fillMode: Image.PreserveAspectFit
                                rotation: 180

                            }
                            ColorOverlay
                            {
                                anchors.fill: pageLeftButton
                                source: pageLeftButton

                                color: pageLeftButton.down ? "green" : globalTheme.borderColor
                            }
                        }

                        // Shape
                        // {
                        //     anchors.fill: parent
                        //     antialiasing: true

                        //     ShapePath
                        //     {
                        //         strokeColor: "black"
                        //         strokeWidth: 4
                        //         fillColor: "transparent"
                        //         capStyle: ShapePath.RoundCap // Makes the ends round instead of square
                        //         joinStyle: ShapePath.RoundJoin // Smoothes the "V" joint
                        //         startX: 30; startY: 10
                        //         PathLine { x:15 ; y:25 }
                        //         PathLine { x:30 ; y:40 }
                        //         // PathLine { x:40 ; y:15 }

                        //     }
                        // }
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
                        icon.source: `../../iconTemplates/${globalTheme.iconFolder}/ArrowIcon`
                        Layout.alignment: Qt.AlignLeft

                        background: Rectangle
                        {
                            radius: width / 2

                            color: pageRightButton.down ? "#20ffffff" : "transparent"
                            scale: pageRightButton.down ? 0.9 : 1.0
                            border.color: pageRightButton.down ? "green" : "transparent"
                            Image
                            {
                                source: pageRightButton.icon.source
                                sourceSize.width: pageRightButton.width
                                sourceSize.height: pageRightButton.height
                                anchors.centerIn: parent
                                fillMode: Image.PreserveAspectFit
                            }

                            ColorOverlay {
                                anchors.fill: pageRightButton
                                source: pageRightButton

                                color: pageRightButton.down ? "green" : globalTheme.borderColor
                            }
                            Behavior on scale
                            {
                                NumberAnimation
                                {
                                    duration: 100
                                    easing.type: Easing.OutBack
                                }
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
        AbstractButton
        {
            id: creatorButton
            Layout.alignment: Qt.AlignBottom | Qt.AlignRight
            Layout.preferredWidth: 35
            Layout.preferredHeight: 35
            scale: creatorButton.pressed ? 0.9 : 1.0

            icon.source: `../../iconTemplates/${globalTheme.iconFolder}/AddIcon`
            background: Rectangle
            {
                radius: width / 2
                color: creatorButton.down ? "#20ffffff" : "transparent"
                border.color: creatorButton.down ? "green": "transparent"
                Image
                {
                    // id: rightArrowIcon
                    source: creatorButton.icon.source
                    sourceSize.width: creatorButton.width
                    sourceSize.height: creatorButton.height
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit


                }
                ColorOverlay
                {
                    anchors.fill: creatorButton
                    source: creatorButton

                    color: creatorButton.down ? "green" : globalTheme.borderColor
                }
            }

            onClicked:
            {
                generalPages.append({})
                f.newPage(view.count)
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
    // Popup
    // {
    //     id: songList
    //     parent: openSongList

    //     x: 0
    //     y: 0
    //     z: 50

    //     width: parent.width
    //     height: 300

        // ListView
        // {
        //     id:songListView
        //     anchors.fill: parent
        //     clip: true

        //     model: f.musicList

        //     spacing: 5

        //     highlightRangeMode: ListView.ApplyRange
        //     snapMode: ListView.NoSnap
        //     boundsBehavior: Flickable.StopAtBounds

        //     maximumFlickVelocity: 0
        //     delegate: AbstractButton
        //     {
        //         id: song
        //         width: parent.width
        //         height: 50
        //         Text
        //         {
        //             // text: modelData.audio
        //             text: modelData
        //             color: "white"
        //             anchors.centerIn: parent
        //         }
        //         background: Rectangle
        //         {
        //             color: song.down ? "white" : "blue"
        //         }
        //         onPressed:
        //         {
        //             f.loadSongs(modelData, index)
        //         }
        //     }
        // }

    // }
}

