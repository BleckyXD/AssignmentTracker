# May 15, 2026
###     Creating the GUI

> For starters, we use three columns as a preview of the whole 
> App.

> Opened the qml file from the qt creator, so it is easier to work with. 
> This way, python is used for the logic and the qml is used for the 
> visual part.

> I am mostly using rectangles for declaring the base of how it will look like. 
> Inside these rectangles, there will be layouts for separating the information 
> I want to control in the future.

> So, now I made one of the arrow icons be a button, which lets me also add some 
> type of "animation", since it is only changing its own color when pressed. Next
> step will consist in working on the logic for adding a page that has its own settings
> and that it can edit. This will require another qml module.

> I managed to add a scroll area for the left side. This way, multiple pages will be
> able to be stored. Now, a plus button will be at the button.

> The plus button now adds a new page everytime that it is pressed. Now, next step will 
> follow the creation of a main page that is displayed when no class is added, and then 
> make the created pages clickable. I will also need to add another plus sign for adding 
> the main pages, which are created for each class that you have.
---
# May 16, 2026
### GUI improvements && Logic

> Right now I am working on making a pop-up screen for the pages that will contain the 
> information related to the assignment of the class. Before doing this, I will work first
> on making the rectangles clickable, since that is where the pop-up will go.

> I will also need to reorganize the files.

> The rectangles for the detail pages are now clickable. Before going any further, I will move on
> to organize the files in different folders.

> Had a hard time trying to run the program with the new file division in folders. It is now working
> correctly, since I have not grasped yet how to send a signal from one qml to another. I was trying
> to call the repeater of the pages from an external file.


> Pages that are created now have the pop screen appear. Next step is to include the fields for entering
> data inside it. For now, it will only have example fields, not final ones.

> While editting the popup, I encountered an issue. All the assignment screens that are created are
> exactly the same. I must find a way to make then individual.
---
# May 17, 2026
## Main focus on the information rectangle

> The use of a list was discarded, since it demonstrated issues with the repeated rectangles. I tried to 
> use the stacks, but these are more suited for a future function of the program. The main focus is on 
> fixing the left rectangle and letting the pages be repeated correctly.

> The issue is almost resolved by something simpler. A button that creates the rectangle appends it to a 
> list model. Now, each rectangle is its own separate rectangle. Next step is to slowly code it with the 
> correct shape and the small details related to color and actions.

> Solution is working correctly, now the implementation should follow. Each page is unique with its own contents.

> The list now works correctly. Now I am working with fixing the popup. It appears, but it changes position depending
> on which tab I opened. 

> The popup now appears in the top layer correctly.

> The left side has been completed and how each block is placed correctly, having their own internal areas for writing.
---
# May 18, 2026
## Working on titles and organization of files

> For starters, I moved the code for creating the rectangles to another file, this way it is easier to work with it.

> Latest change focuses on having the text field, that is inside the pop-up, set the title of the page.

> Now you can correctly set the title of the assignment from within the pop-up page. Before going any further on these 
> types of details, I am going to work on the logic of creating the pages for the classes. I will start testing with a 
> stack and see how it goes. For this, a new button will be required, for creating the pages.

> The logic for changing pages would go like:
> - The arrow button in qml is pressed
> - This sends the current page of the stack (+1) or (-1), depending on the side
> - The number is added to the python variable in the logic class
> - Then, the result is sent back to the qml 
> - The qml reads it and sets it as the new index, which changes the page
---
# May 19, 2026
## General pages travel

> For this day, the main focus is on creating pages and being able to traverse them, While they maintain their information.
> Today has been not a very progressive day, but I have made progress on the pages. I managed to figure out how to pass the
> from one page to another with the press of the button. I did not need to use python, and it was possible in the qml directly.
> From what I have done, it looks like python will not be used till we start working with the saving mechanism.

> It is proving to be more difficult, so I have moved on to checking out more of the documentation. It looks like that this
> will need a combination of ListView, Repeater, and Stacks.
---
# May 20, 2026
## Researching documentation

> So, the next step is moving on to investigating how to correctly combine the List View with a repeater and, possibly, Stacks.
> Here I will put the definitions and any explanation that may result useful.

### <ins>*List Model*

---

