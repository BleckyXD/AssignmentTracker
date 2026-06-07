import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls



Rectangle
{
    id: mainLeftRectangle
    width: leftRectangle.width
    height: 80
    color: assignmentDetails.pressed ? "#401a1a2e" : "#1a1a2e"
    scale: assignmentDetails.pressed ? 0.9 : 1.0
    border.color: assignmentDetails.pressed ? "#80ffffff" : "white"

    radius: 3
    Text
    {
        anchors.centerIn: parent
        id: assignmentTitle
        text: titleInput.text
        color:"white"
    }

    NumberAnimation
    {
            id: appearanceAnim
            target: mainLeftRectangle
            property: "scale"
            from: 0
            to: 1.0
            duration: 300
            easing.type: Easing.OutBack // Gives it a nice slight "bounce" at the end
    }
    Component.onCompleted: appearanceAnim.start()
    TapHandler
    {
        id: assignmentDetails
        onTapped: detailPopup.open()
    }

    //Details for assignments
    Popup
    {
        id: detailPopup
        parent: Overlay.overlay
        x: ((mainWindow.width - width) / 2)
        y: (mainWindow.height - height) / 2
        width: mainWindow.width * 0.95  // Always takes up exactly 35% of the window width
        height: mainWindow.height * 0.80
        modal: true             // Dims the background
        focus: true             // Captures keyboard focus
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        padding: 25


        background: Rectangle
        {
            id: popupBackground
            color: "#1a1a2e"
            border.color: "#40ffffff"
            border.width: 1
            radius: 16
            TapHandler
            {
                onTapped: popupBackground.forceActiveFocus()
            }
        }

        contentItem: ColumnLayout
        {

            TextField
            {
                id: titleInput
                text: rectModel.info
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 228
                placeholderText: "Enter assignment title..."
                color: "black"
                maximumLength: 35
                horizontalAlignment: TextInput.AlignHCenter
                onAccepted:
                {
                    // Steal focus away from this text field and give it to the popup root
                    popupBackground.forceActiveFocus()
                }

                background: Rectangle
                {

                    color: "gray"
                    border.color: "dark green"
                    radius: 8
                }
                onTextEdited:
                {
                    rectModel.setProperty(index, "info", text)
                }
            }
            Item
            {
                Layout.fillHeight: true
            }
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

