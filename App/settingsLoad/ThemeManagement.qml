import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import Qt.labs.folderlistmodel

Rectangle
{
    anchors.fill: parent
    color: "grey"
    anchors.margins: 2
    radius: 2


    property string currentSelectButton: "No Selection"
    ColumnLayout
    {
        anchors.fill: parent
        anchors.margins: 1
        // Rectangle
        // {
        //     Layout.fillWidth: true
        //     Layout.preferredHeight: 270
        // }
        RowLayout
        {
            Layout.fillWidth: true
            Layout.preferredHeight: 275
            StackLayout
            {
                id: edittingOptions
                Layout.fillWidth: true
                Layout.preferredHeight: 275
                Layout.fillHeight: false


                // 0 is the first item, 1 is the second, etc.
                currentIndex: 0

                Rectangle
                {
                    color: "black"
                    radius: 8
                    border.color: "white"
                    border.width: 2


                    ColumnLayout
                    {
                        anchors.fill: parent
                        anchors.margins: 2

                        Grid
                        {
                            columns: 5

                            Layout.alignment: Qt.AlignHCenter
                            Repeater
                            {
                                model: ["General Background", "Main Background", "Border Color", "Rectangle Info",
                                        "Buttons", "Clock", "MP3 Colors", "Title Font", "Info Font"]

                                delegate: AbstractButton
                                {
                                    id: controlColor
                                    width: 125
                                    height: 32
                                    scale: controlColor.down ? 0.9 : (controlColor.hovered ? 1.08 : 1.0)
                                    opacity: controlColor.down ? 0.5 : (controlColor.hovered ? 1.1 : 1.0)

                                    background: Rectangle
                                    {
                                        id: componentSelection

                                        color: "black"
                                        radius: 4
                                        border.color: (currentSelectButton === modelData) ? "cyan" : "white" //Each button checks everytime for who is the current selected button
                                        border.width: 2
                                        opacity: controlColor.down ? 0.7 : 0.9
                                    }

                                    onClicked:
                                    {

                                        currentSelectButton = colorButtonSelection.text


                                        //f.receiveSettingsColorSelection(colorButtonSelection.text)
                                    }

                                    contentItem: Text
                                    {
                                        font.family: globalTheme.font
                                        id: colorButtonSelection
                                        text: modelData
                                        color: (currentSelectButton === modelData) ? "cyan" : "white"
                                        font.pixelSize: 12
                                        font.weight: Font.Medium
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    Behavior on scale
                                    {
                                        NumberAnimation
                                        {
                                            duration: 200
                                            easing.type: Easing.OutBack // Adds a little "bounce" effect
                                        }
                                    }
                                    Behavior on opacity
                                    {
                                        NumberAnimation
                                        {
                                            duration: 80              // Duration in milliseconds
                                            easing.type: Easing.InOutQuad // Smooth acceleration/deceleration
                                        }
                                    }
                                }
                            }
                        }
                        Grid
                        {
                            columns: 6
                            spacing: 1
                            Layout.alignment: Qt.AlignHCenter
                            Repeater
                            {
                                id: generalColor
                                model:["red", "orange", "gold", "green",
                                       "cyan", "skyblue", "blue", "indigo", "magenta", "deeppink", "saddlebrown", "gray"]

                                delegate: Rectangle
                                {
                                    id: colorPicker
                                    width:97
                                    height: 97
                                    color: "white"
                                    radius: 4

                                    property string outerColor: modelData

                                    Grid
                                    {
                                        columns: 5
                                        spacing: 0
                                        Repeater
                                        {
                                            model: 25


                                            delegate: AbstractButton
                                            {
                                                id: colorSquare
                                                width: 19.4
                                                height: 19.4
                                                hoverEnabled: true
                                                scale: colorSquare.down ? 0.8 : (colorSquare.hovered ? 1.2 : 1.0)
                                                // opacity: colorSquare.down ? 0.5 : (colorSquare.hovered ? 1.1 : 1.0)



                                                background: Rectangle
                                                {
                                                    id: rectangleColor
                                                    color: colorSquare.down ? Qt.lighter(Qt.hsla(Qt.color(outerColor).hslHue, 1.0, 1.0 - (index/24), 1.0), 0.8) : Qt.hsla(Qt.color(outerColor).hslHue, 1.0, 1.0 - (index/24), 1.0)
                                                    border.color: "white"
                                                }

                                                onClicked:
                                                {
                                                    f.receiveOptionColor(currentSelectButton, rectangleColor.color)
                                                }
                                                Behavior on scale
                                                {
                                                    NumberAnimation
                                                    {
                                                        duration: 200
                                                        easing.type: Easing.OutBack // Adds a little "bounce" effect
                                                    }
                                                }
                                                Behavior on opacity
                                                {
                                                    NumberAnimation
                                                    {
                                                        duration: 80              // Duration in milliseconds
                                                        easing.type: Easing.InOutQuad // Smooth acceleration/deceleration
                                                    }
                                                }


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
                    color: "black"
                    radius: 8
                    border.width: 2
                    border.color: "white"
                    ColumnLayout
                    {
                        anchors.fill: parent

                        anchors.margins: 2

                        Rectangle
                        {
                            color: "black"
                            border.color: "white"
                            border.width: 2
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 100
                            Layout.alignment: Qt.AlignHCenter
                            Text
                            {
                                text: "Fonts"
                                color: "white"
                                font.family: globalTheme.font
                                font.pixelSize: 24
                                anchors.centerIn: parent
                            }
                        }
                        Grid
                        {
                            columns: 2
                            spacing: 4
                            columnSpacing: 20
                            Layout.alignment: Qt.AlignHCenter

                            Repeater
                            {

                                model: FolderListModel
                                {


                                    //Resolves the absolute path of the file
                                    folder: Qt.resolvedUrl("../Fonts")

                                    // Filter to only look for specific file types (e.g., text files)
                                    nameFilters: ["*.ttf"]

                                    // Tell it to ignore folders and only show files
                                    showDirs: false
                                    showFiles: true
                                }


                                delegate: AbstractButton
                                {
                                    id: fontList
                                    width: 255
                                    height: 30

                                    scale: fontList.down ? 0.98 : (fontList.hovered ? 1.1 : 1.0)
                                    opacity: fontList.down ? 0.5 : (fontList.hovered ? 1.1 : 1.0)
                                    background: Rectangle
                                    {
                                        radius: 8
                                        color: "transparent"
                                        border.color: (allFonts.name === globalTheme.font) ? "cyan" : "white"
                                    }
                                    FontLoader
                                    {
                                        id:allFonts
                                        source: `../Fonts/${fileName}`
                                    }
                                    Text
                                    {
                                        text: "This is a font, so try it!"
                                        color: (allFonts.name === globalTheme.font) ? "cyan" : "white"
                                        font.pixelSize: 18
                                        font.family: allFonts.name
                                        anchors.centerIn: parent
                                    }
                                    onClicked:
                                    {
                                        globalTheme.font = allFonts.name
                                    }
                                    Behavior on scale
                                    {
                                        NumberAnimation
                                        {
                                            duration: 200
                                            easing.type: Easing.OutBack // Adds a little "bounce" effect
                                        }
                                    }
                                    Behavior on opacity
                                    {
                                        NumberAnimation
                                        {
                                            duration: 80              // Duration in milliseconds
                                            easing.type: Easing.InOutQuad // Smooth acceleration/deceleration
                                        }
                                    }

                                }
                            }
                        }
                    }


                }
                Rectangle
                {
                    color: "black"
                    border.color: "white"
                    border.width: 2
                    ColumnLayout
                    {
                        anchors.fill: parent
                        anchors.margins: 1

                        Rectangle
                        {
                            color: "black"
                            border.color: "white"
                            border.width: 2
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 100
                            Layout.alignment: Qt.AlignHCenter
                            Text
                            {
                                text: "Icons"
                                color: "white"
                                font.family: globalTheme.font
                                font.pixelSize: 24
                                anchors.centerIn: parent
                            }
                        }
                        Grid
                        {
                            columns: 2
                            spacing: 4
                            columnSpacing: 18
                            Layout.alignment: Qt.AlignHCenter

                            Repeater
                            {

                                model: FolderListModel
                                {


                                    //Resolves the absolute path of the file
                                    folder: Qt.resolvedUrl("../iconTemplates")

                                    // Filter to only look for specific file types (e.g., text files)
                                    // nameFilters: ["*.ttf"]

                                    // Tell it to ignore folders and only show files
                                    showDirs: true
                                    showFiles: false
                                }


                                delegate: AbstractButton
                                {
                                    id: iconList
                                    width: 280
                                    height: 60
                                    scale: iconList.down ? 0.98 : (iconList.hovered ? 1.1 : 1.0)
                                    opacity: iconList.down ? 0.5 : (iconList.hovered ? 1.1 : 1.0)
                                    background: Rectangle
                                    {
                                        color: "gray"
                                        border.color: (fileName === globalTheme.iconFolder) ? "cyan" : "white"
                                        border.width: 2
                                        radius: 4
                                    }
                                    Behavior on scale
                                    {
                                        NumberAnimation
                                        {
                                            duration: 200
                                            easing.type: Easing.OutBack // Adds a little "bounce" effect
                                        }
                                    }
                                    Behavior on opacity
                                    {
                                        NumberAnimation
                                        {
                                            duration: 80              // Duration in milliseconds
                                            easing.type: Easing.InOutQuad // Smooth acceleration/deceleration
                                        }
                                    }

                                    onClicked:
                                    {
                                        globalTheme.iconFolder = fileName
                                    }
                                    Grid
                                    {
                                        columns: 6
                                        anchors.centerIn: parent

                                        Repeater
                                        {
                                            model: ["AddIcon", "ArrowIcon", "PauseIcon", "PlayIcon", "SkipIcon", "GearIcon"]
                                            delegate:Image
                                            {
                                                source: `../iconTemplates/${fileName}/${modelData}`
                                                sourceSize.width: 45
                                                sourceSize.height: 45
                                                fillMode: Image.PreserveAspectFit
                                            }
                                        }

                                    }

                                }
                            }
                        }
                    }
                }
            }
            Rectangle
            {//Put the code inside this rectangle
                Layout.preferredHeight: 175
                Layout.preferredWidth: 160
                border.color: "white"
                border.width: 2
                radius: 8
                color: "black"

                clip: true
                ColumnLayout
                {
                    anchors.fill: parent

                    AbstractButton
                    {
                        id: colorSelect
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 50
                        scale: colorSelect.down ? 0.88 : (colorSelect.hovered ? 1.0 : 0.9)
                        opacity: colorSelect.down ? 0.5 : (colorSelect.hovered ? 1.1 : 1.0)
                        background: Rectangle
                        {
                            color: "darkblue"
                            border.color: "white"
                            border.width: 2
                            radius: 8
                            Text
                            {
                                text: "Color Theme"
                                anchors.centerIn: parent
                                color: "white"
                                font.family: globalTheme.font
                                font.pixelSize: 24

                            }
                        }
                        onClicked:
                        {
                            edittingOptions.currentIndex = 0
                        }
                        Behavior on scale
                        {
                            NumberAnimation
                            {
                                duration: 200
                                easing.type: Easing.OutBack // Adds a little "bounce" effect
                            }
                        }
                        Behavior on opacity
                        {
                            NumberAnimation
                            {
                                duration: 80              // Duration in milliseconds
                                easing.type: Easing.InOutQuad // Smooth acceleration/deceleration
                            }
                        }

                    }
                    AbstractButton
                    {
                        id: fontSelect
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 50
                        scale: fontSelect.down ? 0.88 : (fontSelect.hovered ? 1.0 : 0.9)
                        opacity: fontSelect.down ? 0.5 : (fontSelect.hovered ? 1.1 : 1.0)
                        background: Rectangle
                        {
                            color: "darkblue"
                            border.color: "white"
                            border.width: 2
                            radius: 8
                            Text
                            {
                                text: "Fonts"
                                anchors.centerIn: parent
                                color: "white"
                                font.family: globalTheme.font
                                font.pixelSize: 24

                            }
                        }
                        onClicked:
                        {
                            edittingOptions.currentIndex = 1
                        }
                        Behavior on scale
                        {
                            NumberAnimation
                            {
                                duration: 200
                                easing.type: Easing.OutBack // Adds a little "bounce" effect
                            }
                        }
                        Behavior on opacity
                        {
                            NumberAnimation
                            {
                                duration: 80              // Duration in milliseconds
                                easing.type: Easing.InOutQuad // Smooth acceleration/deceleration
                            }
                        }


                    }
                    AbstractButton
                    {
                        id: iconSelect
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 50
                        scale: iconSelect.down ? 0.88 : (iconSelect.hovered ? 1.0 : 0.9)
                        opacity: iconSelect.down ? 0.5 : (iconSelect.hovered ? 1.1 : 1.0)
                        background: Rectangle
                        {
                            color: "darkblue"
                            border.color: "white"
                            border.width: 2
                            radius: 8
                            Text
                            {
                                text: "Icons"
                                anchors.centerIn: parent
                                color: "white"
                                font.family: globalTheme.font
                                font.pixelSize: 24

                            }
                        }
                        onClicked:
                        {
                            edittingOptions.currentIndex = 2
                        }
                        Behavior on scale
                        {
                            NumberAnimation
                            {
                                duration: 200
                                easing.type: Easing.OutBack // Adds a little "bounce" effect
                            }
                        }
                        Behavior on opacity
                        {
                            NumberAnimation
                            {
                                duration: 80              // Duration in milliseconds
                                easing.type: Easing.InOutQuad // Smooth acceleration/deceleration
                            }
                        }


                    }
                }



                // Item
                // {
                //     Layout.fillHeight: true
                // }
            }


        }



        // anchors.margins: 4
        // ScrollView
        // {
        //     Layout.fillWidth: true

        //     Layout.preferredHeight: 280

        //     id: categoryScrollView

        //     clip: true              // Crucial! Prevents buttons from drawing outside the scroll area

        //     // Optional: Customize scrollbar appearance
        //     ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        //     ScrollBar.vertical.implicitWidth: 6
        //     RowLayout
        //     {
        //         Layout.fillHeight: true
        //         Layout.fillWidth: true



        //         ColumnLayout
        //         {
        //             width: parent.width

        //             spacing: 20 // Space between the different categories

        //             Repeater
        //             {

        //                 model: [
        //                     { tag: "Layout Backgrounds", items: ["Main Background", "Border Color", "Info Rectangle"] },
        //                     { tag: "Application Components", items: ["Buttons", "Clock"] },
        //                     { tag: "Media Controls", items: ["MP3 Slider", "MP3 Slider Background"] }
        //                 ]

        //                 delegate: ColumnLayout
        //                 {
        //                     spacing: 0
        //                     Layout.fillWidth: true

        //                     Text
        //                     {
        //                         font.family: globalTheme.font
        //                         text: modelData.tag
        //                         color: "#aaaaaa"
        //                         font.pixelSize: 14
        //                         font.weight: Font.DemiBold
        //                     }


        //                     Rectangle
        //                     {
        //                         Layout.preferredWidth: 375
        //                         Layout.preferredHeight: 40

        //                         color: "transparent"

        //                         Grid
        //                         {
        //                             // anchors.verticalCenter: parent.verticalCenter
        //                             columns: 3 // Allows up to 4 buttons per row



        //                             Repeater
        //                             {
        //                                 model: modelData.items

        //                                 delegate: AbstractButton
        //                                 {
        //                                     id: controlColor
        //                                     width: 125
        //                                     height: 32

        //                                     background: Rectangle
        //                                     {
        //                                         color: "black"
        //                                         radius: 4
        //                                         border.color: "white"
        //                                         border.width: 2
        //                                         opacity: controlColor.down ? 0.9 : 0.7
        //                                     }

        //                                     onClicked:
        //                                     {
        //                                         currentSelectButton = colorButtonSelection.text
        //                                         f.receiveSettingsColorSelection(colorButtonSelection.text)
        //                                     }

        //                                     contentItem: Text
        //                                     {
        //                                         font.family: globalTheme.font
        //                                         id: colorButtonSelection
        //                                         text: modelData
        //                                         color: "white"
        //                                         font.pixelSize: 11
        //                                         font.weight: Font.Medium
        //                                         horizontalAlignment: Text.AlignHCenter
        //                                         verticalAlignment: Text.AlignVCenter
        //                                     }
        //                                 }
        //                             }
        //                         }
        //                     }
        //                 }
        //             }
        //         }
        //         Rectangle
        //         {
        //             Layout.preferredWidth: 5
        //             Layout.preferredHeight: 250
        //             color: "white"
        //             Layout.alignment: Qt.AlignTop
        //         }
        //         ColumnLayout
        //         {
        //             Layout.fillWidth: true
        //             Layout.fillHeight: true
        //             Rectangle
        //             {
        //                 Layout.preferredHeight: 55
        //                 Layout.preferredWidth: 190

        //                 color: "white"
        //                 border.color: "black"
        //                 border.width: 2
        //                 Layout.alignment: Qt.AlignTop
        //             }

        //             ScrollView
        //             {
        //                 Layout.preferredWidth: 190
        //                 Layout.preferredHeight: 180
        //                 clip: true

        //                 ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        //                 ScrollBar.vertical.implicitWidth: 6

        //                 ColumnLayout
        //                 {
        //                     width: parent.width
        //                     spacing: 0
        //                     Repeater
        //                     {

        //                         model:["Cascade","Forest" ,"Modern","Simplistic"]

        //                         delegate:AbstractButton
        //                         {
        //                             property var currentFolder: modelData
        //                             width: 190
        //                             height: 60
        //                             background:Rectangle
        //                             {
        //                                 color: "white"
        //                                 radius: 2
        //                                 border.color: "black"
        //                                 border.width: 2
        //                             }
        //                             onClicked:
        //                             {
        //                                 globalTheme.iconFolder = currentFolder
        //                             }


        //                             RowLayout
        //                             {

        //                                 anchors.centerIn: parent
        //                                 Repeater
        //                                 {
        //                                     model: ["AddIcon.svg", "ArrowIcon.svg", "PauseIcon.svg"]
        //                                     delegate:AbstractButton
        //                                     {
        //                                         id: previewButton
        //                                         width: 50
        //                                         height: 50
        //                                         icon.source: `../iconTemplates/${currentFolder}/${modelData}`

        //                                         background: Rectangle
        //                                         {
        //                                             radius: width / 2
        //                                             color: "transparent"
        //                                             Image {
        //                                                 // id: rightArrowIcon
        //                                                 source: previewButton.icon.source
        //                                                 sourceSize.width: previewButton.width
        //                                                 sourceSize.height: previewButton.height
        //                                                 anchors.centerIn: parent
        //                                                 fillMode: Image.PreserveAspectFit
        //                                             }
        //                                             ColorOverlay
        //                                             {
        //                                                 anchors.fill: previewButton
        //                                                 source: previewButton

        //                                                 color: previewButton.down ? "green" : globalTheme.borderColor
        //                                             }
        //                                         }

        //                                         onClicked:
        //                                         {
        //                                             globalTheme.iconFolder = currentFolder
        //                                         }
        //                                     }
        //                                 }

        //                             }



        //                             // AbstractButton
        //                             // {
        //                             //     width: 50
        //                             //     height: 50
        //                             //     anchors.centerIn: parent
        //                             //     background: Rectangle
        //                             //     {
        //                             //         radius: width / 2
        //                             //         color: "blue"
        //                             //     }


        //                             //     onClicked:
        //                             //     {


        //                             //         var updates = colorSelectionRow.toneDatabase[modelData]
        //                             //         colorSelectionRow.dynamicTonesList = updates
        //                             //     }
        //                             // }
        //                         }
        //                     }
        //                 }

        //             }
        //         }


        //         Rectangle
        //         {
        //             Layout.preferredWidth: 5
        //             Layout.preferredHeight: 250
        //             color: "white"
        //             Layout.alignment: Qt.AlignTop
        //         }
        //         ColumnLayout
        //         {
        //             Layout.fillHeight: true
        //             Layout.fillWidth: true
        //             Rectangle
        //             {
        //                 Layout.preferredHeight: 55
        //                 Layout.preferredWidth: 180
        //                 color: "white"
        //                 border.color: "black"
        //                 border.width:2
        //                 Text
        //                 {
        //                     font.family: globalTheme.font
        //                     text: currentSelectButton
        //                     anchors.centerIn: parent
        //                     color: "black"
        //                     font.pixelSize: 16
        //                 }
        //             }

        //             RowLayout
        //             {
        //                 id: colorSelectionRow
        //                 Layout.alignment: Qt.AlignTop
        //                 Layout.fillWidth: true
        //                 Layout.fillHeight: true

        //                 property var dynamicTonesList: ["#ff3333", "#ff6666", "#ff9999"] // Default fallback values

        //                         // Data dictionary mapping base colors to actual tones
        //                 property var toneDatabase:
        //                 {
        //                     "Red":    ["#4a0000", "#cc0000", "#ff4d4d", "#ff9999"],
        //                     "Blue":   ["#00004a", "#0000cc", "#4d4dff", "#9999ff"],
        //                     "Green":  ["#003300", "#00aa00", "#33ff33", "#99ff99"],
        //                     "Orange": ["#cc6600", "#ff8000", "#ffaa55", "#ffd2a6"],
        //                     "Purple": ["#4b0082", "#800080", "#da70d6", "#ee82ee"],
        //                     "Pink":   ["#ff1493", "#ff69b4", "#ffb6c1", "#fff0f5"],
        //                     "Yellow": ["#8b8000", "#ffff00", "#ffffa0", "#ffffe0"],
        //                     "Brown":  ["#5c4033", "#8b5a2b", "#cd853f", "#d2b48c"],
        //                     "Cyan":   ["#008b8b", "#00ffff", "#e0ffff", "#f0ffff"],
        //                     "Black":  ["#000000", "#1a1a1a", "#333333", "#4d4d4d"],
        //                     "White":  ["#ffffff", "#f0f0f0", "#e0e0e0", "#d3d3d3"],
        //                     "Gray":   ["#808080", "#a9a9a9", "#d3d3d3", "#f5f5f5"],
        //                     "Magenta":["#8b008b", "#ff00ff", "#ff77ff", "#ffbbfb"]
        //                 }

        //                 ScrollView
        //                 {
        //                     Layout.preferredWidth: 100
        //                     Layout.preferredHeight: 180
        //                     clip: true

        //                     ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        //                     ScrollBar.vertical.implicitWidth: 6

        //                     Grid
        //                     {
        //                         columns: 1
        //                         // Layout.preferredHeight: parent.height
        //                         spacing: 0
        //                         Repeater
        //                         {
        //                             model: ["Red", "Blue", "Green", "Orange", "Purple", "Pink", "Yellow", "Brown",
        //                                     "Cyan", "Black", "White", "Gray", "Magenta"]
        //                             delegate: AbstractButton
        //                             {
        //                                 id: colorButton
        //                                 width: 100
        //                                 height: 30
        //                                 background: Rectangle
        //                                 {
        //                                     color: modelData
        //                                     radius: 2
        //                                     border.color: "black"
        //                                     border.width: 2
        //                                 }

        //                                 onClicked:
        //                                 {


        //                                     var updates = colorSelectionRow.toneDatabase[modelData]
        //                                     colorSelectionRow.dynamicTonesList = updates


        //                                 }

        //                             }
        //                         }
        //                     }

        //                 }
        //                 ScrollView
        //                 {
        //                     Layout.preferredWidth: 100
        //                     Layout.preferredHeight: 150
        //                     clip: true

        //                     ScrollBar.vertical.policy: ScrollBar.AsNeeded
        //                     ScrollBar.vertical.implicitWidth: 6

        //                     Grid
        //                     {

        //                         columns: 1
        //                         Layout.preferredHeight: parent.height
        //                         spacing: 0
        //                         Repeater
        //                         {
        //                             model: colorSelectionRow.dynamicTonesList
        //                             delegate: AbstractButton
        //                             {

        //                                 width: 100
        //                                 height: 30
        //                                 background: Rectangle
        //                                 {
        //                                     color: modelData

        //                                     border.color: "black"
        //                                     border.width: 3
        //                                 }

        //                                 onClicked:
        //                                 {
        //                                     f.receiveOptionColor(currentSelectButton, modelData)
        //                                 }
        //                             }
        //                         }
        //                     }
        //                 }
        //             }
        //         }
        //     }
        //     Rectangle
        //     {
        //         width: 15
        //         height: 15
        //         color: "white"
        //     }
        // }


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
                color: globalTheme.mainBackground
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
                                id:showButtonAddAssign
                                Layout.preferredWidth: 40
                                Layout.preferredHeight: 40
                                color: globalTheme.buttons
                                radius: width / 2

                                Layout.alignment: Qt.AlignHCenter

                                Image
                                {
                                    source: `../iconTemplates/${globalTheme.iconFolder}/AddIcon`
                                    sourceSize.width: showButtonAddAssign.width
                                    sourceSize.height: showButtonAddAssign.height
                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit
                                }
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
                                        font.family: globalTheme.font
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
                                    anchors.topMargin: 5
                                    RowLayout
                                    {
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        Text
                                        {
                                            font.family: globalTheme.font
                                            text: "To Do List"
                                            color: "white"
                                            font.pixelSize: 12
                                            Layout.leftMargin: 4

                                        }
                                        Rectangle
                                        {
                                            id: showButtonAddToDo
                                            Layout.preferredWidth: 15
                                            Layout.preferredHeight: 15
                                            color: globalTheme.buttons
                                            radius: width / 2
                                            Image
                                            {
                                                source: `../iconTemplates/${globalTheme.iconFolder}/AddIcon`
                                                sourceSize.width: showButtonAddToDo.width
                                                sourceSize.height: showButtonAddToDo.height
                                                anchors.centerIn: parent
                                                fillMode: Image.PreserveAspectFit
                                            }
                                        }
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
                                Layout.preferredHeight: 40
                                color: globalTheme.clockColor
                                border.color: globalTheme.borderColor
                                border.width: 3
                                radius: 8
                                Text
                                {
                                    font.family: globalTheme.font
                                    text: "12:00:00 PM"
                                    anchors.centerIn: parent
                                    color: "white"
                                    font.pixelSize: 18
                                }
                            }
                            Rectangle
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 100
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
                                        Layout.preferredHeight: 25
                                        color: "black"
                                    }
                                    Rectangle
                                    {

                                        Layout.preferredHeight: 10
                                        Layout.preferredWidth: 35
                                        Layout.alignment: Qt.AlignHCenter
                                        radius: 8
                                        color:globalTheme.buttons
                                        border.color: globalTheme.borderColor
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
                                            color: globalTheme.mp3Color
                                        }
                                        Rectangle
                                        {
                                            height: 12
                                            width: 12
                                            radius: width / 2
                                            x: (line.width * 0.25) - (width / 2)
                                            anchors.verticalCenter: parent.verticalCenter
                                            color: Qt.lighter(globalTheme.mp3Color, 0.4)
                                        }

                                    }
                                    Rectangle
                                    {
                                        Layout.preferredHeight: 22
                                        Layout.preferredWidth: 120
                                        Layout.alignment: Qt.AlignHCenter
                                        radius: 4
                                        color: globalTheme.buttons
                                        RowLayout
                                        {

                                            anchors.centerIn: parent
                                            Rectangle
                                            {
                                                id: showForwardBack
                                                Layout.preferredHeight: 20
                                                Layout.preferredWidth: 20
                                                radius: width / 2
                                                color: globalTheme.buttons
                                                Image
                                                {
                                                    source: `../iconTemplates/${globalTheme.iconFolder}/SkipIcon`
                                                    sourceSize.width: 18
                                                    sourceSize.height: 18
                                                    anchors.centerIn: parent
                                                    fillMode: Image.PreserveAspectFit
                                                    rotation: 180
                                                }
                                            }
                                            Rectangle
                                            {
                                                id: showButtonPlay
                                                Layout.preferredHeight: 22
                                                Layout.preferredWidth: 22
                                                radius: width / 2
                                                color: globalTheme.buttons
                                                Image
                                                {
                                                    // id: rightArrowIcon
                                                    source: `../iconTemplates/${globalTheme.iconFolder}/PlayIcon`
                                                    sourceSize.width: 20
                                                    sourceSize.height: 20
                                                    anchors.centerIn: parent
                                                    fillMode: Image.PreserveAspectFit
                                                }
                                            }
                                            Rectangle
                                            {
                                                id: showForward
                                                Layout.preferredHeight:20
                                                Layout.preferredWidth: 20
                                                radius: width / 2
                                                color: globalTheme.buttons
                                                Image
                                                {
                                                    source: `../iconTemplates/${globalTheme.iconFolder}/skipIcon`
                                                    sourceSize.width: 18
                                                    sourceSize.height: 18
                                                    anchors.centerIn: parent
                                                    fillMode: Image.PreserveAspectFit

                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 55
                                radius: 8
                                color: globalTheme.backgroundRectangleMain
                                border.color: globalTheme.borderColor
                                border.width: 3
                                ColumnLayout
                                {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    Rectangle
                                    {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 20
                                        radius: 8
                                        color: globalTheme.rectangleInfoColor
                                    }
                                    Rectangle
                                    {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 20
                                        radius: 8
                                        color: globalTheme.rectangleInfoColor
                                    }
                                }
                            }

                            Rectangle
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 65
                                color: globalTheme.backgroundRectangleMain
                                border.color: globalTheme.borderColor
                                border.width: 3
                                radius: 8
                                ColumnLayout
                                {
                                    anchors.fill: parent
                                    anchors.margins: 6
                                    Rectangle
                                    {
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        color: globalTheme.buttons
                                        radius: 8
                                        RowLayout
                                        {
                                            anchors.fill: parent
                                            anchors.margins: 2
                                            Rectangle
                                            {
                                                id: showButtonLeft
                                                Layout.preferredHeight: 25
                                                Layout.preferredWidth: 25
                                                radius: width / 2
                                                color: globalTheme.buttons
                                                Image
                                                {
                                                    source: `../iconTemplates/${globalTheme.iconFolder}/ArrowIcon`
                                                    sourceSize.width: showButtonLeft.width
                                                    sourceSize.height: showButtonLeft.height
                                                    anchors.centerIn: parent
                                                    fillMode: Image.PreserveAspectFit
                                                    rotation: 180
                                                }
                                            }
                                            Rectangle
                                            {
                                                id: showButtonRight
                                                Layout.preferredHeight: 25
                                                Layout.preferredWidth: 25
                                                radius: width / 2
                                                color: globalTheme.buttons
                                                Image
                                                {
                                                    source: `../iconTemplates/${globalTheme.iconFolder}/ArrowIcon`
                                                    sourceSize.width: showButtonRight.width
                                                    sourceSize.height: showButtonRight.height
                                                    anchors.centerIn: parent
                                                    fillMode: Image.PreserveAspectFit
                                                }
                                            }
                                            Item
                                            {
                                                Layout.fillWidth: true
                                            }
                                            Rectangle
                                            {
                                                id: showSettings
                                                Layout.preferredHeight: 25
                                                Layout.preferredWidth: 25
                                                radius: width / 2
                                                color: globalTheme.buttons

                                                Image
                                                {
                                                    source: `../iconTemplates/${globalTheme.iconFolder}/GearIcon`
                                                    sourceSize.width: showSettings.width
                                                    sourceSize.height: showSettings.height
                                                    anchors.centerIn: parent
                                                    fillMode: Image.PreserveAspectFit
                                                }
                                            }
                                        }
                                    }


                                    Rectangle
                                    {
                                        Layout.preferredHeight: 20
                                        Layout.fillWidth: true
                                        radius: 8
                                        color: "black"
                                        border.color: globalTheme.borderColor
                                        border.width: 2
                                    }
                                }
                            }
                            Rectangle
                            {
                                id: showButtonAddPage
                                Layout.preferredHeight: 20
                                Layout.preferredWidth: 20
                                radius: width / 2
                                color: globalTheme.buttons
                                Layout.alignment: Qt.AlignRight
                                Image
                                {
                                    source: `../iconTemplates/${globalTheme.iconFolder}/AddIcon`
                                    sourceSize.width: showButtonAddPage.width
                                    sourceSize.height: showButtonAddPage.height
                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit
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
