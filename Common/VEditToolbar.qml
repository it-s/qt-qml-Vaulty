import QtQuick 2.5
import QtQuick.Layouts 1.1

import "sizes.js" as Sizes
import "palette.js" as Palette

Item {
    id: editToolbar
    anchors.fill: parent

    property var attachedTo

    property bool isShown: false

    property alias canClear: buttonClear.visible
    property alias canSelect: buttonSelectAll.visible
    property alias canCut: buttonCut.visible
    property alias canCopy: buttonCopy.visible
    property alias canPaste: buttonPaste.visible

    property var defaultOptions: {
        'canClear': false,
        'canSelect': false,
        'canCut': false,
        'canCopy': true,
        'canPaste': true
    }

    function show(object, options){
        if (object === undefined) return;
        var rect = object.mapToItem(editToolbar, 0, 0);
        toolbar.x = rect.x;
        toolbar.y = rect.y - toolbar.height;
        options = options || defaultOptions;
        canClear = options['canClear'] || false;
        canSelect = options['canSelect'] || false;
        canCut = options['canCut'] || false;
        canCopy = options['canCopy'] || false;
        canPaste = options['canPaste'] || false;
        attachedTo = object;
        isShown = true;
    }

    function hide(){
        isShown = false;
        attachedTo = undefined;
    }

    Rectangle {
        id: toolbar
        color: Palette.EDITBAR
        border.color: Palette.BORDER
        border.width: Sizes.BORDER

        width: childrenRect.width
        height: childrenRect.height

        opacity: 0

        Row {
            spacing: 0
            height: Sizes.ICON

            VToolbarButton {
                id: buttonClear
                width: Sizes.ICON
                icon: "image://icons/16x16/paragraph"
                onClicked: attachedTo.text = ""
                visible: false
                enabled: (attachedTo !== undefined && attachedTo.text !== undefined && attachedTo.text.length > 0)
            }
            VToolbarButton {
                id: buttonSelectAll
                width: Sizes.ICON
                icon: "image://icons/16x16/font"
                onClicked: attachedTo.selectAll()
                visible: false
                enabled: (attachedTo !== undefined && attachedTo.text !== undefined && attachedTo.text.length > 0)
            }
            VToolbarButton {
                id: buttonCut
                width: Sizes.ICON
                icon: "image://icons/16x16/cut"
                onClicked: attachedTo.cut()
                visible: false
                enabled: (attachedTo !== undefined && attachedTo.text !== undefined && attachedTo.text.length > 0)
            }
            VToolbarButton {
                id: buttonCopy
                width: Sizes.ICON
                icon: "image://icons/16x16/copy"
                onClicked: attachedTo.copy()
                enabled: (attachedTo !== undefined && attachedTo.text !== undefined && attachedTo.text.length > 0)
            }
            VToolbarButton {
                id: buttonPaste
                width: Sizes.ICON
                icon: "image://icons/16x16/paste"
                onClicked: attachedTo.paste()
            }
        }
    }
    states: [
        State {
            name: "shown"
            when: isShown
            PropertyChanges {
                target: toolbar
                opacity: 1
            }
        }
    ]

//    transitions: [
//        Transition {
//            from: ""
//            to: "shown"
//            NumberAnimation{
//                properties: "opacity"
//            }
//        },
//        Transition {
//            from: "shown"
//            to: ""
//            NumberAnimation{
//                properties: "opacity"
//            }
//        }
//    ]

}

