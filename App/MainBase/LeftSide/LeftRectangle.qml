import QtQuick 6.0
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls
import App
import Qt5Compat.GraphicalEffects
Rectangle
{
    id: leftRectangle
    Layout.fillWidth: true
    Layout.fillHeight: true
    radius: 8



    color: globalTheme.backgroundRectangleMain
    border.color: globalTheme.borderColor
    border.width: 3

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
            // Rectangle
            // {
            //     id: saveData
            //     function saveAssignmentsJSON()
            //     {
            //         var assignmentData = {}

            //             var i = rectModel.count - 1
            //             var currentItem = rectModel.get(i)
            //             var key = Math.floor(currentItem.assignmentIndex).toString()
            //             assignmentData[key] = {"title": currentItem.title,
            //                                    "status": currentItem.status,
            //                                    "time": currentItem.time}



            //         f.saveAssignmentData(assignmentData)
            //     }
            //     color: addingPage.pressed ? "#20ffffff" : globalTheme.buttons
            //     scale: addingPage.pressed ? 0.9 : 1.0
            //     border.color: addingPage.pressed ? "green": globalTheme.borderColor
            //     Layout.preferredWidth: 50
            //     Layout.preferredHeight: 50
            //     Layout.alignment: Qt.AlignCenter
            //     radius: width / 2

            //     TapHandler
            //     {
            //         // "pageId": Date.now().toString()
            //         id: addingPage
            //         cursorShape: Qt.PointingHandCursor
            //         onTapped:
            //         {
            //             rectModel.append({"title": "empty",
            //                               "assignmentIndex": rectModel.count,
            //                               "status": "",
            //                               "time": ""})

            //             saveData.saveAssignmentsJSON()
            //         }

            //     }
            //     Shape
            //     {
            //         // anchors.fill: parent
            //         antialiasing: true

            //         ShapePath
            //         {
            //             strokeColor: "gray"
            //             strokeWidth: 4
            //             fillColor: "transparent"
            //             capStyle: ShapePath.RoundCap // Makes the ends round instead of square
            //             startX: 25; startY: 5
            //             PathLine { x:25 ; y:45}
            //             PathMove { x:5 ; y:25}
            //             PathLine { x:45 ; y:25}
            //         }
            //     }
            //     Behavior on scale
            //     {
            //         NumberAnimation
            //         {
            //             duration: 100
            //             easing.type: Easing.OutBack // Adds a little "bounce" effect
            //         }
            //     }
            // }



            AbstractButton
            {
                id: saveData
                function saveAssignmentsJSON()
                {
                    var assignmentData = {}

                        var i = rectModel.count - 1
                        var currentItem = rectModel.get(i)
                        var key = Math.floor(currentItem.assignmentIndex).toString()
                        assignmentData[key] = {"title": currentItem.title,
                                               "status": currentItem.status,
                                               "time": currentItem.time}



                    f.saveAssignmentData(assignmentData)
                }
                scale: saveData.down ? 0.8 : (saveData.hovered ? 1.0 : 0.9)
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignCenter
                icon.source: `../../iconTemplates/${globalTheme.iconFolder}/AddIcon`
                hoverEnabled: true
                background: Rectangle
                {

                    color:saveData.down ? Qt.lighter(globalTheme.buttons, 0.5) : (saveData.hovered ? Qt.lighter(globalTheme.buttons, 1.5) : globalTheme.buttons)
                    //border.color: saveData.down ? "black" : (saveData.hovered ? "white" : globalTheme.borderColor)
                    radius: width / 2
                    Image
                    {

                        source: saveData.icon.source
                        sourceSize.width: saveData.width
                        sourceSize.height: saveData.height
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

                onClicked:
                {
                    // "pageId": Date.now().toString()
                    rectModel.append({"title": "empty",
                                      "assignmentIndex": rectModel.count,
                                      "status": "",
                                      "time": ""})

                    saveData.saveAssignmentsJSON()


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

