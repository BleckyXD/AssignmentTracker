import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Shapes


ApplicationWindow
{

    id: mainWindow
    visible: true
    width: 1024
    height: 600
    title: "My Qt Quick App"
    // StackView {
    //         id: pageStack
    //         anchors.fill: parent

    //         // This is the starting page when the app opens
    //         initialItem: homePage
    //     }

    //     // 2. COMPONENT FOR PAGE 1: HOME PAGE
    //     Component {
    //         id: homePage

    //         Rectangle {
    //             color: "#1a1a2e"

    //             ColumnLayout {
    //                 anchors.centerIn: parent
    //                 spacing: 20

    //                 Text {
    //                     text: "Home Screen"
    //                     color: "white"
    //                     font.pixelSize: 24
    //                     Layout.alignment: Qt.AlignHCenter
    //                 }

    //                 Button {
    //                     text: "Go to Details"
    //                     Layout.preferredWidth: 200
    //                     Layout.preferredHeight: 45

    //                     // COMMAND: Push the details screen onto the stack
    //                     onClicked: pageStack.push(detailsPage)
    //                 }
    //             }
    //         }
    //     }

    //     // 3. COMPONENT FOR PAGE 2: DETAILS PAGE
    //     Component {
    //         id: detailsPage

    //         Rectangle {
    //             color: "#16213e" // Different background color so you can see the change

    //             ColumnLayout {
    //                 anchors.centerIn: parent
    //                 spacing: 20

    //                 Text {
    //                     text: "Details Screen"
    //                     color: "white"
    //                     font.pixelSize: 24
    //                     Layout.alignment: Qt.AlignHCenter
    //                 }

    //                 Button {
    //                     text: "Back to Home"
    //                     Layout.preferredWidth: 200
    //                     Layout.preferredHeight: 45

    //                     // COMMAND: Remove this screen and slide back down to Home
    //                     onClicked: pageStack.push(detailsPage)
    //                 }
    //             }
    //         }
    //     }

    RowLayout
    {
        id: classTemplate
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

         //Circle
        Rectangle
        {
            Layout.preferredWidth: 50
            Layout.preferredHeight: 50

            radius: width / 2

            color: leftPage.pressed ? "#20ffffff" : "white"
            scale: leftPage.pressed ? 0.9 : 1.0
            border.color: leftPage.pressed ? "green": "white"
            Shape
            {
                anchors.fill: parent
                antialiasing: true

                ShapePath
                {
                    strokeColor: "gray"
                    strokeWidth: 4
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap // Makes the ends round instead of square
                    joinStyle: ShapePath.RoundJoin // Smoothes the "V" joint
                    startX: 30; startY: 10
                    PathLine { x:15 ; y:25 }
                    PathLine { x:30 ; y:40 }
                    // PathLine { x:40 ; y:15 }

                }
            }
            MouseArea
            {
                id: leftPage
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                // Sending action to Python
                onClicked: f.leftChangePage()// Calling Python Slot
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

        LeftRectangle
        {

        }

        MiddleRectangle
        {

        }

        RightRectangle
        {

        }
    }
}






























// delegate: Rectangle
// {
//     color: assignmentDetails.pressed ? "#20ffffff" : "#1a1a2e"
//     scale: assignmentDetails.pressed ? 0.9 : 1.0
//     border.color: assignmentDetails.pressed ? "#20ffffff" : "white"
//     width: 300
//     height: 80
//     radius: 8
//     anchors.horizontalCenter: parent.horizontalCenter

//     Text
//     {
//         anchors.centerIn: parent
//         color: "white"
//     }
//     MouseArea
//     {
//         id: assignmentDetails
//         anchors.fill: parent
//         cursorShape: Qt.PointingHandCursor

//         onClicked:
//         {
//             f.openDetails()
//             assignmentPopup.open()
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
