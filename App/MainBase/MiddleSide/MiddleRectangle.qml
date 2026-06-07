import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

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
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            color: "#16213e"
            radius: 8

            TextArea
            {
                background:
                {
                    Rectangle
                    {
                        color: "transparent"
                    }
                }
                anchors.centerIn: parent
                text: "Column 2"
                color: "white"
                font.pixelSize: 16
            }
        }
        Rectangle
        {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#16213e"
            radius: 8

            TextArea
            {
                background:
                {
                    Rectangle
                    {
                        color: "transparent"
                    }
                }
                anchors.centerIn: parent
                text: "Column 2"
                color: "white"
                font.pixelSize: 16
            }
        }
        // TabBar {
        //     id: tabBar
        //     currentIndex: view.currentIndex

        //     TabButton
        //     {
        //         text: "Page 1"
        //     }
        //     TabButton
        //     {
        //         text: "Page 2"
        //     }
        //     TabButton
        //     {
        //         text: "Page 3"
        //     }
        // }
    }
}
