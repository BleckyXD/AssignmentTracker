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

    SwipeView {
        id: view

        currentIndex: 0
        anchors.fill: parent


        Repeater
        {
            model: generalPages
            delegate:Component
            {
                id: wholeTemplate

                RowLayout
                {
                    id: classTemplate
                    width: view.width
                    height: view.height

                    LeftButtons
                    {

                    }
                     //Circle
                    LeftRectangle
                    {

                    }
                    MiddleRectangle
                    {

                    }
                    RightRectangle
                    {

                    }
                    RightButtons
                    {

                    }

                }
            }
        }



    }
    ListModel
    {
        id: generalPages
    }
    //Once everything that is before is completed and loaded, this runs
    Component.onCompleted:
    {
        if (generalPages.count === 0)
        {
            var uniqueID = Date.now().toString()
            generalPages.append({})
            f.initializeData({uniqueID: {"Assignments": {}}})
        }
    }




    // ListModel
    // {
    //     id: templateData
    //     ListElement { pageTitle: "Assignment 1"; pageColor: "teal" }
    // }

    // Component
    // {
    //     id: completeUI
    //     RowLayout
    //     {
    //         id: classTemplate
    //         width: template.width
    //         height: template.height

    //         LeftButtons
    //         {

    //         }
    //          //Circle
    //         LeftRectangle
    //         {

    //         }
    //         MiddleRectangle
    //         {

    //         }
    //         RightRectangle
    //         {

    //         }
    //     }
    // }
    // ListView
    // {
    //     id: template
    //     model: templateData
    //     anchors.fill: parent

    //     // Correct Syntax:
    //     delegate: completeUI
    //     anchors.margins: 5

    //     orientation: ListView.Horizontal
    //     snapMode: ListView.SnapOneItem
    //     clip: true

    //     highlightRangeMode: ListView.ApplyRange

    //     preferredHighlightBegin: 0
    //     preferredHighlightEnd: width

    //     highlightMoveDuration: 150    // Lower = Faster (150ms is very snappy)
    //     highlightMoveVelocity: -1


    // }
}



























