import QtQuick 6.0
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
Rectangle
{
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: "transparent"
    property int currentSongIndex: 0

    ColumnLayout
    {
        id: rightAreaRectangle
        anchors.fill: parent
        spacing: 10

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
                font.family: globalTheme.font
                text: f.clockUpdate
                color: "white"
                font.pixelSize: 40
                anchors.centerIn: parent

            }
        }
        Rectangle
        {
            Layout.fillWidth: true
            Layout.preferredHeight:175
            color: globalTheme.backgroundRectangleMain
            border.color: globalTheme.borderColor
            border.width: 3
            radius: 8


            ColumnLayout
            {
                anchors.fill: parent
                spacing: 5
                anchors.margins: 4

                Rectangle
                {
                    height: 50
                    color: "black"
                    Layout.fillWidth: true
                    Text
                    {
                        id: currentFile
                        font.family: globalTheme.font
                        anchors.centerIn: parent
                        // text:songListView.model[songListView.currentIndex]


                        font.pixelSize: 18
                        color: globalTheme.infoFont
                    }
                }
                AbstractButton
                {
                    id: addFile
                    height: 25
                    width: 80
                    scale: addFile.down ? 0.8 : (addFile.hovered ? 1.0 : 0.9)

                    Layout.alignment: Qt.AlignHCenter
                    background: Rectangle
                    {
                        color:addFile.down ? Qt.lighter(globalTheme.buttons, 0.5) : (addFile.hovered ? Qt.lighter(globalTheme.buttons, 1.5) : globalTheme.buttons)
                        radius: height/2
                        border.color: globalTheme.borderColor
                        Behavior on color
                        {
                            ColorAnimation
                            {
                                duration: 120
                                easing.type: Easing.InOutQuad
                            }
                        }

                    }

                    Text
                    {
                        font.family: globalTheme.font
                        anchors.centerIn: parent
                        text: "Add MP3..."
                        color: globalTheme.infoFont
                    }
                    onReleased:
                    {
                        f.openFile()
                    }
                    Behavior on scale
                    {
                        NumberAnimation
                        {
                            duration: 200
                            easing.type: Easing.OutBack // Adds a little "bounce" effect
                        }
                    }
                }
                RowLayout
                {

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignRight

                    Text
                    {
                        font.family: globalTheme.font

                        id: movingTime
                        text: f.getMusicTime
                        color: globalTheme.infoFont
                    }
                    Text
                    {
                        font.family: globalTheme.font

                        text: "/"
                        color: globalTheme.infoFont
                    }
                    Text
                    {
                        font.family: globalTheme.font
                        id: totalTime
                        text: f.songDuration
                        color: globalTheme.infoFont
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
                        color: globalTheme.mp3Color
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
                        opacity: !enabled ? 0.5 : 1.0
                    }
                    Rectangle
                    {
                        color: Qt.lighter(globalTheme.mp3Color, 0.4)
                        height: parent.height
                        radius: parent.radius
                        width: musicTime.visualPosition * parent.width
                    }
                }
                Rectangle
                {
                    Layout.preferredHeight: 35
                    Layout.preferredWidth: 140
                    radius: 4
                    color: globalTheme.buttons
                    Layout.alignment: Qt.AlignHCenter
                    RowLayout
                    {

                        anchors.centerIn: parent
                        spacing: 6
                        // enabled: f.updatePermission


                        AbstractButton
                        {
                            id: skipLeft
                            height: 30
                            width: 40
                            scale: skipLeft.down ? 0.8 : (skipLeft.hovered ? 1.0 : 0.9)
                            hoverEnabled: enabled
                            opacity: !enabled ? 0.5 : 1.0
                            icon.source: `../../iconTemplates/${globalTheme.iconFolder}/SkipIcon`
                            enabled: f.updatePermission
                            background: Rectangle
                            {

                                radius: height / 2
                                color:skipLeft.down ? Qt.lighter(globalTheme.buttons, 0.5) : (skipLeft.hovered ? Qt.lighter(globalTheme.buttons, 1.5) : globalTheme.buttons)

                                Image
                                {
                                    source: skipLeft.icon.source
                                    sourceSize.width: 30
                                    sourceSize.height: 30
                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit
                                    rotation: 180
                                }
                                Behavior on color
                                {
                                    ColorAnimation
                                    {
                                        duration: 120
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }
                            onReleased:
                            {
                                if (currentSongIndex > 0)
                                {
                                    currentSongIndex -=1
                                    f.loadSongs(listSongs.model[currentSongIndex], currentSongIndex)


                                }
                            }
                            Behavior on scale
                            {
                                NumberAnimation
                                {
                                    duration: 200
                                    easing.type: Easing.OutBack // Adds a little "bounce" effect
                                }
                            }
                        }
                        AbstractButton
                        {
                            id:playpause
                            height: 35
                            width: 35
                            scale: playpause.down ? 0.8 : (playpause.hovered ? 1.0 : 0.9)
                            hoverEnabled: enabled
                            opacity: !enabled ? 0.5 : 1.0
                            icon.source: `../../iconTemplates/${globalTheme.iconFolder}/PlayIcon`
                            enabled: f.updatePermission
                            background: Rectangle
                            {
                                color:playpause.down ? Qt.lighter(globalTheme.buttons, 0.5) : (playpause.hovered ? Qt.lighter(globalTheme.buttons, 1.5) : globalTheme.buttons)
                                radius: height / 2
                                Image
                                {
                                    source: playpause.icon.source
                                    sourceSize.width: playpause.width
                                    sourceSize.height: playpause.height
                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit
                                }
                                Behavior on color
                                {
                                    ColorAnimation
                                    {
                                        duration: 120
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }
                            Behavior on scale
                            {
                                NumberAnimation
                                {
                                    duration: 200
                                    easing.type: Easing.OutBack // Adds a little "bounce" effect
                                }
                            }

                            onReleased:
                            {
                                f.playPause()
                            }

                        }
                        AbstractButton
                        {
                            id: skipRight
                            Layout.preferredHeight: 30
                             Layout.preferredWidth: 40
                            scale: skipRight.down ? 0.8 : (skipRight.hovered ? 1.0 : 0.9)
                            hoverEnabled: enabled
                            opacity: !enabled ? 0.5 : 1.0
                            icon.source: `../../iconTemplates/${globalTheme.iconFolder}/SkipIcon`
                            enabled: f.updatePermission
                            background: Rectangle
                            {
                                anchors.fill: parent
                                color:skipRight.down ? Qt.lighter(globalTheme.buttons, 0.5) : (skipRight.hovered ? Qt.lighter(globalTheme.buttons, 1.5) : globalTheme.buttons)
                                radius: height / 2
                                Behavior on color
                                {
                                    ColorAnimation
                                    {
                                        duration: 120
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                                Image
                                {
                                    // id: rightArrowIcon
                                    source: skipRight.icon.source
                                    sourceSize.width: 30
                                    sourceSize.height: 30
                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit
                                }
                            }
                            onReleased:
                            {
                                if (currentSongIndex < listSongs.count - 1)
                                {
                                    currentSongIndex +=1
                                    f.loadSongs(listSongs.model[currentSongIndex], currentSongIndex)
                                }
                            }
                            Behavior on scale
                            {
                                NumberAnimation
                                {
                                    duration: 200
                                    easing.type: Easing.OutBack // Adds a little "bounce" effect
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
            Layout.preferredHeight: 60
            color: globalTheme.backgroundRectangleMain
            border.width: 3
            border.color: globalTheme.borderColor
            radius: 8
            clip: true
            ColumnLayout
            {
                anchors.margins: 15
                anchors.fill: parent
                // ListView
                // {
                //     id:songListView
                //     Layout.fillWidth: true
                //     Layout.fillHeight: true
                //     clip: true
                //     model: f.musicList
                //     highlightRangeMode: ListView.NoHighlightRange


                //     spacing: 5

                //     // highlightRangeMode: ListView.NoHighlightRange
                //     // snapMode: ListView.NoSnap
                //     boundsBehavior: Flickable.StopAtBounds
                //     interactive: false
                //     highlightMoveDuration: 180


                //     delegate: AbstractButton
                //     {
                //         id: song
                //         width: ListView.view.width
                //         scale: song.down ? 0.8 : (song.hovered ? 1.0 : 0.98)
                //         hoverEnabled: true
                //         height: 50
                //         Text
                //         {
                //             font.family: globalTheme.font
                //             // text: modelData.audio
                //             text: modelData
                //             color: "white"
                //             anchors.centerIn: parent
                //         }
                //         background: Rectangle
                //         {

                //             color: song.down ? Qt.lighter(globalTheme.rectangleInfoColor, 0.5) : (song.hovered ? Qt.lighter(globalTheme.rectangleInfoColor, 1.5) : globalTheme.rectangleInfoColor)
                //             radius: 8
                //             Behavior on color { ColorAnimation { duration: 100 } }
                //         }
                //         onReleased:
                //         {
                //             f.loadSongs(modelData, index)
                //             songListView.currentIndex = index
                //         }
                //         Behavior on scale
                //         {
                //             NumberAnimation
                //             {
                //                 duration: 200
                //                 easing.type: Easing.OutBack // Adds a little "bounce" effect
                //             }
                //         }
                //     }
                //     WheelHandler {
                //         onWheel: (wheel) => {
                //             // Height of one item (50) + spacing (5) = 55px per scroll step
                //             let step = 55

                //             if (wheel.angleDelta.y < 0) {
                //                 // Scroll Down
                //                 songListView.contentY = Math.min(
                //                     songListView.contentHeight - songListView.height,
                //                     songListView.contentY + step
                //                 )
                //             } else if (wheel.angleDelta.y > 0) {
                //                 // Scroll Up
                //                 songListView.contentY = Math.max(0, songListView.contentY - step)
                //             }
                //         }
                //     }
                // }

                AbstractButton
                {
                    id: songListOpen
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.preferredHeight:30
                    scale: songListOpen.down ? 0.8 : (songListOpen.hovered ? 1.0 : 0.98)
                    Layout.fillWidth: true
                    background: Rectangle
                    {
                        color: songListOpen.hovered ? Qt.lighter(globalTheme.buttons, 1.4)
                                             : globalTheme.buttons
                        radius: 6
                        Behavior on color { ColorAnimation { duration: 100 } }
                    }
                    contentItem: Text
                    {
                        text: "MP3 List"
                        color: globalTheme.infoFont
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: globalTheme.font
                    }

                    onClicked:
                    {

                        audioListPopup.open()
                    }
                    Behavior on scale
                    {
                        NumberAnimation
                        {
                            duration: 200
                            easing.type: Easing.OutBack // Adds a little "bounce" effect
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
                anchors.margins: 8

                Rectangle
                {
                    Layout.preferredHeight: 60
                    Layout.fillWidth: true
                    color: globalTheme.buttons
                    radius: 8
                    RowLayout
                    {
                        anchors.fill: parent
                        anchors.margins: 6

                        AbstractButton
                        {
                            id: pageLeftButton
                            Layout.preferredWidth: 50
                            Layout.preferredHeight: 50
                            scale: pageLeftButton.down ? 0.8 : (pageLeftButton.hovered ? 1.0 : 0.9)

                            icon.source: `../../iconTemplates/${globalTheme.iconFolder}/ArrowIcon`

                            background: Rectangle
                            {
                                radius: width / 2
                                color:pageLeftButton.down ? Qt.lighter(globalTheme.buttons, 0.5) : (pageLeftButton.hovered ? Qt.lighter(globalTheme.buttons, 1.5) : globalTheme.buttons)
                                Behavior on color { ColorAnimation { duration: 120 } }
                                Image
                                {
                                    source: pageLeftButton.icon.source
                                    sourceSize.width: pageLeftButton.width
                                    sourceSize.height: pageLeftButton.height
                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit
                                    rotation: 180

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
                                    duration: 200
                                    easing.type: Easing.OutBack // Adds a little "bounce" effect
                                }
                            }
                        }

                        AbstractButton
                        {
                            id: pageRightButton
                            Layout.preferredWidth: 50
                            Layout.preferredHeight: 50
                            scale: pageRightButton.down ? 0.8 : (pageRightButton.hovered ? 1.0 : 0.9)
                            icon.source: `../../iconTemplates/${globalTheme.iconFolder}/ArrowIcon`
                            Layout.alignment: Qt.AlignLeft

                            background: Rectangle
                            {
                                radius: width / 2

                                color:pageRightButton.down ? Qt.lighter(globalTheme.buttons, 0.5) : (pageRightButton.hovered ? Qt.lighter(globalTheme.buttons, 1.5) : globalTheme.buttons)
                                Image
                                {
                                    source: pageRightButton.icon.source
                                    sourceSize.width: pageRightButton.width
                                    sourceSize.height: pageRightButton.height
                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit
                                }
                                Behavior on color { ColorAnimation { duration: 120 } }
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
                                    duration: 200
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
                            scale: settingsOpen.down ? 0.8 : (settingsOpen.hovered ? 1.0 : 0.9)
                            Layout.alignment: Qt.AlignLeft
                            icon.source: `../../iconTemplates/${globalTheme.iconFolder}/GearIcon`
                            background:Rectangle
                            {
                                radius: width / 2
                                color:settingsOpen.down ? Qt.lighter(globalTheme.buttons, 0.5) : (settingsOpen.hovered ? Qt.lighter(globalTheme.buttons, 1.5) : globalTheme.buttons)
                                Behavior on color { ColorAnimation { duration: 120 } }
                                Image
                                {
                                    // id: rightArrowIcon
                                    source: settingsOpen.icon.source
                                    sourceSize.width: settingsOpen.width
                                    sourceSize.height: settingsOpen.height
                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit
                                }
                            }
                            onClicked:
                            {
                                settingsLoader.source = "Settings.qml";
                            }
                            Behavior on scale
                            {
                                NumberAnimation
                                {
                                    duration: 200
                                    easing.type: Easing.OutBack // Adds a little "bounce" effect
                                }
                            }

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
            Layout.alignment:  Qt.AlignRight
            Layout.preferredWidth: 35
            Layout.preferredHeight: 35
            scale: creatorButton.down ? 0.8 : (creatorButton.hovered ? 1.0 : 0.9)
            icon.source: `../../iconTemplates/${globalTheme.iconFolder}/AddIcon`
            background: Rectangle
            {
                radius: width / 2
                color:creatorButton.down ? Qt.lighter(globalTheme.buttons, 0.5) : (creatorButton.hovered ? Qt.lighter(globalTheme.buttons, 1.5) : globalTheme.buttons)
                Behavior on color { ColorAnimation { duration: 120 } }
                Image
                {
                    // id: rightArrowIcon
                    source: creatorButton.icon.source
                    sourceSize.width: creatorButton.width
                    sourceSize.height: creatorButton.height
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
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
                    duration: 200
                    easing.type: Easing.OutBack // Adds a little "bounce" effect
                }
            }
        }
    }
    Popup {
        id: audioListPopup
        width: rightAreaRectangle.width
        height: rightAreaRectangle.height
        anchors.centerIn: parent
        parent: Overlay.overlay

        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        // Dim the background behind the popup
        Overlay.modal: Rectangle
        {
            color: "#AA000000"
        }

        // Smooth fade in/out transition
        enter: Transition {
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200 }
        }
        exit: Transition {
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 150 }
        }

        background: Rectangle
        {
            color: globalTheme.backgroundRectangleMain
            border.color: globalTheme.borderColor
            border.width: 2
            radius: 12
        }

        contentItem: ColumnLayout
        {
            spacing: 10

            Text
            {
                text: "All Tracks"
                color: "white"
                font.family: globalTheme.font
                font.pixelSize: 18
                Layout.alignment: Qt.AlignHCenter
            }

            // Scrollable view containing all audio tracks
            ScrollView
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                Grid
                {
                    columns: 1
                    spacing: 8
                    anchors.centerIn: parent
                    Repeater
                    {
                        id: listSongs
                        model: f.musicList

                        delegate: AbstractButton
                        {
                            width: rightAreaRectangle.width - 25
                            height: 50

                            contentItem: Text
                            {
                                text: modelData
                                color: globalTheme.infoFont
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                font.family: globalTheme.font
                            }

                            background: Rectangle
                            {
                                color: parent.hovered ? Qt.lighter(globalTheme.rectangleInfoColor, 1.4)
                                                     : globalTheme.rectangleInfoColor
                                radius: 6
                            }

                            onReleased:
                            {
                                currentFile.text = modelData
                                currentSongIndex =index
                                f.loadSongs(modelData, index)
                                audioListPopup.close()
                            }
                        }
                    }
                }
            }
        }
    }

}

