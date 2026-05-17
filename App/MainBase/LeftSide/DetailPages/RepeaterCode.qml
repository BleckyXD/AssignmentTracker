import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls

// Rectangle
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
//         text: "yay" // Uses the title we appended above
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
// Rectangle
// {
//     color: addingPage.pressed ? "#20ffffff" : "white"
//     scale: addingPage.pressed ? 0.9 : 1.0
//     border.color: addingPage.pressed ? "green": "white"

//     Layout.preferredWidth: 50
//     Layout.preferredHeight: 50
//     Layout.alignment: Qt.AlignCenter

//     radius: width / 2
//     Shape
//     {
//         anchors.fill: parent
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
//     TapHandler
//     {
//         id: addingPage
//         onTapped: f.addPage()
//         cursorShape: Qt.PointingHandCursor
//     }
// }
