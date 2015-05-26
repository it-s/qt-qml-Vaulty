import QtQuick 2.4
import QtQuick.Layouts 1.1

import "sizes.js" as Sizes
import "palette.js" as Palette

Item {
    id: editToolbar
    anchors.fill: parent
    clip: true

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

    VToolbar {
        id: toolbar
        y: -height
        color: "silver"
        icon: "image://icons/times"

        onAction: attachedTo.focus = false

        VToolbarButton {
            id: buttonClear
            icon: "image://icons/paragraph"
            onClicked: attachedTo.text = ""
            visible: false
            enabled: (attachedTo !== undefined && attachedTo.text !== undefined && attachedTo.text.length > 0)
        }
        VToolbarButton {
            id: buttonSelectAll
            icon: "image://icons/font"
            onClicked: attachedTo.selectAll()
            visible: false
            enabled: (attachedTo !== undefined && attachedTo.text !== undefined && attachedTo.text.length > 0)
        }
        VToolbarButton {
            id: buttonCut
            icon: "image://icons/cut"
            Layout.alignment: Qt.AlignRight
            onClicked: attachedTo.cut()
            visible: false
            enabled: (attachedTo !== undefined && attachedTo.text !== undefined && attachedTo.text.length > 0)
        }
        VToolbarButton {
            id: buttonCopy
            icon: "image://icons/copy"
            Layout.alignment: Qt.AlignRight
            onClicked: attachedTo.copy()
            enabled: (attachedTo !== undefined && attachedTo.text !== undefined && attachedTo.text.length > 0)
        }
        VToolbarButton {
            id: buttonPaste
            icon: "image://icons/paste"
            Layout.alignment: Qt.AlignRight
            onClicked: attachedTo.paste()
        }
    }
    states: [
        State {
            name: "shown"
            when: isShown
            PropertyChanges {
                target: toolbar
                y: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "shown"
            NumberAnimation{
                properties: "y"
            }
        },
        Transition {
            from: "shown"
            to: ""
            NumberAnimation{
                properties: "y"
            }
        }
    ]

}

