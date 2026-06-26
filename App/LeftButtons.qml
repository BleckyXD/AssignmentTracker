import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

//Adding Pages
ColumnLayout
{
    //Moving Left
    Rectangle
    {
        Layout.preferredWidth: 50
        Layout.preferredHeight: 50

        radius: width / 2

        color: leftPage.pressed ? "#20ffffff" : "white"
        scale: leftPage.pressed ? 0.9 : 1.0
        border.color: leftPage.pressed ? "green": "white"
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
                startX: 30; startY: 10
                PathLine { x:15 ; y:25 }
                PathLine { x:30 ; y:40 }
                // PathLine { x:40 ; y:15 }

            }
        }
        MouseArea
        {
            id: leftPage
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            // Sending action to Python
            onClicked:
            {
                if (view.currentIndex > 0)
                {
                    view.currentIndex--
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

}

