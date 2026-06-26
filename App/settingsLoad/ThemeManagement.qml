import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Dialogs

Rectangle
{
    anchors.fill: parent
    color: "grey"

    property string currentSelectButton: "No Selection"
    ColumnLayout
    {
        anchors.fill: parent

        RowLayout
        {
            Layout.fillHeight: true
            anchors.margins: 2

            ColumnLayout
            {
                Layout.fillHeight: true
                Layout.fillWidth: true

                spacing: 20 // Space between the different categories

                Repeater
                {

                    model: [
                        { tag: "Layout Backgrounds", items: ["Main Background", "Border Color", "Info Rectangle"] },
                        { tag: "Application Components", items: ["Buttons", "Clock"] },
                        { tag: "Media Controls", items: ["MP3 Slider", "MP3 Slider Background"] }
                    ]

                    delegate: Column
                    {
                        spacing: 0
                        Layout.fillWidth: true


                        Text
                        {
                            text: modelData.tag
                            color: "#aaaaaa"
                            font.pixelSize: 14
                            font.weight: Font.DemiBold
                        }


                        Rectangle {
                            width:560
                            height:50
                            color: "transparent"

                            Grid
                            {
                                // anchors.verticalCenter: parent.verticalCenter
                                columns: 4 // Allows up to 4 buttons per row



                                Repeater
                                {
                                    model: modelData.items

                                    delegate: AbstractButton
                                    {
                                        id: controlColor
                                        width: 140
                                        height: 32

                                        background: Rectangle
                                        {
                                            color: "black"
                                            radius: 4
                                            border.color: "white"
                                            border.width: 2
                                            opacity: controlColor.down ? 0.9 : 0.7
                                        }

                                        onClicked:
                                        {
                                            currentSelectButton = colorButtonSelection.text
                                            f.receiveSettingsColorSelection(colorButtonSelection.text)
                                        }

                                        contentItem: Text
                                        {
                                            id: colorButtonSelection
                                            text: modelData
                                            color: "white"
                                            font.pixelSize: 11
                                            font.weight: Font.Medium
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
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
                Layout.preferredWidth: 5
                Layout.preferredHeight: 250
                color: "white"
                Layout.alignment: Qt.AlignTop
            }
            ColumnLayout
            {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Rectangle
                {
                    Layout.preferredHeight: 55
                    Layout.fillWidth: parent
                    color: "white"
                    border.color: "black"
                    border.width:2
                    Text
                    {
                        text: currentSelectButton
                        anchors.centerIn: parent
                        color: "black"
                        font.pixelSize: 16
                    }
                }

                RowLayout
                {
                    id: colorSelectionRow
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    property var dynamicTonesList: ["#ff3333", "#ff6666", "#ff9999"] // Default fallback values

                            // Data dictionary mapping base colors to actual tones
                    property var toneDatabase:
                    {
                        "Red":    ["#4a0000", "#cc0000", "#ff4d4d", "#ff9999"],
                        "Blue":   ["#00004a", "#0000cc", "#4d4dff", "#9999ff"],
                        "Green":  ["#003300", "#00aa00", "#33ff33", "#99ff99"],
                        "Orange": ["#cc6600", "#ff8000", "#ffaa55", "#ffd2a6"],
                        "Purple": ["#4b0082", "#800080", "#da70d6", "#ee82ee"],
                        "Pink":   ["#ff1493", "#ff69b4", "#ffb6c1", "#fff0f5"],
                        "Yellow": ["#8b8000", "#ffff00", "#ffffa0", "#ffffe0"],
                        "Brown":  ["#5c4033", "#8b5a2b", "#cd853f", "#d2b48c"],
                        "Cyan":   ["#008b8b", "#00ffff", "#e0ffff", "#f0ffff"],
                        "Black":  ["#000000", "#1a1a1a", "#333333", "#4d4d4d"],
                        "White":  ["#ffffff", "#f0f0f0", "#e0e0e0", "#d3d3d3"],
                        "Gray":   ["#808080", "#a9a9a9", "#d3d3d3", "#f5f5f5"],
                        "Magenta":["#8b008b", "#ff00ff", "#ff77ff", "#ffbbfb"]
                    }

                    ScrollView
                    {
                        Layout.preferredWidth: 130
                        Layout.preferredHeight: 180
                        clip: true

                        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                        ScrollBar.vertical.implicitWidth: 6

                        Grid
                        {
                            columns: 1
                            Layout.preferredHeight: parent.height
                            spacing: 0
                            Repeater
                            {
                                model: ["Red", "Blue", "Green", "Orange", "Purple", "Pink", "Yellow", "Brown",
                                        "Cyan", "Black", "White", "Gray", "Magenta"]
                                delegate: AbstractButton
                                {
                                    id: colorButton
                                    width: 100
                                    height: 30
                                    background: Rectangle
                                    {
                                        color: modelData
                                        radius: 2
                                        border.color: "black"
                                        border.width: 2
                                    }

                                    onClicked:
                                    {


                                        var updates = colorSelectionRow.toneDatabase[modelData]
                                        colorSelectionRow.dynamicTonesList = updates


                                    }

                                }
                            }
                        }

                    }
                    ScrollView
                    {
                        Layout.preferredWidth: 90
                        Layout.preferredHeight: 150
                        clip: true

                        ScrollBar.vertical.policy: ScrollBar.AsNeeded
                        ScrollBar.vertical.implicitWidth: 6

                        Grid
                        {

                            columns: 1
                            Layout.preferredHeight: parent.height
                            spacing: 0
                            Repeater
                            {
                                model: colorSelectionRow.dynamicTonesList
                                delegate: AbstractButton
                                {

                                    width: 80
                                    height: 30
                                    background: Rectangle
                                    {
                                        color: modelData

                                        border.color: "black"
                                        border.width: 3
                                    }

                                    onClicked:
                                    {
                                        f.receiveOptionColor(currentSelectButton, modelData)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        ColumnLayout
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Rectangle
            {
                Layout.fillWidth: true
                Layout.preferredHeight: 5
            }

            Rectangle
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "green"
                RowLayout
                {
                    anchors.fill: parent
                    Rectangle
                    {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: globalTheme.backgroundRectangleMain
                        radius: 5
                        border.width: 3
                        border.color: globalTheme.borderColor
                            // anchors.margins: 2

                        ColumnLayout
                        {
                            anchors.fill: parent
                            Rectangle
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 70
                                color: globalTheme.rectangleInfoColor
                                border.color: globalTheme.borderColor
                                border.width: 3
                                radius: 5
                            }
                            Rectangle
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 70
                                color: globalTheme.rectangleInfoColor
                                border.color: globalTheme.borderColor
                                border.width: 3
                                radius: 5
                            }
                            Rectangle
                            {
                                Layout.preferredWidth: 40
                                Layout.preferredHeight: 40
                                color: globalTheme.buttons
                                border.color: globalTheme.borderColor
                                border.width: 3
                                radius: width / 2
                                Layout.alignment: Qt.AlignHCenter
                            }
                            Item
                            {
                                Layout.fillHeight: true
                            }

                        }
                    }
                    Rectangle
                    {
                        Layout.fillHeight: true
                        Layout.preferredWidth: parent.width / 3
                        color: "transparent"
                        ColumnLayout
                        {
                            anchors.fill: parent
                            Text
                            {
                                text:"Class Title"
                                color: "white"
                                font.pixelSize: 18
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Rectangle
                            {
                                Layout.preferredHeight: 140
                                Layout.fillWidth: true
                                color: globalTheme.backgroundRectangleMain
                                border.width: 3
                                border.color: globalTheme.borderColor
                                radius: 6
                                ColumnLayout
                                {
                                    anchors.fill: parent


                                    Text
                                    {
                                        text: "Class Details"
                                        color: "white"
                                        font.pixelSize: 12
                                        Layout.leftMargin: 4

                                    }
                                    Rectangle
                                    {
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        Layout.rightMargin:6
                                        Layout.leftMargin: 12
                                        Layout.bottomMargin: 4
                                        radius: 8
                                        color: globalTheme.rectangleInfoColor

                                        border.width: 3
                                        border.color: globalTheme.borderColor
                                    }
                                }
                            }
                            Rectangle
                            {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                color: globalTheme.backgroundRectangleMain
                                border.width: 3
                                border.color: globalTheme.borderColor
                                radius: 6

                                ColumnLayout
                                {
                                    anchors.fill: parent
                                    Text
                                    {
                                        text: "To Do List"
                                        color: "white"
                                        font.pixelSize: 12
                                        Layout.leftMargin: 4

                                    }
                                    Rectangle
                                    {
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        Layout.rightMargin:6
                                        Layout.leftMargin: 12
                                        Layout.bottomMargin: 4

                                        color: "transparent"

                                        border.width: 3
                                        border.color: globalTheme.borderColor

                                        radius: 8

                                        ColumnLayout
                                        {
                                            anchors.fill: parent
                                            Rectangle
                                            {
                                                color: globalTheme.rectangleInfoColor
                                                border.width:2
                                                border.color: globalTheme.borderColor
                                                Layout.fillWidth: true
                                                Layout.preferredHeight: 20
                                                radius: 4
                                            }
                                            Rectangle
                                            {
                                                color: globalTheme.rectangleInfoColor
                                                border.width: 2
                                                border.color: globalTheme.borderColor
                                                Layout.fillWidth: true
                                                Layout.preferredHeight: 20
                                                radius: 4
                                            }
                                            Item
                                            {
                                                Layout.fillHeight: true
                                            }
                                        }
                                    }

                                }
                            }
                            Item
                            {
                                height: 15

                            }
                        }
                    }
                    Rectangle
                    {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color: "transparent"
                        ColumnLayout
                        {
                            anchors.fill: parent
                            spacing: 6
                            Rectangle
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 60
                                color: globalTheme.clockColor
                                border.color: globalTheme.borderColor
                                border.width: 3
                                radius: 8
                                Text
                                {
                                    text: "12:00:00 PM"
                                    anchors.centerIn: parent
                                    color: "white"
                                    font.pixelSize: 25
                                }
                            }
                            Rectangle
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 110
                                color: globalTheme.backgroundRectangleMain
                                radius: 8
                                border.color: globalTheme.borderColor
                                border.width: 3
                                ColumnLayout
                                {
                                    anchors.fill: parent
                                    anchors.margins: 6
                                    Rectangle
                                    {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 30
                                        color: "black"
                                    }
                                    Rectangle
                                    {
                                        Layout.preferredHeight: 15
                                        Layout.preferredWidth: 35
                                        Layout.alignment: Qt.AlignHCenter
                                        radius: 8
                                    }
                                    Rectangle
                                    {
                                        id: line
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 5
                                        color: "white"
                                        Rectangle
                                        {
                                            height: line.height
                                            width: (line.width * 0.25)
                                            color: globalTheme.sliderBackground
                                        }
                                        Rectangle
                                        {
                                            height: 12
                                            width: 12
                                            radius: width / 2
                                            x: (line.width * 0.25) - (width / 2)
                                            anchors.verticalCenter: parent.verticalCenter
                                            color: globalTheme.mp3Slider
                                        }

                                    }
                                    RowLayout
                                    {
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        Layout.alignment: Qt.AlignHCenter
                                        Rectangle
                                        {
                                            Layout.preferredHeight: 15
                                            Layout.preferredWidth: 30
                                            radius: width / 2
                                            color: globalTheme.buttons
                                        }
                                        Rectangle
                                        {
                                            Layout.preferredHeight: 25
                                            Layout.preferredWidth: 25
                                            radius: width / 2
                                            color: globalTheme.buttons
                                        }
                                        Rectangle
                                        {
                                            Layout.preferredHeight: 15
                                            Layout.preferredWidth: 30
                                            radius: width / 2
                                            color: globalTheme.buttons
                                        }
                                    }
                                }
                            }
                            Rectangle
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 80
                                color: globalTheme.backgroundRectangleMain
                                border.color: globalTheme.borderColor
                                border.width: 3
                                radius: 8
                                ColumnLayout
                                {
                                    anchors.fill: parent
                                    anchors.margins: 6
                                    RowLayout
                                    {
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        Rectangle
                                        {
                                            Layout.preferredHeight: 35
                                            Layout.preferredWidth: 35
                                            radius: width / 2
                                            color: globalTheme.buttons
                                            border.color: globalTheme.borderColor
                                            border.width: 3
                                        }
                                        Rectangle
                                        {
                                            Layout.preferredHeight: 35
                                            Layout.preferredWidth: 35
                                            radius: width / 2
                                            color: globalTheme.buttons
                                            border.color: globalTheme.borderColor
                                            border.width: 3
                                        }
                                        Item
                                        {
                                            Layout.fillWidth: true
                                        }
                                        Rectangle
                                        {
                                            Layout.preferredHeight: 35
                                            Layout.preferredWidth: 35
                                            radius: width / 4
                                            color: globalTheme.buttons
                                            border.color: globalTheme.borderColor
                                            border.width: 3
                                        }
                                    }
                                    Rectangle
                                    {
                                        Layout.preferredHeight: 25
                                        Layout.fillWidth: true
                                        radius: 8
                                        color: "black"
                                        border.color: globalTheme.borderColor
                                        border.width: 3
                                    }
                                }
                            }
                            Item
                            {
                                Layout.fillHeight: true
                            }
                        }
                    }
                }
            }
        }
    }
}
