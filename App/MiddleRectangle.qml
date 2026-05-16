import QtQuick
import QtQuick.Layouts

Rectangle
{
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: "transparent"

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 12
        // Column 2

        Text
        {
            text: "Class Title"
            font.pixelSize: 30
            font.bold: true
            color: "white"
            Layout.alignment: Qt.AlignHCenter // Centers the text in the column
        }

        Rectangle
        {
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            color: "#16213e"
            radius: 8

            Text
            {
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

            Text
            {
                anchors.centerIn: parent
                text: "Column 2"
                color: "white"
                font.pixelSize: 16
            }
        }
    }
}