**Reference**: [List Model Documentation](https://doc.qt.io/qt-6/qml-qtqml-models-listmodel.html)

---

> A ListModel is a container of elements. The contents can be declared explicitly or dinamically.
> It has different commands for retrieving info:
> * count - Amount of elements
> * append() - Adds a new item to the end of the list model
>   * Example: `listModel.append({"cost": 5.95, "name":"Pizza"})`
>
> 
> * insert() - Adds a new item to the list model at an index position. The index must be to an existing item on the list. If its 
> past of the end of the list, then it will behave like an append().
>   * Example: `listModel.insert(2, {"cost": 5.95, "name":"Pizza"})`
> 
> 
> * move() - Can move an amount of items from one position to another. The from and to ranges must exist.
>   * Example: `listModel.move(0, fruitModel.count - 3, 3)`
>
> 
> * remove() - Deletes a number of items at a specific index from the model.
> 
>
> * set() - Changes the item at an index in the list model with the values in the dict. If the index is equal to the count, 
> then a new item is appended to the list. Otherwise, the index must be an element in the list.
>   * Example: `listModel.set(3, {"cost": 5.95, "name":"Pizza"})`

---
### <ins>*Repeater*

---

**Reference**: [Repeater Documentation](https://doc.qt.io/qt-6/qml-qtquick-repeater.html)

---

> A repeater may be used for creating a large number of similar items. It has a model and a delegate. For each entry in the 
> model, the delegate is instantiated with data from the model. A repeater is usually enclosed in a Row or Column, so the items 
> can be visually positioned.
> 
> Example:

    import QtQuick
    Row 
    {
        Repeater 
            model: 3
            Rectangle 
            {
                width: 100; height: 40
                border.width: 1
                color: "yellow"
            }
        }
    }
> 
> We can use a delegate for having a space for the whole code template that is inside the repeater. The repeater reacts to the model.
> If it is a hardcoded number, it will react that amount of times. If it is a list, it will react to everytime that the list receives
> a new entry, filled or empty. The repeater will fill the entry with its own template automatically.

---
### <ins>*Layouts*

---

**Reference**: [Layouts Documentation](https://doc.qt.io/qt-6/qtquicklayouts-overview.html)

---

> The intention of a Layout is to rearrange its children when the layout changes its size. In this following example, this
> is done by using: `anchors.fill: parent`.
> 
> Example snippet:

    Window 
    {
        RowLayout 
        {
            anchors.fill: parent
            spacing: 6
            Rectangle 
            {
                color: 'azure'
                Layout.preferredWidth: 100
                Layout.preferredHeight: 150
            }
            Rectangle 
            {
                color: "plum"
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

> Layouts that have no parent layout can have `anchors.fill: parent`. once a Layout component has the anchors.fill: parent, 
> its children must not have hardcoded dimensions or the same command.
> * Spacing: It ensures that an amount of pixels exists between the items of the layout. The default spacing is 5.
>
> Example: `spacing: 6` 
> 
> * Preferred size: It comes down to utilizing the following properties:
>   * Layout.preferredWidth or Layout.preferredHeight
>     * Properties modified by the application if the default size does not give an optimal arrangement.
>   * implicitWidth or implicitHeight
>     * Give an ideal size for displaying contents of an item.
>   
> * Size constraints: Since items can be resized, the layout must know the minimum, preferred, and maximum size that it can
> 
> 
> * reach when the Layout.fillWidth or Layout.fillHeight is set to _true_.
> 
> Example snippet:
> 
       RowLayout 
        {
            id: layout
            anchors.fill: parent
            spacing: 6
            Rectangle 
            {
                color: 'orange'
                Layout.fillWidth: true
                Layout.minimumWidth: 50
                Layout.preferredWidth: 100
                Layout.maximumWidth: 300
                Layout.minimumHeight: 150
                Text 
                {
                    anchors.centerIn: parent
                    text: parent.width + 'x' + parent.height
                }
            }
            Rectangle 
            {
                color: 'plum'
                Layout.fillWidth: true
                Layout.minimumWidth: 100
                Layout.preferredWidth: 200
                Layout.preferredHeight: 100
                Text 
                {
                    anchors.centerIn: parent
                    text: parent.width + 'x' + parent.height
                }
            }
        }

> * Connecting windows and layouts: Anchoring concepts can be used for ensuring that the general layout follows the window 
> resizing. We can ensure that the window is not resized the layout constraints.
> 
> Example snippet:
 
        minimumWidth: layout.Layout.minimumWidth
        minimumHeight: layout.Layout.minimumHeight
        maximumWidth: 1000
        maximumHeight: layout.Layout.maximumHeight

> Then, we set the window's size to the layout's implicit size:
   
    width: layout.implicitWidth
    height: layout.implicitHeight
---
### <ins>*StackLayout*

---

**Reference**: [StackLayout Documentation](https://doc.qt.io/qt-6/qml-qtquick-layouts-stacklayout.html)

---

> A good understanding of layouts is required for using this item efficiently. The current item in the stack can be
> modified by using the currentIndex property. The index will respond in the order that the items were added to the 
> stackLayout.
> 
> The child items will have the Layout.fillWidth and Layout.fillHeight defaulted to true. The child items
> will fill the space to match the StackLayout, as long as the Layout.maximumWidth or Layout.maximumHeight do not 
> prevent it. 
> 
> The items are added by reparenting the item to the new layout. 
> 
> Example snippet:
 
    StackLayout 
    {
        id: layout
        anchors.fill: parent
        currentIndex: 1
        Rectangle 
        {
            color: 'teal'
            implicitWidth: 200
            implicitHeight: 200
        }
        Rectangle 
        {
            color: 'plum'
            implicitWidth: 300
            implicitHeight: 200
        }
    }
> * count: Number of items that belong to the layout.
> 
> * currentIndex: Holds the index of the item that is visible at the moment.
> 
> * StackLayout.index: Holds the index for each item that is inside the layout.
> 
> * StackLayout.isCurrentItem: It becomes true if the specific child is the current item in the StackLayout.
> 
> * StackLayout.layout: Holds the StackLayout that manages the child item.

---

---

> A possible roadmap, which was implemented before is when combining the listModel and the Repeater. When declaring the 
> model of the repeater, we can set it to the ListModel instead of a specific number, which lets it grow. Everytime we 
> add an empty space in a ListModel, the repeater will fill it out with the General Template Page. When we create this 
> template, we can add it the StackLayout or StackView, depending on which one I will decide on using.

> While the StackLayout is easy to use, the StackView holds multiple properties that can be of use in the future for 
> building the application. The StackLayout is more limited and things like animations would need to be done manually when 
> the StackView has properties and functions for them.

---
# May 27, 2026
### <ins>*StackView*

---

**Reference**: [StackView Documentation](https://doc.qt.io/qt-6/qml-qtquick-controls-stackview.html)
https://www.geeksforgeeks.org/python/python-program-to-get-current-time/
---
> A Stack View can link information pages, having separate views that are pushes onto a stack. The following example
> shows how a page is pushed into the stack and then popped. 
>
> Example snippet:

       ApplicationWindow 
       {
            title: qsTr("Hello World")
            width: 640
            height: 480
            visible: true
        
            StackView 
            {
                id: stack
                initialItem: mainView
                anchors.fill: parent
            }
        
            Component 
            {
                id: mainView
        
                Row 
                {
                    spacing: 10
        
                    Button 
                    {
                        text: "Push"
                        onClicked: stack.push(mainView)
                    }
                    Button 
                    {
                        text: "Pop"
                        enabled: stack.depth > 1
                        onClicked: stack.pop()
        
                    }
                    Text 
                    {
                        text: stack.depth
                    }
                }
            }
        }

> * StackView: Declaration of the object we are using
> * Component: The part that we are storing inside the StackView
> * stack.push(mainView): Syntax for pushing a specific component onto the StackView
> * stack.pop(): Syntax for popping the current page out of the StackView.

#### Deep Linking
> Deep linking launches the application into a particular state. This can bypass the topmost item in the StackView.
> It is the ability of modifying the state of the stack. Let us say we have the stack [A, B, C]:
    
    push([D, E, F]) => [A, B, C, D, E, F] - "push" transition animation between C and F
    replace([D, E, F]) => [A, B, D, E, F] - "replace" transition animation between C and F
    clear() followed by push([D, E, F]) => [D, E, F] - no transition animation for pushing items as the stack was empty.

#### Finding Items
> By using the function `find()`, we can search an item inside the StackView. It needs a callback function, which is
> invoked with each item of the stack until it reaches the match.
> Example snippet:
    stackView.pop(stackView.find(function(item) 
    {
        return item.name == "order_id";
    }));
> 
> * The `StackView.find(function(item)` will search for the item name, return it, and compare it to the `order_id`. If 
> it matches, then it uses that name for the `stackView.pop` function and pops it.
> 
> You can also get an item with the function `get(index)`.
> Example snippet:
    previousItem = stackView.get(myItem.StackView.index - 1);

#### Transitions
> There are different transition animations that are applied when items enter or exit.
> Example snippet:
    StackView {
        id: stackview
        anchors.fill: parent
    
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }
    }
> * pushEnter: Syntax for the transition animation when entering
> * pushExit: Syntax for the transition animation when exiting
> * popEnter: Syntax for the transition animation when entering the pop
> * popExit: Syntax for the transition animation when exiting the pop

#### Item Ownership
> The StackView only takes ownership of the items that it creates. This means that, any item that is pushed onto the
> StackView will never be destroyed by the StackView. Only the items that the StackView creates from Components or URL's 
> can be destroyed by the StackView.

#### Property Documentation
> * `busy`: Holds whether a transition is running or not
> * `currentItem`: Holds the current top-most item in the stack
> * `depth`: Holds the number of the items that are currently pushed onto the stack
> * `empty`: Holds whether the stack is empty
> * `initialItem`: Holds the initial item that should be shown when the StackView is created
> * `popEnter`: Holds the transition that is applied to an item that enters the stack when another item is pooped off of it.
> * `popExit`: Holds the transition that is used with the item that exists the stack when the item is pooped off of it.
> * `pushEnter`: Holds the transition that is applied to the item that is entering the stack the item is pushed onto it.
> * `pushExit`: Holds the transition that is applied to the item that is exiting the stack the item is pushed onto it.
> * `replaceEnter`: Holds the transition that is applied to the item that is entering the stack when another item is 
> * replaced by it
> * `replaceExit`:Holds the transition that is applied to the item that is exiting the stack when another item is 
> * replaced by it

---
# END OF RESEARCH

---

> To continue with the progress of the project, my efforts have moved into working with a ListView and ListModel.

> The program is now capable of sliding in the testing.

> The main rectangles have been added to the component. Next step is testing if the screens will be created correctly.

> So, the list is done, pages can be created. The thing is, the buttons are not working correctly due to the list being 
> draggable. Next step is to fix this.

> The ListView is not looking promising since it deletes the pages that are in the background.

> A SwipeView may be the alternate solution to this.
  
> Example structure of data being saved:

    {
      "id": "2024-05-27-001",
      "index": 0,
      "title": "Math Homework",
      "description": "Pages 40-45",
      "color": "#ff5555",
      "isDone": false,
      "dateCreated": "2024-05-27T20:00:00Z"
    }
> Ok next changes will focus on:
> * Creating logic for a SwipeView, which may suffice my needs for the app
> * If first step goes well, then we move on to continuing the other visual details, like the clock

> For now this will be the main focus, later I will detail the next steps.


# June 6, 2026

## Transferring to SwipeView

> We will continue by changing into SwipeView, combined with a repeater and see how it goes.

> Right now, the SwipeView is a success! We are able to swipe between pages. Next step would be to connect the buttons,
> so you have multiple movement options.

> Now we can also see the pages being created. This appears at the bottom.

> In the future, a TabBar will be used for writing the titles of the pages and traversing them directly.

> I will now start working on how to store the data on a json file, ensuring a correct creation process.

> While it is still in REALLY early development, data has been managed to be saved, the ids to be specific. Next step
> is saving the information on those rectangles and then moving on to the other areas as well. 

> Saving data will be easier by using formulas and maintaining only the pertinent data on the rectangles, the data that
> does not survive when the app is closed. Any data related to how the app looks does not need to be stored.
 
> Before entering deeper into this work, I will first work on the middle section, since it has nothing written on it 
> and it needs text boxes, as well as a new smaller size.

> The middle and right section have been updated. Further updates will be done in the future. Main focus will be 
> towards the logic, specifically the saving and loading of data.

> A useful way of finding the data that is buried within the program is to include it in the ListModel. That way, it 
> is easier to access it.

> A detail to keep in mind, something I learned form my previous projects. When working with the json file, if you
> do not want the information to be erased, you must take it out of the json file into a list or dictionary. Then, 
> you will only edit the choice you made. When you are finished editing, you then write it again to the json file.

> We will need a basic structure of information, so here is the preview/idea:

    [
        Assignments:
        {
            "title": "",
            "info": ":Dasdasd",
            "page_id": "1780786512038"
        },
        {
            "info": ":D",
            "page_id": "1780786563307"
        }
    ]

> The data is now stored in a dictionary of lists, which contains even more dictionaries.

> Advancements have been made. The title and information of assignments has been successfully stored. The pages for the 
> assignments will have more details in the future, but for now, a simple text field will suffice.

> Right now, the decision is between having the json completely on python or part of it on QML. To be more precise, the 
> initialization of the json file could be on the QML, at least for each class that is added. This way we ensure that the
> user can add as many classes as they want. Validation is required for the names, in case they are repeated. 

> The best approach seems to be the initialization of the json file on QML and the editing is done on python. The space
> for the name of the class needs to be initialized as soon as a page is created, even the first one. This is while not 
> taking into consideration the loading option, which will be done further on. 
> Roadmap:

        Create page -> Initialize json with necessary info-> set up title (validation) -> repeat for new classes

# June 8, 2026
## Save Logic

> The idea is to basically create the space for the information, assign it the page number, and then, when editting the 
> information, we make sure that the actual page number aligns with the previously saved paged numbers.

> The saving logic is working correctly. Right now, the dictionary is created with every page creation and the title is
> saved and updated everytime that the user wants to.

> The saving logic has been correctly been applied to the assignment data.

> A small detail related to the `rectModel` is that it saves all the assignment pages together, without a page filter.
> This is more of an observation, since this is filtered in python. Since they are created in a specific page, while
> in the QML is not registered, it is registered on the python scrypt, where we can easily separate them.

> Now that the saving logic is working correctly, we just need to repeat it for the other areas, which it is expected
> to be much simpler. 
> For now, the main focus will be towards finishing the UI itself, since there are parts that are still missing. The 
> next step:
    
    - Give the missing text areas to the pop up, which will include for main sections at the left
        - Due date
        - Priority
        - Time for Completion
        - Alarm
    - Another area for the details of the assignment
    - We have to keep in mind that each line of info must be a different property that must be added to the rectModel.

> The interior of the popup has been completed. Next is making the small rectangles also popups, so they show options.

# June 9, 2026

## Details of looks

> The buttons let me traverse the different pages and the dropdown menus for the options in the popup are going well. 
> Right now, I will try to work on the popup for the right side, which will include:
        
    - MP3 Player
    - Settings
    - Color Scheme settings
    - Animated Clock / Time

> The popup works correctly, without any error. The options will be added later one. Right now, I will work on the
> assignment popup and connect each square to the save function.

> Well I found a bug in the popup of details. For the first page it works correctly, but for the other pages, the popup
> is not clickable.
> For now, the problem seems to be fixed. Will be checked in the future.

> The priority status save function has been completed, and it is stored correctly.

> # A file for general settings will be used when working with the colors and format.

> Small tweaks towards the general rectangles. We will reduce the middle rectangle space and give it to the right side,
> so we can work on its popup.

> General Measurements will be stored in a separate for better management.

---

# June 10, 2026

## Details

> Since the property for importance has been completed, I was working on the set time. As of now, the core part of it
> is working correctly. The only missing parts are setting the time in a Text item and save it to the JSON file.

> Later on, when the app is opened, the user will be meet with a tutorial that explains each section of the app. This
> tutorial would be available as well on the settings page. The logic for the tutorial would be a copy of the actual
> program, only that it would be tweaked to have popups that explain the info and several details would not need to be
> included.

> A new change will be done in the future, when working with the details of the looks of the app. The rectangles that
> are being used as buttons for different things will be replaced by a new item, Control. As of now, this item will be
> used for the time area.

> The clicking system works correctly for them time. Now, I will set it up so the new time that I choose is saved.

> Later on, the structure of the visuals will be based on rectangles, controls, and abstract buttons.

> The time setting has been completed. The time is now saved on the JSON file. Right now, I am facing some issues with
> the saving logic, so my focus is towards that problem.

> Next task will focus on changing the saving logic of the assignments. It will be similar to the pages, since we will
> save the index of the assignment. That way, depending on the current index that we are in, we are going to edit the 
> correct assignment on the correct page.

### To do list in general
- Use multiple QML files and classes for managing the color scheme
- Fix the saving logic of the assignment pages
- Continue with the saving logic of other areas
- Continue creation of right rectangle
- Take note of the rectangles that will be replaced by `AbstractButton` or `Control`

# June 11, 2026

## Tweaking Saving Function

> An update has been made towards the saving function of the assignments. The assignments are each stored separately with
> a proper index number. Now, I will work on saving all the info inside the popup. While I already have a function 
> for this, I want to save all of this info together, since they are from the same place.

> The saving function is not working correctly in general. The next focus will be moved on towards the right rectangle,
> in which we will include the following:
    
    - Time (which needs to be connected to the correct timezone)
    - Drop down menu for the themes of the app
    - Place for the MP3 player (the main focus is on this one particularly, since I have an MP3 player code already made)

# June 12, 2026

## MP3 Player

> I will focus on exporting the code that I made in the past about an MP3 player and include it here.

> For building the MP3 player, it will have its own separate file section, so the logic does not get messy.

> Apart from that, we will have classes for controlling the MP3 player information and functions. These classes will be
> in separate files as well.

> The basic visuals have been created for the MP3 player, now I will move on to the logic of playing songs.

> I ditched the idea of using an internal class for the MP3 player, it just made everything more complicated when there
> are simpler and efficient solutions. All the logic for the MP3 player will be in the same class as the UI logic.

# June 13, 2026

## MP3 Player (continuation)

> TO-DO: Make changes to the song save. Save it in a json file and have a logic system for checking if there are changes. If 
> a new song is added, we just update the json file, add only that song, and then send it to the UI. No need for recalculating
> the whole json file.

> Small update has been made regarding the organization of the code. The functions have been divided in three classes,
> which permit a better management of the code. 

> Tweaks were made to the reading function of the audio files, since it did not have a limit towards the amount of times
> that a file's name should be split.

> The next task will be focused on connecting the slider and giving it the right values. The slider must receive the 
> duration of the song when the song is loaded. That duration is then set as the limit of the slider. After loading it,
> we will have the timer show the value of the current time in a function. Tomorrow this problem will be dealt with.

# June 14, 2026

## MP3 Player (Part Three)

> Multiple changes are taking place. As of now, the program is capable of establishing correctly the total duration of
> the audio being played. This is reflected on the UI. Also, the code is being reorganized, so that the properties are 
> written with the correct decorator. This way, it is easier to read and understand what is being received and what is 
> being sent.

# June 15, 2026

## MP3 Player  (Part Four)

> This time, the MP3 player is almost completed. The progress bar is updated correctly, and you can choose the time
> where you want the song to be. Choosing a song works correctly and its unique, so the visual updates are seen in all
> the pages. It is still missing a few details, but they will be taken care off in the future. The next task is to 
> reorganize the functions in the different classes for better management.

# June 19, 2026

## Code logic organization and MP3 details

> The MP3 logic has almost completed. The missing parts are:
    - Forward and back
    - Volume control
    - Auto skip to next song when current song ends

> For the following steps, we will work on utilizing a stack view for appending and erasing the settings page. Before 
> entering on that, first I will work on organizing the functions in different classes. Then, I will work on making the
> UI of the song list more compact.

> The MP3 player logic has been correctly separated from the main logic of the UI. In tue future, I will create a roadmap
> that shows how the connections between the classes work. That way, it is easier to understand.

> The next step is fix the song list page, giving it better details and making it smaller.

> The song list has been updated. Now it looks more organized and easy to use. More updates regarding the MP3 will be 
> made in the future. The saving logic of the MP3 songs needs adjustments. Right now, it saves the songs and updates the
> COMPLETE list of the songs, instead of just adding it. Visually, it looks like it was added, but internally it is 
> rewriting the whole list. Solution:
    - Have a new json file only for song name and details
    - Have the program read the json file and not re-read the entire folder
    - We only add the new song to the json file, then update the list by adding ONLY the new song

> New ideas have been drafted in the external document regarding the settings menu. Later on the details will be
> documented here. After dealing with the settings tab, I will move on to checking the smaller details that are missing
> and add any missing parts of the UI before checking the entire UI for any errors or details could be improved. The 
> important details of the settings tab will be left for the end, like the themes for example.


# June 20, 2026

## Settings Tab

> with the ColorDialog, I set the chosen color to a variable and then that variable is used my multiple objects.

> The settings tab has been created through the use of a Loader. The different options have been set, although not all
> of them will be used at first. The next step is connecting each option button to a ListView, which will contain the 
> settings of the app. 

> Regarding this report, a structure will be constructed in which we can see all the connections between each function
> from the logic and the UI, as well as the connections of each QML file between them. (mermaid.js)

> For creating the connections to the settings, we are going to use Loaders. The different settings will be saved in 
> different files, connected to the loaders.

// Theme.qml
pragma Singleton
import QtQuick 2.15

Item {
    // These properties hold the live colors used by your ENTIRE app
    property color primaryBg: "#000000"
    property color sidebarBg: "#808080"
    property color accentColor: "#0000ff"
    property color buttonText: "#ffffff"
}

> The different Load options of the settings are working correctly. Right now they are empty, but soon enough the 
> specifications will be developed and connected it. The next step is to work the whole UI itself and check for any
> change that can be done for a more efficient look.

> The buttons for changing pages have been moved to the inside of the RightRectangle small menu.

> Adjustments have been made to rectangles that were being used as buttons. Those rectangles are now abstract buttons.

> The class detail rectangle has been completed, having a connection to the json file for storing the written information.
> Further updates will be done regarding this area.

> The rectangle for the todo list has been completed as well, having a button for creating slots and each one being 
> saved to the json file.

> Since the app will have a built-in clock, here I add the reference for the commands used for this part. 
>   **Reference**: Time Data(https://www.geeksforgeeks.org/python/python-program-to-get-current-time/)

>   **Reference**: Python strftime cheatsheet (https://www.bairesdev.com/tools/strftime/)

> The data written on the to do list is correctly saved onto the json file. Next will be complete the MP3. I need to 
> connect the boolean variable in python that controls the music with the UI.

> When moving forward or backward, the music must be loaded again, as if it was being chosen manually.

> I will also work on the theme controls for the entire program.

# June 21, 2026

## Color management

> For the color themes, I will list the main areas that will be capable of changing colors and then connecting them
> throughout the whole program. The areas are:
> - Background rectangles 1 and 2
> - borders
> - Rectangles with info
> - Buttons for moving pages
> - Buttons for creating
> - MP3 Buttons and slider 

> Most of the rectangles are now connected to the color file. Now, im working on the theme creation page on the settings.
> This area will take more time, due to the different connections that need to be done.


# June 26, 2026

## Mini Preview

> As of today, I have resumed work on my application. Right now, I am working on making the small preview for the colors
> that the user chooses, so it is easier to select.
    
> A note to consider, when working with layouts, if a spacer is placed on the inside of them, it can make it expand even
> further beyond, which only takes up all the remaining space, so if anything else is added and is set to fill the space
> as well, the Item will only make the layout expand and take the space that was going to be used by the second and 
> newer layout. Item spacer should only be added when nothing else is going to be added, so that the space calculations
> are correct and nothing disappears.

### To Do list
- Change the MP3 system reading, so that the program does not need to read ALL the files in the folder and can easily
read the info of the file from a json file.
- Fix MP3 play and pause button. When the slider is moved with the music paused, the boolean is not changed, so it needs
to be pressed twice.
- Find a way to make the Class Details block have some sort of organization, similar to word, or by default have bullet
points.
- Update the song list
- Finish the small template of the miniature size version of the UI for the color themes (DONE)
- Store the current themes in a json file for better loading
- Use dialog boxes for ensuring changes and showing warnings
- Make each page of the UI more unique. Each page of the UI should have their own set of colors and templates.
- Have in mind the deletion options for multiple areas of the program.

- Maybe combine all the buttons to have the same colo and change it for a different option.

> Updated the look of the right rectangle and divided it in three sections: clock, mp3, and control buttons. After this,
> I also made changes to the color controls and reduced the amount of buttons, so the colors are more generally 
> selected. After this, I am now going to continue with the small preview UI.

> The small preview UI has been completed to some extent. I only need to revise small details, this being the placement
> of the rectangles on the to do list.

> Next step will be to work on the details that are missing regarding the mp3 (file management, button symbols, button 
functions, play and pause boolean).


# June 28, 2026

## Finishing MP3 Details

> The first work will be to fix the loading mechanism. As of now, everytime that a song is added, the program reads the
> whole list of songs AGAIN and recreates the visual list in the UI. While it is not an issue at first, if the amount of
> songs becomes to great, it can start to slow down.

### MP3 Setting SongList workflow

1. ListView calls the function `musicList` => This calls the `songs()` function
2. In the `songs()` function we call the `setFile()` function
3. In the `setFile()` function we read the directory and retrieve all the files withing the audio folder
   (Here we have to change it. It must read the JSON file, which contains the names of the songs, so the program does
    not need to check the whole directory)

### New Workflow
1. ListView calls the function `musicList` = > This calls the `songs()` 
2. In the `songs()` function we call the `setFile()` function
3. In the `setFile()` function we open the JSON file with the MP3 files, read them, and store then in the `songList` variable
4. When a new file is added, it goes through the same process (`chooseFile` function is called)
5. Then, the `fileControl` function is called. In here, we also take the details ONLY of the new file. Then, we update
the songList and store it again in the JSON, with the newly added file.

> After this change, I made it so that, when the song is chosen, the program does not need to loop through all the 
> songs and will only take the info of the selected song.

> The next fix is related to the play and pause button, and the progress bar. When the progress bar was released, the 
> song played automatically.

> The update for this consists in boolean variables. In the function `playPause`, in the `else` statement, the music is 
> typically unpaused. I changed it so that, depending on the slider status boolean variable, the way of resuming would
> be different. If the boolean `self.audio.sliderState` is True, the way of resuming the song changes. This boolean 
> consists of a connection to another function. The other function is `continueTimer`, which runs everytime that the
> slider is released. 

> In this other function, if the audio is playing, we use the boolean variable `self.audio.playing`. If it is True, 
> then we start the timer and make the song play from the position we want AND set the boolean variable 
> `self.audio.sliderState` to False, so, in the previous function, the pause method changes to the normal, which only 
> uses `self.audio.m.unpause()`. This is seen in action when the song is currently playing and NOT paused. 

> IF the song was paused, then we move to the else condition, which sets the boolean variable `self.audio.sliderState` 
> to True. Then, since the song is paused, the unpausing method changes, which affects the function `playPause`. When we
> go back to the previous function, the workflow has changed. Now that `self.audio.sliderState` is set to True, we use
> the first statement of the if condition for this, which is to start and play the audio from the current 
> songTimePosition, ensuring that the audio will play from the position selected in the slider.

> This workflow ensures that the song can be correctly moved whether its paused or playing.

> The next task is to work on the logos of the buttons. Good and recognizable logos will be used for the buttons. I will
> decide if they are images or drawn. Also, I will work on the logic of how the logo changes when I press the play and 
> pause button. After this, I will work on the logic centered on skipping tracks or going back.


# June 29, 2026

## MP3 Details

> As of today, the skip and back buttons are working correctly. The listview that contains the titles of the songs keeps
> track of the currentIndex, so the correct song is always played. I also put the logic between if statements, so I could 
> make sure that the index did not go out of bounds.

> Next fix is related to the MP3 in general, safety measures in case that the buttons are pressed when nothing is playing.

> The fix has been implemented by utilizing a boolean variable on the python backend and registering it on the QML. The
> buttons of the MP3 start of disabled and when a song is loaded, the boolean becomes True, which then enables the buttons 
> of the MP3, including the slider.

> Now I am working on a fix for the song list, making it more user-friendly. Instead of being a Popup, it will be placed
> right below the MP3 player.

> After this, I have made some tweaks to the buttons of the MP3, since there was a mismatch on the indexes of the current 
> song playing and the one that comes after.

> The bugs have been fixed on the MP3. An idea for the future is to make it a dropdown, saving up space.

> The Todo List for today fill focus on fixing details.

1. Button Logos 
2. The UI preview for themes
3. A global option for the font
4. FOR LATER -> Make a visual representation of the program where I draw and signal the different row and column layouts that compose the program, a visual skeleton of the program (MERMAID)

# July 4, 2026

## Icon management

> With the integration of MERMAID, the graph section will be quicker to be created. Simple graphs showing the efficienly 
> of the user. This is still an idea in progress.

> On what we will focus today is on the icons. They will have a structure in which all the icons of the same button will
> have the same name, but the folder will decide which of them is the one being used.
> Example:
    
    text: "\..\..\{foldername}\ rightArrowIcon"

> I will include here the file structure of the icons:

### Icon File Diagram
![Logo de mi App](Icon%20Flow%20Chart.jpeg)


# July 6, 2026

## Details

> The paths for each icon has been set. Now, I am working on the display for the icon templates, which will be a nested
> Repeater. First repeater loops through an icon folder, and second repeater loops over all the icons in that folder.

> The icons appear correctly on the theme management page. Now, the next task is to connect this all the icons in the
> program and let the user choose the wanted one.   


# July 10, 2026

## Details

> 
