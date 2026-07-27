import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Window


Rectangle
{
    id: mainLeftRectangle
    width: leftRectangle.width
    height: 80
    color: assignmentDetails.pressed ? "#401a1a2e" : globalTheme.rectangleInfoColor
    scale: assignmentDetails.pressed ? 0.9 : 1.0
    border.color: assignmentDetails.pressed ? "#80ffffff" : "white"

    radius: 3
    Text
    {
        anchors.centerIn: parent
        id: assignmentTitle
        text: titleInput.text
        font.family: globalTheme.font
        font.pixelSize: 20
        color: globalTheme.titleFont
    }

    NumberAnimation
    {
            id: appearanceAnim
            target: mainLeftRectangle
            property: "scale"
            from: 0
            to: 1.0
            duration: 300
            easing.type: Easing.OutBack // Gives it a nice slight "bounce" at the end
    }
    Component.onCompleted: appearanceAnim.start()
    TapHandler
    {
        id: assignmentDetails
        onTapped:
        {
            f.retrieveAssignmentIndex(model.assignmentIndex)
            detailPopup.open()
        }

    }

    //Details for assignments
    Popup
    {
        id: detailPopup
        parent: Overlay.overlay
        anchors.centerIn: parent

        width: mainWindow.width * 0.95
        height: mainWindow.height * 0.80
        modal: true             // Dims the background
        focus: true             // Captures keyboard focus
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

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
            id: popupBackground
            color: globalTheme.mainBackground
            border.color: globalTheme.borderColor
            border.width: 2
            radius: 12
            TapHandler
            {
                onTapped:
                {
                    popupBackground.forceActiveFocus()
                }
                // gesturePolicy: TapHandler.WithinBounds
            }
        }
        // background: Rectangle
        // {
        //     id: popupBackground
        //     color: "#1a1a2e"
        //     border.color: "#40ffffff"
        //     border.width: 1
        //     radius: 16
        //     TapHandler
        //     {
        //         onTapped:
        //         {
        //             popupBackground.forceActiveFocus()
        //         }
        //         gesturePolicy: TapHandler.WithinBounds
        //     }
        // }

        contentItem: ColumnLayout
        {
            TextField
            {
                id: titleInput
                // text: rectModel.info
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 30
                text: "Assignment Title"
                font.family: globalTheme.font


                color: globalTheme.titleFont
                maximumLength: 30

                onAccepted:
                {
                    // Steal focus away from this text field and give it to the popup root
                    popupBackground.forceActiveFocus()
                }

                background: Rectangle
                {
                    color: Qt.lighter(globalTheme.rectangleInfoColor, 1.3)
                    radius: 8
                }
                onTextEdited:
                {
                    f.assignmentTitle(titleInput.text)

                }
            }




            RowLayout
            {
                ColumnLayout
                {
                    Layout.fillHeight: true
                    Rectangle
                    {
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: globalTheme.rectangleInfoColor
                        border.color: globalTheme.borderColor
                        border.width: 2
                        radius: 5
                    }
                    Rectangle
                    {
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: globalTheme.rectangleInfoColor
                        border.color: globalTheme.borderColor
                        border.width: 2
                        radius: 5
                    }
                }


                Rectangle
                {
                    width: mainWindow.width * 0.30
                    Layout.alignment: Qt.AlignRight
                    Layout.fillHeight: true
                    border.color: globalTheme.borderColor
                    border.width: 2
                    color: globalTheme.backgroundRectangleMain
                    radius: 5
                    ColumnLayout
                    {
                        anchors.fill: parent
                        anchors.margins: 8

                        Rectangle
                        {
                            Layout.preferredHeight: 30
                            Layout.fillWidth: true
                            radius: 5
                            border.color: globalTheme.borderColor
                            border.width: 2
                            color: Qt.lighter(globalTheme.rectangleInfoColor, 0.5)
                            Text
                            {
                                text: "Priority"
                                font.pixelSize: 20
                                anchors.centerIn: parent
                                font.family: globalTheme.font
                                // Rectangle
                                // {
                                //     anchors.top: parent.bottom
                                //     anchors.horizontalCenter: parent.horizontalCenter

                                //     // 💡 1. Adjust line thickness here
                                //     height: 3

                                //     // 💡 2. Adjust line length relative to text width (or set to parent.width)
                                //     width: parent.contentWidth

                                //     color: parent.color
                                // }
                            }
                        }
                        AbstractButton
                        {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            background: Rectangle
                            {
                                id: selectedOption
                                radius: 5
                                border.color: globalTheme.borderColor
                                color: "black"
                            }
                            onClicked:
                            {
                                onTapped: detailsPop.open()
                            }

                            Text
                            {
                                id: firstRow
                                anchors.centerIn: parent
                                color: "black"
                                font.pixelSize: 30
                                font.family: globalTheme.font


                                Popup
                                {
                                    id: detailsPop
                                    focus: true             // Captures keyboard focus
                                    modal: true         // Blocks mouse clicks in the background
                                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                                    x: (parent.width - detailsPop.width) / 2
                                    y: (parent.height - height) / 2
                                    z: 100
                                    width: parent.width * 0.95
                                    height: parent.height * 0.80

                                    onClosed:
                                    {
                                        f.priority(firstRow.text)
                                    }

                                    background: Rectangle
                                    {
                                        color: "transparent"
                                    }
                                    ColumnLayout
                                    {
                                        AbstractButton
                                        {
                                            id: firstOption
                                            width: 150
                                            height: 50
                                            Text
                                            {
                                                text: "HIGH"
                                                color: "white"
                                                anchors.centerIn: parent

                                            }
                                            background: Rectangle
                                            {
                                                radius: 5
                                                color: firstOption.down ? "black" : "blue"
                                                border.color: "white"
                                            }
                                            onClicked:
                                            {
                                                firstRow.text = "HIGH"
                                                selectedOption.color = "red"
                                                detailsPop.close()
                                            }
                                        }

                                        AbstractButton
                                        {
                                            id: secondOption
                                            width: 150
                                            height: 50
                                            Text
                                            {
                                                text: "MEDIUM"
                                                color: "white"
                                                anchors.centerIn: parent
                                            }
                                            background: Rectangle
                                            {
                                                color: secondOption.down ? "black" : "blue"
                                                radius: 5
                                                border.color: "white"
                                            }

                                            onClicked:
                                            {
                                                firstRow.text = "MEDIUM"
                                                selectedOption.color = "yellow"
                                                detailsPop.close()
                                            }
                                        }
                                        AbstractButton
                                        {
                                            id: thirdOption
                                            width: 150
                                            height: 50

                                            Text
                                            {
                                                text: "LOW"
                                                color: "white"
                                                anchors.centerIn: parent
                                            }
                                            background: Rectangle
                                            {
                                                color: thirdOption.down ? "black" : "blue"
                                                radius: 5
                                                border.color: "white"
                                            }

                                            onClicked:
                                            {
                                                firstRow.text = "LOW"
                                                selectedOption.color = "green"
                                                detailsPop.close()
                                            }
                                        }
                                        AbstractButton
                                        {
                                            id: fourthOption
                                            width: 150
                                            height: 50

                                            Text
                                            {
                                                text: "NONE"
                                                color: "white"
                                                anchors.centerIn: parent
                                            }
                                            background: Rectangle
                                            {
                                                color: fourthOption.down ? "black" : "blue"
                                                radius: 5
                                                border.color: "white"
                                            }

                                            onClicked:
                                            {
                                                firstRow.text = "NONE"
                                                selectedOption.color = "gray"
                                                detailsPop.close()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Rectangle
                        {
                            id:timePick
                            Layout.fillWidth: true
                            Layout.preferredHeight: 80

                            property string totalTime: hourText.text + ":" + minuteText.text + timeOfDayText.text

                            color: Qt.lighter(globalTheme.rectangleInfoColor, 0.5)
                            border.color: globalTheme.borderColor
                            radius: 5


                            function formatString(modelData)
                            {
                                let timeAmount = modelData + 1 < 10 ? "0" + (modelData + 1).toString() : (modelData + 1).toString()
                                return timeAmount
                            }


                            RowLayout
                            {
                                anchors.fill: parent
                                spacing: 0

                                Item
                                {
                                    Layout.fillWidth: true
                                }

                                AbstractButton
                                {
                                    id: hour
                                    Layout.alignment: Qt.AlignHCenter
                                    Layout.preferredWidth: 60
                                    Layout.preferredHeight: 30


                                    background: Rectangle
                                    {
                                        color:hour.down ? Qt.lighter(globalTheme.rectangleInfoColor, 0.5) : (hour.hovered ? Qt.lighter(globalTheme.rectangleInfoColor, 1.5) : Qt.lighter(globalTheme.rectangleInfoColor, 0.4))

                                        border.color: "black"
                                        border.width: 2
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
                                        id: hourText
                                        font.pixelSize: 15
                                        font.family: globalTheme.font
                                        anchors.centerIn: parent
                                    }

                                    onClicked:
                                    {
                                        hourPop.open()
                                    }

                                    Popup
                                    {
                                        id: hourPop

                                        // anchors.centerIn: parent

                                        y: hour.height

                                        width: hour.width
                                        height: hour.height / 1.5 * 10

                                        focus: true             // Captures keyboard focus
                                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside


                                        // Smooth fade in/out transition
                                        enter: Transition {
                                            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200 }
                                        }
                                        exit: Transition {
                                            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 150 }
                                        }
                                        background: Rectangle
                                        {
                                            id: h
                                            color: "transparent"
                                            border.color: globalTheme.borderColor
                                            border.width: 1

                                            // TapHandler
                                            // {
                                            //     onTapped:
                                            //     {
                                            //         h.forceActiveFocus()
                                            //     }
                                            //     // gesturePolicy: TapHandler.WithinBounds
                                            // }
                                        }
                                        contentItem:ListView
                                        {
                                            anchors.fill: parent
                                            clip: true


                                            boundsBehavior: Flickable.StopAtBounds
                                            interactive: true

                                            model: 12
                                            delegate:AbstractButton
                                            {
                                                id: currentHour
                                                width: hour.width
                                                height: hour.height / 1.5

                                                background:Rectangle
                                                {
                                                    color:currentHour.down ? Qt.lighter(globalTheme.rectangleInfoColor, 0.3) :
                                                         (currentHour.hovered ? Qt.lighter(globalTheme.rectangleInfoColor, 1.5) : Qt.lighter(globalTheme.rectangleInfoColor, 0.4))

                                                    border.color: globalTheme.borderColor
                                                    border.width: 1
                                                }
                                                Text
                                                {

                                                    color: "white"
                                                    text:  timePick.formatString(modelData)
                                                    anchors.right: parent.right
                                                    rightPadding: 2
                                                }
                                                onClicked:
                                                {
                                                    hourText.text = timePick.formatString(modelData)
                                                    // time.selectedHour = hourText.text
                                                    hourPop.close()
                                                }
                                            }
                                        }
                                        onClosed:
                                        {
                                           f.saveTime(timePick.totalTime)
                                        }
                                    }
                                }
                                AbstractButton
                                {
                                    id: minutes
                                    Layout.alignment: Qt.AlignHCenter
                                    Layout.preferredWidth:60
                                    Layout.preferredHeight: 30

                                    background: Rectangle
                                    {
                                        color:minutes.down ? Qt.lighter(globalTheme.rectangleInfoColor, 0.5) : (minutes.hovered ? Qt.lighter(globalTheme.rectangleInfoColor, 1.5) : Qt.lighter(globalTheme.rectangleInfoColor, 0.4))

                                        border.color: "black"
                                        border.width: 2
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

                                        id: minuteText
                                        font.pixelSize: 15
                                        font.family: globalTheme.font
                                        anchors.centerIn: parent
                                    }

                                    onClicked:
                                    {
                                        minutePop.open()
                                    }
                                    Popup
                                    {
                                        id: minutePop

                                        // anchors.centerIn: parent

                                        y: minutes.height

                                        width: minutes.width
                                        height: minutes.height / 1.5 * 10

                                        focus: true             // Captures keyboard focus
                                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside


                                        // Smooth fade in/out transition
                                        enter: Transition {
                                            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200 }
                                        }
                                        exit: Transition {
                                            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 150 }
                                        }
                                        background: Rectangle
                                        {
                                            id: m
                                            color: "transparent"
                                            border.color: globalTheme.borderColor
                                            border.width: 1

                                            // TapHandler
                                            // {
                                            //     onTapped:
                                            //     {
                                            //         h.forceActiveFocus()
                                            //     }
                                            //     // gesturePolicy: TapHandler.WithinBounds
                                            // }
                                        }
                                       contentItem:ListView
                                        {
                                            anchors.fill: parent
                                            clip: true


                                            boundsBehavior: Flickable.StopAtBounds
                                            interactive: true

                                            model:59
                                            delegate:AbstractButton
                                            {
                                                id: currentMinute
                                                width: minutes.width
                                                height: minutes.height / 1.5

                                                background:Rectangle
                                                {
                                                    color:currentMinute.down ? Qt.lighter(globalTheme.rectangleInfoColor, 0.3) :
                                                         (currentMinute.hovered ? Qt.lighter(globalTheme.rectangleInfoColor, 1.5) : Qt.lighter(globalTheme.rectangleInfoColor, 0.4))

                                                    border.color: globalTheme.borderColor
                                                    border.width: 1

                                                }
                                                contentItem:Text
                                                {
                                                    color: "white"
                                                    text:  timePick.formatString(modelData)
                                                    horizontalAlignment: Text.AlignRight
                                                    verticalAlignment: Text.AlignVCenter
                                                    rightPadding: 2
                                                }
                                                onClicked:
                                                {
                                                    minuteText.text = timePick.formatString(modelData)
                                                    minutePop.close()
                                                }
                                            }
                                        }
                                       onClosed:
                                       {
                                          f.saveTime(timePick.totalTime)
                                       }
                                    }

                                }
                                AbstractButton
                                {

                                    id: timeOfDay
                                    Layout.alignment: Qt.AlignHCenter
                                    Layout.preferredWidth: 60
                                    Layout.preferredHeight: 30

                                    background: Rectangle
                                    {
                                        color:timeOfDay.down ? Qt.lighter(globalTheme.rectangleInfoColor, 0.5) : (timeOfDay.hovered ? Qt.lighter(globalTheme.rectangleInfoColor, 1.5) : Qt.lighter(globalTheme.rectangleInfoColor, 0.4))

                                        border.color: "black"
                                        border.width: 2
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

                                        id: timeOfDayText
                                        font.pixelSize: 15
                                        font.family: globalTheme.font
                                        anchors.centerIn: parent
                                    }

                                    onClicked:
                                    {
                                        timeOfDayPop.open()
                                    }
                                    Popup
                                    {
                                        id: timeOfDayPop

                                        // anchors.centerIn: parent

                                        y: timeOfDay.height

                                        width: timeOfDay.width
                                        height: (timeOfDay.height / 1.5) * 2

                                        focus: true             // Captures keyboard focus
                                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside


                                        // Smooth fade in/out transition
                                        enter: Transition {
                                            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200 }
                                        }
                                        exit: Transition {
                                            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 150 }
                                        }
                                        background: Rectangle
                                        {
                                            id: t
                                            color: "transparent"
                                            border.color: globalTheme.borderColor
                                            border.width: 1
                                            // TapHandler
                                            // {
                                            //     onTapped:
                                            //     {
                                            //         h.forceActiveFocus()
                                            //     }
                                            //     // gesturePolicy: TapHandler.WithinBounds
                                            // }
                                        }
                                        contentItem:ListView
                                        {
                                            anchors.fill: parent
                                            clip: true

                                            boundsBehavior: Flickable.StopAtBounds
                                            interactive: true

                                            model:["AM", "PM"]
                                            delegate:AbstractButton
                                            {
                                                id: currentPeriod
                                                width: timeOfDay.width
                                                height: timeOfDay.height / 1.5

                                                background:Rectangle
                                                {
                                                    color:currentPeriod.down ? Qt.lighter(globalTheme.rectangleInfoColor, 0.3) :
                                                         (currentPeriod.hovered ? Qt.lighter(globalTheme.rectangleInfoColor, 1.5) : Qt.lighter(globalTheme.rectangleInfoColor, 0.4))

                                                    border.color: globalTheme.borderColor
                                                    border.width: 1
                                                }
                                                Text
                                                {
                                                    color: "white"
                                                    text:  modelData
                                                    anchors.right: parent.right
                                                    rightPadding: 2
                                                }
                                                onClicked:
                                                {
                                                    timeOfDayText.text = modelData
                                                    timeOfDayPop.close()
                                                }
                                            }
                                        }
                                        onClosed:
                                        {
                                           f.saveTime(timePick.totalTime)
                                        }
                                    }

                                }
                                Item
                                {
                                    Layout.fillWidth: true
                                }

                                // Rectangle
                                // {
                                //     width: 15
                                //     height: 15

                                //     color: "white"


                                //     Popup
                                //     {
                                //         id: hourPop
                                //         anchors.centerIn: parent

                                //         width: parent.width * 0.95
                                //         height: parent.height * 0.80
                                //         modal: true             // Dims the background
                                //         focus: true             // Captures keyboard focus
                                //         closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                                //         Overlay.modal: Rectangle
                                //         {
                                //             color: "#AA000000"
                                //         }

                                //         // Smooth fade in/out transition
                                //         enter: Transition {
                                //             NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200 }
                                //         }
                                //         exit: Transition {
                                //             NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 150 }
                                //         }
                                //         background: Rectangle
                                //         {
                                //             id: p
                                //             color: globalTheme.mainBackground
                                //             border.color: globalTheme.borderColor
                                //             border.width: 2
                                //             radius: 12
                                //             TapHandler
                                //             {
                                //                 onTapped:
                                //                 {
                                //                     p.forceActiveFocus()
                                //                 }
                                //                 // gesturePolicy: TapHandler.WithinBounds
                                //             }
                                //         }
                                //     }

                                // }

                                // ComboBox
                                // {

                                //     id: customCombo
                                //     width: 100
                                //     model: 13

                                //     // Customizes the main display button
                                //     popup.height: 100

                                //     contentItem: Text
                                //     {
                                //         text: customCombo.displayText
                                //         color: "white"
                                //         verticalAlignment: Text.AlignVCenter
                                //         leftPadding: 10
                                //     }

                                //     background: Rectangle
                                //     {
                                //         color: "#2d2d2d"
                                //         radius: 4
                                //         border.color: "#007acc"
                                //     }

                                //     // Customizes the items inside the drop-down popup
                                //     delegate: ItemDelegate

                                //     {
                                //         highlighted: delegateItem.hovered || customCombo.currentIndex === index
                                //         width: customCombo.width
                                //         contentItem: Text
                                //         {
                                //             text: modelData < 10 ? "0" +modelData.toString() : modelData
                                //             color: "black"

                                //         }
                                //         // highlighted: customCombo.highlightedIndex === index

                                //     }
                                // }
                            }

                        }

                        // AbstractButton
                        // {
                        //     id: timeVary
                        //     property string totalTime: hour.model[hour.currentIndex] + ":" + minutes.model[minutes.currentIndex] + " " + timePeriod.model[timePeriod.currentIndex]

                        //     // property bool visibility: true
                        //     Layout.fillWidth: true
                        //     Layout.preferredHeight: 80
                        //     // checkable: true
                        //     // checked: true


                        //     background:Rectangle
                        //     {
                        //         color: Qt.lighter(globalTheme.rectangleInfoColor, 0.4)
                        //         border.color: globalTheme.borderColor
                        //         radius: 5

                        //     }
                        //     onCheckedChanged:
                        //     {
                        //         if(timeVary.checked === true)
                        //         {
                        //             f.saveTime(totalTime)
                        //         }
                        //     }
                        //     onClicked:
                        //     {
                        //         selectTime.open()
                        //     }

                        //     Text
                        //     {   anchors.centerIn: parent
                        //         text: timeVary.totalTime
                        //         color: "white"
                        //         visible: timeVary.checked
                        //     }
                        //     Popup
                        //     {
                        //         id: selectTime
                        //         width: (parent.width * 0.95)
                        //         height:(parent.height * 0.95)
                        //         anchors.centerIn: parent
                        //         modal: true
                        //         focus: true
                        //         closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                        //         Overlay.modal: Rectangle
                        //         {
                        //             color: "#AA000000"
                        //         }
                        //         enter: Transition {
                        //             NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200 }
                        //         }
                        //         exit: Transition {
                        //             NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 150 }
                        //         }
                        //         background: Rectangle
                        //         {
                        //             color: globalTheme.backgroundRectangleMain
                        //             border.color: globalTheme.borderColor
                        //             border.width: 2
                        //             radius: 5
                        //         }
                        //         contentItem:RowLayout
                        //         {
                        //             // anchors.fill: parent
                        //             id:time
                        //             ComboBox {
                        //                 id: customCombo
                        //                 width: 200
                        //                 model: ["1", "2"]

                        //                 // Customizes the main display button
                        //                 contentItem: Text
                        //                 {
                        //                     text: customCombo.displayText
                        //                     color: "white"
                        //                     verticalAlignment: Text.AlignVCenter
                        //                     leftPadding: 10
                        //                 }

                        //                 background: Rectangle
                        //                 {
                        //                     color: "#2d2d2d"
                        //                     radius: 4
                        //                     border.color: "#007acc"
                        //                 }

                        //                 // Customizes the items inside the drop-down popup
                        //                 delegate: ItemDelegate
                        //                 {
                        //                     width: customCombo.width
                        //                     contentItem: Text
                        //                     {
                        //                         text: modelData
                        //                         color: "black"
                        //                     }

                        //                 }
                        //             }


                        //             // Text
                        //             // {
                        //             //     id: timeLabel
                        //             //     text: formatText(Tumbler.tumbler.count, modelData)
                        //             //     opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
                        //             //     horizontalAlignment: Text.AlignHCenter
                        //             //     verticalAlignment: Text.AlignVCenter
                        //             //     color: "white"

                        //             //     function formatText(count, modelData) {
                        //             //         var data = count === 12 ? modelData + 1 : modelData;
                        //             //         return data.toString().length < 2 ? "0" + data : data;
                        //             //     }
                        //             // }

                        //             // Tumbler {
                        //             //     id: hoursTumbler
                        //             //     model: 12
                        //             //     delegate: timeLabel
                        //             //     wheelEnabled: true
                        //             //     implicitWidth: 40
                        //             //             Layout.preferredHeight: 60
                        //             // }

                        //             // Tumbler {
                        //             //     id: minutesTumbler
                        //             //     model: 60
                        //             //     delegate: timeLabel
                        //             //     implicitWidth: 40
                        //             //             Layout.preferredHeight: 120
                        //             // }

                        //             // Tumbler {
                        //             //     id: amPmTumbler
                        //             //     model: ["AM", "PM"]
                        //             //     delegate: timeLabel
                        //             //     implicitWidth: 40
                        //             //             Layout.preferredHeight: 120
                        //             // }




                        //             // Tumbler
                        //             // {
                        //             //     Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        //             //     id: hour
                        //             //     Layout.preferredWidth: 40
                        //             //     Layout.fillHeight:true
                        //             //     model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
                        //             //     wheelEnabled: true
                        //             //     visibleItemCount: 3
                        //             //     visible: !timeVary.checked
                        //             //     contentItem: ListView
                        //             //     {
                        //             //         anchors.fill: parent
                        //             //         model: hour.model
                        //             //         delegate: hour.delegate
                        //             //         interactive: true
                        //             //         //snapMode: ListView.SnapToItem
                        //             //         highlightRangeMode: ListView.StrictlyEnforceRange
                        //             //         preferredHighlightBegin: height / 3
                        //             //         preferredHighlightEnd: (height / 3) * 2
                        //             //     }
                        //             //     delegate: Text
                        //             //     {
                        //             //         text: modelData < 10 ? "0" + modelData : modelData // Ensures "01" instead of "1"
                        //             //         color: index === hour.currentIndex ? "white" : "gray"
                        //             //         font.pixelSize:12
                        //             //         horizontalAlignment: Text.AlignHCenter
                        //             //         verticalAlignment: Text.AlignVCenter
                        //             //     }
                        //             // }
                        //             // Text
                        //             // {
                        //             //     text: ":"
                        //             //     color: "white"
                        //             //     //visible: !timeVary.checked
                        //             // }
                        //             // Tumbler
                        //             // {
                        //             //     Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        //             //     id: minutes
                        //             //     Layout.preferredWidth: 40
                        //             //     Layout.fillHeight: true
                        //             //     model: Array.from(
                        //             //     {
                        //             //         length: 60
                        //             //     },
                        //             //         function(value, index)
                        //             //         {
                        //             //             return index < 10 ? "0" + index : "" + index
                        //             //         })
                        //             //     wheelEnabled: true
                        //             //     visible: !timeVary.checked
                        //             //     visibleItemCount: 3
                        //             //     contentItem: ListView
                        //             //     {
                        //             //         anchors.fill: parent
                        //             //         model: minutes.model
                        //             //         delegate: minutes.delegate
                        //             //         interactive: true
                        //             //         snapMode: ListView.SnapToItem
                        //             //         highlightRangeMode: ListView.StrictlyEnforceRange
                        //             //         preferredHighlightBegin: height / 3
                        //             //         preferredHighlightEnd: (height / 3) * 2
                        //             //     }
                        //             //     delegate: Text
                        //             //     {
                        //             //         text: modelData
                        //             //         color: index === minutes.currentIndex ? "white" : "gray"
                        //             //         font.pixelSize:12
                        //             //         horizontalAlignment: Text.AlignHCenter
                        //             //         verticalAlignment: Text.AlignVCenter

                        //             //     }
                        //             // }
                        //             // Tumbler
                        //             // {
                        //             //     //Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        //             //     id: timePeriod
                        //             //     Layout.preferredWidth: 40
                        //             //     Layout.fillHeight: true
                        //             //     model: ["AM", "PM"]
                        //             //     visible: !timeVary.checked
                        //             //     wheelEnabled: true
                        //             //     visibleItemCount: 2
                        //             //     contentItem: ListView
                        //             //     {
                        //             //         anchors.fill: parent
                        //             //         model: timePeriod.model
                        //             //         delegate: timePeriod.delegate
                        //             //         interactive: true
                        //             //         snapMode: ListView.SnapToItem
                        //             //         highlightRangeMode: ListView.StrictlyEnforceRange
                        //             //         preferredHighlightBegin: 13
                        //             //         preferredHighlightEnd: 34
                        //             //     }
                        //             //     delegate: Text
                        //             //     {
                        //             //         text: modelData
                        //             //         color: index === timePeriod.currentIndex ? "white" : "gray"
                        //             //         font.pixelSize:12
                        //             //         horizontalAlignment: Text.AlignHCenter
                        //             //         verticalAlignment: Text.AlignVCenter
                        //             //     }

                        //             // }
                        //         }

                        //     }


                        // }
                        Rectangle
                        {
                            Layout.fillWidth: true
                            color: Qt.lighter(globalTheme.rectangleInfoColor, 0.5)
                            border.color: globalTheme.borderColor
                            Layout.fillHeight: true
                            radius: 5
                        }
                        Rectangle
                        {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: Qt.lighter(globalTheme.rectangleInfoColor, 0.5)
                            border.color: globalTheme.borderColor
                            radius: 5
                        }
                    }
                }
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

