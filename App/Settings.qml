import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Shapes



Rectangle
{
    anchors.fill: parent
    Layout.fillHeight: true
    Layout.fillWidth: true
    color: "black"


    RowLayout
    {
        anchors.fill: parent
        spacing: 10

        Rectangle
        {
            Layout.fillHeight: true
            width: mainWindow.width * 0.20
            color: "grey"

            ColumnLayout
            {
                anchors.fill: parent
                anchors.margins: 2

                AbstractButton
                {
                    Layout.fillWidth: true
                    height: 50
                    background: Rectangle
                    {
                        radius: 15
                        color: "black"
                    }
                    Text
                    {
                        text: "Themes"
                        color: "white"
                        anchors.centerIn: parent
                    }
                    onPressed:
                    {
                        loadSettingOption.source = "settingsLoad/ThemeManagement.qml";
                    }
                }


                AbstractButton
                {
                    Layout.fillWidth: true
                    height: 50
                    background: Rectangle
                    {
                        radius: 15
                        color: "black"
                    }
                    Text
                    {
                        text: "Data Analysis"
                        color: "white"
                        anchors.centerIn: parent
                    }
                    onPressed:
                    {
                        loadSettingOption.source = "settingsLoad/Setting2.qml";
                    }
                }
                AbstractButton
                {
                    Layout.fillWidth: true
                    height: 50
                    background: Rectangle
                    {
                        radius: 15
                        color: "black"
                    }
                    Text
                    {
                        text: "Profile"
                        color: "white"
                        anchors.centerIn: parent
                    }
                    onPressed:
                    {
                        loadSettingOption.source = "settingsLoad/Setting3.qml";
                    }
                }
                AbstractButton
                {
                    Layout.fillWidth: true
                    height: 50
                    background: Rectangle
                    {
                        radius: 15
                        color: "black"
                    }
                    Text
                    {
                        text: "Data Structure"
                        color: "white"
                        anchors.centerIn: parent
                    }
                    onPressed:
                    {
                        loadSettingOption.source = "settingsLoad/Setting4.qml";
                    }
                }
                AbstractButton
                {
                    Layout.fillWidth: true
                    height: 50
                    background: Rectangle
                    {
                        radius: 15
                        color: "black"
                    }
                    Text
                    {
                        text: "Manage Pages"
                        color: "white"
                        anchors.centerIn: parent
                    }
                    onPressed:
                    {
                        loadSettingOption.source = "settingsLoad/Setting5.qml";
                    }
                }
                AbstractButton
                {
                    Layout.fillWidth: true
                    height: 50
                    background: Rectangle
                    {
                        radius: 15
                        color: "white"
                    }
                    onPressed:
                    {
                        settingsLoader.source = ""
                    }
                    Text
                    {
                        text: "Close Settings"
                        color: "black"
                        anchors.centerIn: parent
                    }
                }
                // Item
                // {
                //     height: 200
                // }
            }
        }
        ColumnLayout
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Rectangle
            {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "grey"


                Loader
                {
                    id: loadSettingOption
                    anchors.fill: parent
                }

            }
        }
    }
}




