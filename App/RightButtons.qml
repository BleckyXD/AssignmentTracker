import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

Rectangle
{
    Layout.preferredWidth: 50
    Layout.fillHeight: true
    color: "transparent"
    ColumnLayout
    {

        Layout.fillHeight: true
        anchors.fill: parent
        Rectangle
        {
            id: creatorButton
            Layout.alignment: Qt.AlignTop
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
        Rectangle
        {

            id: pageLeftButton
            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            border.width: 1
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
                onClicked: {
                    // We target the PIXELS, not the INDEX.
                    // This moves the view 1 full screen width to the right.
                    template.contentX += template.width
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

}


