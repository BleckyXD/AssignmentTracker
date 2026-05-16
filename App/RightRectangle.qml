import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
Rectangle
{
    Layout.preferredWidth: 150
    Layout.fillHeight: true
    color: "transparent"

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 12

        // Column 3
        Rectangle
        {
            Layout.preferredWidth: 150
            Layout.preferredHeight: 250
            color: "#0f3460"
            radius: 8

            Text
            {
                anchors.centerIn: parent
                text: "Column 3"
                color: "white"
                font.pixelSize: 16
            }
        }

        //Circle
        Rectangle
        {
            Layout.alignment: Qt.AlignRight

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
                onClicked: f.rightChangePage()// Calling Python Slot
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
    }
}
