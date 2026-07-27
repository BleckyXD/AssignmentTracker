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
    color: globalTheme.mainBackground

    ColorManagement { id: globalTheme }
    StackView
    {
        id: generalController
        anchors.fill: parent
        initialItem: view
    }


    SwipeView
    {
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
                    // RightButtons
                    // {

                    // }

                }
            }
        }
        onCurrentIndexChanged:
        {
            f.retrieveIndex(view.currentIndex)
        }
    }
    Loader
    {
        id: settingsLoader
        anchors.fill: parent
        // It starts completely empty ("Null" status)
    }

    ListModel
    {
        id: generalPages
    }
    //Once everything that is before is completed and loaded, this runs
    Component.onCompleted:
    {
        f.startClockTimer()

        if (generalPages.count === 0)
        {
            // var uniqueID = Date.now().toString()
            generalPages.append({})
            f.retrieveIndex(view.currentIndex)
            f.newPage(1)
            // f.initializeData("1")
        }

    }





}



























