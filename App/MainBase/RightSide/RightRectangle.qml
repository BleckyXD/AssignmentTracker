import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls

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
                text: "Column 3"
                color: "white"
                font.pixelSize: 16
            }
        }

        //Circle
        Item
        {
            Layout.fillHeight: true
        }
    }
}
