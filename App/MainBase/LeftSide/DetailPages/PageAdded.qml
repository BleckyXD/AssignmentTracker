import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls



Rectangle
{
    id: mainLeftRectangle
    width: leftRectangle.width
    height: 80
    color: assignmentDetails.pressed ? "#401a1a2e" : "#1a1a2e"
    scale: assignmentDetails.pressed ? 0.9 : 1.0
    border.color: assignmentDetails.pressed ? "#80ffffff" : "white"

    radius: 3
    Text
    {
        anchors.centerIn: parent
        id: assignmentTitle
        text: titleInput.text
        color:"white"
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
        x: ((mainWindow.width - width) / 2)
        y: (mainWindow.height - height) / 2
        z: 50
        width: mainWindow.width * 0.95
        height: mainWindow.height * 0.80
        modal: true             // Dims the background
        focus: true             // Captures keyboard focus
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        padding: 25


        background: Rectangle
        {
            id: popupBackground
            color: "#1a1a2e"
            border.color: "#40ffffff"
            border.width: 1
            radius: 16
            TapHandler
            {
                onTapped:
                {
                    popupBackground.forceActiveFocus()
                }
                gesturePolicy: TapHandler.WithinBounds
            }
        }

        contentItem: ColumnLayout
        {

            TextField
            {
                id: titleInput
                text: rectModel.info
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 228
                placeholderText: "Enter assignment title..."
                color: "black"
                maximumLength: 35
                horizontalAlignment: TextInput.AlignHCenter
                onAccepted:
                {
                    // Steal focus away from this text field and give it to the popup root
                    popupBackground.forceActiveFocus()
                }

                background: Rectangle
                {

                    color: "gray"
                    border.color: "dark green"
                    radius: 8
                }
                onTextEdited:
                {
                    f.assignmentTitle(titleInput.text)

                }
            }
            RowLayout
            {
                Rectangle
                {
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.preferredHeight: 200
                    color: "yellow"
                    radius: 5
                }
                Rectangle
                {
                    width: mainWindow.width * 0.30
                    Layout.alignment: Qt.AlignRight
                    Layout.fillHeight: true
                    color: "green"
                    radius: 5
                    ColumnLayout
                    {
                        anchors.fill: parent
                        anchors.margins: 8
                        Rectangle
                        {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "red"
                            radius: 5

                            TapHandler
                            {
                               onTapped: detailsPop.open()
                            }
                            Text
                            {
                                id: firstRow
                                text: "hey"
                                color: "black"
                                anchors.fill: parent
                                Popup
                                {
                                    id: detailsPop
                                    // parent: Overlay.overlay
                                    focus: true             // Captures keyboard focus
                                    modal: true         // Blocks mouse clicks in the background
                                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                                    x: ((parent.width - width) / 2)
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

                                        Rectangle
                                        {
                                            width: 150
                                            height: 50
                                            color: firstOption.pressed ? "black" : "blue"
                                            radius: 5
                                            Text
                                            {
                                                text: "IMPORTANT"
                                                color: "white"

                                            }
                                            TapHandler
                                            {
                                                id: firstOption
                                                onTapped:
                                                {
                                                    firstRow.text = "FIRST OPTION"
                                                }

                                            }
                                        }
                                        Rectangle
                                        {
                                            width: 150
                                            height: 50
                                            color: secondOption.pressed ? "black" : "blue"
                                            radius: 5
                                            Text
                                            {
                                                text: "IMPORTANT"
                                                color: "white"
                                            }
                                            TapHandler
                                            {
                                                id: secondOption
                                                onTapped:
                                                {
                                                    firstRow.text = "SECOND OPTION"
                                                }

                                            }
                                        }
                                        Rectangle
                                        {
                                            width: 150
                                            height: 50
                                            color: thirdOption.pressed ? "black" : "blue"
                                            radius: 5
                                            Text
                                            {
                                                text: "IMPORTANT"
                                                color: "white"
                                            }
                                            TapHandler
                                            {
                                                id: thirdOption
                                                onTapped:
                                                {
                                                    firstRow.text = "THIRD OPTION"
                                                }

                                            }
                                        }
                                        Rectangle
                                        {
                                            width: 150
                                            height: 50
                                            color: fourthOption.pressed ? "black" : "blue"
                                            radius: 5
                                            Text
                                            {
                                                text: "IMPORTANT"
                                                color: "white"
                                            }
                                            TapHandler
                                            {
                                                id: fourthOption
                                                onTapped:
                                                {
                                                    firstRow.text = "FOURTH OPTION"
                                                }

                                            }
                                        }
                                    }
                                }
                            }
                        }
                        AbstractButton
                        {
                            id: timeVary
                            property string totalTime: hour.model[hour.currentIndex] + ":" + minutes.model[minutes.currentIndex] + " " + timePeriod.model[timePeriod.currentIndex]

                            // property bool visibility: true
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            checkable: true
                            checked: true


                            background:Rectangle
                            {
                                color: "black"
                                radius: 5

                            }
                            onCheckedChanged:
                            {
                                if(timeVary.checked === true)
                                {
                                    f.saveTime(totalTime)
                                }
                            }

                            Text
                            {   anchors.centerIn: parent
                                text: timeVary.totalTime
                                color: "white"
                                visible: timeVary.checked
                            }

                            RowLayout
                            {
                                // anchors.fill: parent
                                id:time
                                anchors.centerIn: parent



                                Tumbler
                                {
                                    // Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    id: hour
                                    Layout.preferredWidth: 40
                                    Layout.preferredHeight: 70
                                    model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
                                    wheelEnabled: true
                                    visibleItemCount: 3
                                    visible: !timeVary.checked
                                    contentItem: ListView
                                    {
                                        anchors.fill: parent
                                        model: hour.model
                                        delegate: hour.delegate
                                        interactive: true
                                        snapMode: ListView.SnapToItem
                                        highlightRangeMode: ListView.StrictlyEnforceRange
                                        preferredHighlightBegin: height / 3
                                        preferredHighlightEnd: (height / 3) * 2
                                    }
                                    delegate: Text
                                    {
                                        text: modelData < 10 ? "0" + modelData : modelData // Ensures "01" instead of "1"
                                        color: index === hour.currentIndex ? "white" : "gray"
                                        font.pixelSize:12
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                                Text
                                {
                                    text: ":"
                                    color: "white"
                                    visible: !timeVary.checked
                                }
                                Tumbler
                                {
                                    // Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    id: minutes
                                    Layout.preferredWidth: 40
                                    Layout.preferredHeight: 70
                                    model: Array.from(
                                               {
                                                   length: 60
                                               },
                                                    function(value, index)
                                                    {
                                                        return index < 10 ? "0" + index : "" + index
                                                    })
                                    wheelEnabled: true
                                    visible: !timeVary.checked
                                    visibleItemCount: 3
                                    contentItem: ListView
                                    {
                                        anchors.fill: parent
                                        model: minutes.model
                                        delegate: minutes.delegate
                                        interactive: true
                                        snapMode: ListView.SnapToItem
                                        highlightRangeMode: ListView.StrictlyEnforceRange
                                        preferredHighlightBegin: height / 3
                                        preferredHighlightEnd: (height / 3) * 2
                                    }
                                    delegate: Text
                                    {
                                        text: modelData
                                        color: index === minutes.currentIndex ? "white" : "gray"
                                        font.pixelSize:12
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter

                                    }
                                }
                                Tumbler
                                {
                                    // Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    id: timePeriod
                                    Layout.preferredWidth: 40
                                    Layout.preferredHeight:70
                                    model: ["AM", "PM"]
                                    visible: !timeVary.checked
                                    wheelEnabled: true
                                    visibleItemCount: 2
                                    contentItem: ListView
                                    {
                                        anchors.fill: parent
                                        model: timePeriod.model
                                        delegate: timePeriod.delegate
                                        interactive: true
                                        snapMode: ListView.SnapToItem
                                        highlightRangeMode: ListView.StrictlyEnforceRange
                                        preferredHighlightBegin: 17
                                        preferredHighlightEnd: 34
                                    }
                                    delegate: Text
                                    {
                                        text: modelData
                                        color: index === timePeriod.currentIndex ? "white" : "gray"
                                        font.pixelSize:12
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter


                                    }

                                }
                            }



                            // Text
                            // {

                            //     text: "TEST"
                            //     color: "white"
                            // }
                            // Popup
                            // {
                            //     id: time
                            //     focus: true             // Captures keyboard focus
                            //     modal: true         // Blocks mouse clicks in the background
                            //     closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                            //     x: ((parent.width - width) / 2)
                            //     y: (parent.height - height) / 2
                            //     z: 100
                            //     width: parent.width * 0.25
                            //     height: parent.height * 0.50
                            //     background: Rectangle
                            //     {
                            //         color: "transparent"
                            //         radius: 5
                            //     }
                            //     contentItem:Item
                            //     {
                            //         anchors.fill: parent
                            //         RowLayout
                            //         {
                            //             anchors.centerIn: parent



                            //             Tumbler
                            //             {
                            //                 // Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            //                 id: hour
                            //                 Layout.preferredWidth: 12
                            //                 Layout.preferredHeight:60
                            //                 model: 13

                            //             }
                            //             Text
                            //             {
                            //                 text: ":"
                            //                 color: "white"
                            //             }
                            //             Tumbler
                            //             {
                            //                 // Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            //                 id: minutes
                            //                 Layout.preferredWidth: 12
                            //                 Layout.preferredHeight:60
                            //                 model: 60

                            //             }
                            //             Tumbler
                            //             {
                            //                 // Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            //                 id: timePeriod
                            //                 Layout.preferredWidth: 20
                            //                 Layout.preferredHeight:60
                            //                 model: ["AM", "PM"]

                            //             }
                            //         }
                            //     }
                            // }
                            // TapHandler
                            // {
                            //     onTapped:
                            //     {
                            //         time.open()
                            //     }
                            // }

                            // RowLayout
                            // {
                            //     anchors.centerIn: parent
                            //     Tumbler
                            //     {
                            //         id: simpleTumbler
                            //         Layout.preferredWidth: 15
                            //         Layout.preferredHeight: 100
                            //         model: 10
                            //     }
                            //     Text
                            //     {
                            //         text: ":"
                            //         color: "white"
                            //     }
                            //     Tumbler
                            //     {
                            //         id: as
                            //         Layout.preferredWidth: 15
                            //         Layout.preferredHeight: 100
                            //         model: 10
                            //     }
                            // }

                        }
                        Rectangle
                        {
                            Layout.fillWidth: true
                            color: "yellow"
                            Layout.fillHeight: true
                            radius: 5
                        }
                        Rectangle
                        {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "black"
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

