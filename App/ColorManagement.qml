import QtQuick 2.15

Item
{

    // These properties hold the live colors used by your ENTIRE app
    // property color MP3buttonsSlider: "black"
    // property color sidebarBg: "#808080"
    // property color accentColor: "#0000ff"
    // property color buttonText: "#ffffff"

    property var choiceOfColors: f.sendingColors

    property color backgroundRectangleMain: choiceOfColors["Main Background"]
    property color backgroundRectangleSecondary: choiceOfColors["Secondary Background"]
    property color borderColor: choiceOfColors["Border Color"]
    property color rectangleInfoColor: choiceOfColors["Info Rectangle"]
    // property color movingPagesButton: choiceOfColors["Change Page Buttons"]
    // property color creationButtons: choiceOfColors["Create Pages Button"]

    property color buttons: choiceOfColors["Buttons"]

    property color textAreaPart: choiceOfColors["Writing Text Areas"]

    property color clockColor: choiceOfColors["Clock"]

    property color mp3Slider: choiceOfColors["MP3 Slider"]
    property color sliderBackground: choiceOfColors["MP3 Slider Background"]
    property color mp3Buttons: choiceOfColors["MP3 Buttons"]
}


