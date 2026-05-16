import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
// Column 1


Rectangle
{
    Layout.preferredWidth: 300
    Layout.fillHeight: true
    radius: 8

    //Circle

    color: "#80252323"
    border.color: "white"

    Flickable
    {
        anchors.fill: parent
        contentHeight: heightLimit.height + 40  // Needs to be larger than window height to scroll
        clip: true


        ColumnLayout
        {
            id: heightLimit
            spacing: 12
            width: parent.width
            Repeater
            {
                model: ListModel
                {
                    id: storePages
                }
                // This starts empty
                delegate: Rectangle
                {
                    width: 300
                    height: 80
                    color: "#1a1a2e"
                    border.color: "white"
                    radius: 8
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text
                    {
                        anchors.centerIn: parent
                        text: "yay" // Uses the title we appended above
                        color: "white"
                    }
                }
            }

            Rectangle
            {
                color: addingPage.pressed ? "#20ffffff" : "white"
                scale: addingPage.pressed ? 0.9 : 1.0
                border.color: addingPage.pressed ? "green": "white"

                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignCenter

                radius: width / 2
                Shape
                {
                    // anchors.fill: parent
                    antialiasing: true

                    ShapePath
                    {
                        strokeColor: "gray"
                        strokeWidth: 4
                        fillColor: "transparent"
                        capStyle: ShapePath.RoundCap // Makes the ends round instead of square
                        startX: 25; startY: 5
                        PathLine { x:25 ; y:45}
                        PathMove { x:5 ; y:25}
                        PathLine { x:45 ; y:25}
                    }
                }
                MouseArea
                {
                    id: addingPage
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor


                    // Sending action to Python
                    onClicked:
                    {
                        storePages.append({ "title": "Assignment " + (storePages.count + 1) })
                        f.addPage()// Calling Python Slot
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
}



