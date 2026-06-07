import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls
import App

Rectangle
{
    id: leftRectangle
    Layout.fillWidth: true
    Layout.fillHeight: true
    radius: 8



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

            //Container for the different assignments
            Flow
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 5

                Repeater
                {
                    model: rectModel

                    // Created pages (found in an external file)
                    delegate: PageAdded
                    {

                    }
                }

                // 3. The Data Storage
                ListModel
                {
                    id: rectModel
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

                TapHandler
                {
                    id: addingPage
                    cursorShape: Qt.PointingHandCursor
                    onTapped: rectModel.append({"pageId": Date.now().toString()})
                }
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
                id: saveData
                function saveAssignments()
                {
                    var assignmentData = []

                    for (var i = 0; i < rectModel.count; i++)
                    {
                        assignmentData.push({"page_id": rectModel.get(i).pageId,
                                             "info": rectModel.get(i).info})
                    }

                    f.saveData(assignmentData)
                }

                color: savePage.pressed ? "#20ffffff" : "white"
                scale: savePage.pressed ? 0.9 : 1.0
                border.color: savePage.pressed ? "green": "white"
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignCenter
                radius: width / 2

                TapHandler
                {
                    id: savePage
                    cursorShape: Qt.PointingHandCursor
                    onTapped: saveData.saveAssignments()

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

