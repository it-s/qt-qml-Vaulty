import QtQuick 2.4
import QtQuick.Controls 1.2

Menu {

    property var attachedTo

    title: "Edit"

    MenuItem {
        text: "Copy"
        shortcut: "Ctrl+C"
        onTriggered: attachedTo.copy()
        visible: attachedTo.selectedText != ""
    }

    MenuItem {
        text: "Paste"
        shortcut: "Ctrl+V"
        onTriggered: attachedTo.paste()
        visible: attachedTo.canPaste
    }

}

