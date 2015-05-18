import QtQuick 2.4

import "palette.js" as Palette

Rectangle {
    id: page

    color: Palette.PAGE

    property int pageTransitionDuration: 300
    default property alias _contentChildren: pageContent.data

    signal show()
    signal shown()
    signal hide()
    signal hidden()

    function back() { app.goBack(); return true; }
    function menu() {return true;}

    Item
    {
        id: pageContent
        anchors.fill: parent
    }

//    Page shadowing effect
    Rectangle
    {
        id: pageOverlay
        color: "#000"
        anchors.fill: parent
        opacity: 0
        Behavior on opacity {NumberAnimation{duration: page.pageTransitionDuration}}
    }

    states: [
        State {
            name: "DISABLED"
            when: !page.enabled

            PropertyChanges {
                target: pageOverlay
                opacity: 1
            }
        }
    ]

}
