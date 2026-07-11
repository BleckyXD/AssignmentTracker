import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects
Rectangle
{
    // Layout.fillWidth: true
    // Layout.fillHeight: true
    color: "transparent"
    Layout.fillHeight: true
    Layout.preferredWidth: mainWindow.width / 3

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 12

        TextField
        {
            id: classTitle
            background:
            {
                Rectangle
                {
                    color: "transparent"
                }
            }

            text: "Class Title"
            font.pixelSize: 30
            font.bold: true
            color: "white"
            Layout.alignment: Qt.AlignHCenter // Centers the text in the column
            onActiveFocusChanged:
            {
                if (!activeFocus)
                {
                    // f.title({"pageId": Date.now().toString(),
                    //          "class_title":classTitle.text})
                    f.title(classTitle.text)
                }

            }
            onAccepted:
            {
                focus = false
                mainWindow.forceActiveFocus()
            }

        }

        Rectangle
        {
            id: middleBase
            Layout.fillWidth: true
            Layout.preferredHeight: 250
            color: globalTheme.backgroundRectangleMain
            border.color: globalTheme.borderColor
            border.width: 3
            radius: 8

            ColumnLayout
            {

                anchors.fill: parent
                Text
                {
                    text: "Class Details"
                    color: "white"
                    font.pixelSize: 25
                    Layout.leftMargin: 4
                }
                TextArea
                {
                    Layout.leftMargin: 20
                    Layout.rightMargin: 10
                    Layout.bottomMargin: 8

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: ""
                    placeholderText: "Enter Class Details..."
                    color: "black"
                    wrapMode: TextArea.Wrap


                    background: Rectangle
                    {

                        color: globalTheme.rectangleInfoColor
                        border.color: globalTheme.borderColor
                        radius: 8
                    }
                    onTextEdited:
                    {
                        f.classDetails(text)

                    }
                }

            }


        }
        Rectangle
        {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: globalTheme.backgroundRectangleMain
            border.width: 3
            radius: 8

            ColumnLayout
            {
                anchors.leftMargin: 2
                anchors.rightMargin: 8
                anchors.bottomMargin: 5

                anchors.fill: parent
                RowLayout
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Text
                    {
                        text: "To Do List"
                        color: "white"
                        font.pixelSize: 25
                    }
                    AbstractButton
                    {
                        id: addToDo
                        Layout.preferredHeight: 25
                        Layout.preferredWidth: 25
                        icon.source: `../../iconTemplates/${globalTheme.iconFolder}/AddIcon`

                        background: Rectangle
                        {
                            color: "transparent"
                            radius: width / 2
                            Image
                            {
                                // id: rightArrowIcon
                                source: addToDo.icon.source
                                sourceSize.width: addToDo.width
                                sourceSize.height: addToDo.height
                                anchors.centerIn: parent
                                fillMode: Image.PreserveAspectFit


                            }
                            ColorOverlay
                            {
                                anchors.fill: addToDo
                                source: addToDo

                                color: addToDo.down ? "green" : globalTheme.borderColor
                            }
                        }
                        onClicked:
                        {
                            todoModel.append({"todoInfo": "",
                                              "todoIndex": todoModel.count})

                            // f.classTodoList()
                            var todoData = {}

                            var i = todoModel.count - 1
                            var currentItem = todoModel.get(i)
                            var key = Math.floor(currentItem.todoIndex).toString()
                            todoData[key] = {"todoInfo": currentItem.todoInfo}

                            f.classTodoList(todoData)

                        }
                    }
                }
                Rectangle
                {
                    Layout.leftMargin: 20
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 8


                    color: "transparent"
                    border.color: globalTheme.borderColor
                    border.width: 3

                    Flickable
                    {
                        anchors.margins: 6
                        anchors.fill: parent
                        contentHeight: todoHeightLimit.height + 10  // Needs to be larger than window height to scroll
                        clip: true
                        ColumnLayout
                        {
                            id: todoHeightLimit
                            spacing: 12
                            width: parent.width
                            Flow
                            {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                spacing: 5

                                Repeater
                                {
                                    model: todoModel

                                    // Created pages (found in an external file)
                                    delegate: TextArea
                                    {
                                        id: todoSelected
                                        width: todoHeightLimit.width
                                        placeholderText: "Enter Task..."
                                        color: "black"
                                        wrapMode: TextArea.Wrap

                                        background: Rectangle
                                        {
                                            color: globalTheme.rectangleInfoColor
                                            border.color: "white"
                                            radius: 8
                                        }
                                        onTextEdited:
                                        {
                                            f.specificTodoList(todoSelected.text, model.todoIndex)
                                        }
                                    }
                                }

                                // 3. The Data Storage
                                ListModel
                                {
                                    id: todoModel
                                }
                            }
                        }
                    }
                }




                // TextArea
                // {
                //     Layout.leftMargin: 20
                //     Layout.fillHeight: true
                //     Layout.fillWidth: true
                //     text: ""
                //     placeholderText: "Enter Task..."
                //     color: "black"
                //     wrapMode: TextArea.Wrap


                //     background: Rectangle
                //     {
                //         color: "gray"
                //         border.color: "dark green"
                //         radius: 8
                //     }
                //     onTextEdited:
                //     {


                //     }
                // }
                // TextArea
                // {
                //     Layout.leftMargin: 20
                //     Layout.fillHeight: true
                //     Layout.fillWidth: true
                //     text: ""
                //     placeholderText: "Enter Task..."
                //     color: "black"
                //     wrapMode: TextArea.Wrap


                //     background: Rectangle
                //     {
                //         color: "gray"
                //         border.color: "dark green"
                //         radius: 8
                //     }
                //     onTextEdited:
                //     {


                //     }
                // }
                // TextArea
                // {
                //     Layout.leftMargin: 20
                //     Layout.fillHeight: true
                //     Layout.fillWidth: true
                //     text: ""
                //     placeholderText: "Enter Task..."
                //     color: "black"
                //     wrapMode: TextArea.Wrap


                //     background: Rectangle
                //     {
                //         color: "gray"
                //         border.color: "dark green"
                //         radius: 8
                //     }
                //     onTextEdited:
                //     {


                //     }
                // }
                // TextArea
                // {
                //     Layout.leftMargin: 20
                //     Layout.fillHeight: true
                //     Layout.fillWidth: true
                //     text: ""
                //     placeholderText: "Enter Task..."
                //     color: "black"
                //     wrapMode: TextArea.Wrap


                //     background: Rectangle
                //     {
                //         color: "gray"
                //         border.color: "dark green"
                //         radius: 8
                //     }
                //     onTextEdited:
                //     {


                //     }
                // }
                // TextArea
                // {
                //     Layout.leftMargin: 20
                //     Layout.fillHeight: true
                //     Layout.fillWidth: true
                //     text: ""
                //     placeholderText: "Enter Task..."
                //     color: "black"
                //     wrapMode: TextArea.Wrap


                //     background: Rectangle
                //     {
                //         color: "gray"
                //         border.color: "dark green"
                //         radius: 8
                //     }
                //     onTextEdited:
                //     {


                //     }
                // }
            }


        }
        PageIndicator {
            id: control
            count: view.count          // Total number of assignment categories
            currentIndex:view.currentIndex   // Start at the first one

            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
