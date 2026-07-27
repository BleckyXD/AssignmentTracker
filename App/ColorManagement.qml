import QtQuick 2.15

Item
{

    // These properties hold the live colors used by your ENTIRE app
    // property color MP3buttonsSlider: "black"
    // property color sidebarBg: "#808080"
    // property color accentColor: "#0000ff"
    // property color buttonText: "#ffffff"

    property var choiceOfColors: f.sendingColors

    property color backgroundRectangleMain: choiceOfColors["General Background"]
    property color mainBackground: choiceOfColors["Main Background"]


    property color borderColor: choiceOfColors["Border Color"]
    property color rectangleInfoColor: choiceOfColors["Rectangle Info"]

    property color buttons: choiceOfColors["Buttons"]

    property color textAreaPart: choiceOfColors["Writing Text Areas"]

    property color clockColor: choiceOfColors["Clock"]


    property color mp3Color: choiceOfColors["MP3 Colors"]

    property string iconFolder: choiceOfColors["Icon Folder"]

    property color backgroundRectangleSecondary: choiceOfColors["Secondary Background"]
    FontLoader
    {
        id:receivedFont
        source: `Fonts/${choiceOfColors["Font"]}`
    }

    property string font: receivedFont.name
    property color titleFont: choiceOfColors["Title Font"]
    property color infoFont: choiceOfColors["Info Font"]

}


