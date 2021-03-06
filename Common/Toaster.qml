import QtQuick 2.5

import "sizes.js" as Sizes

Loader {
    id: messages

    function displayMessage(message) {
        if (messages.state == "show") {
            messages.item.message = message;
            item.blink();
            timer.restart();
        }else{
            messages.source = "";
            messages.source = Qt.resolvedUrl("Toast.qml");
            messages.item.message = message;
        }
    }

    width: parent.width
    anchors.top: parent.bottom
    z: 1
    onLoaded: {
        messages.item.state = "portrait";
        timer.running = true
        messages.state = "show"
    }

    Timer {
        id: timer

        interval: 3000
        onTriggered: {
            messages.state = ""
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            messages.state = ""
        }
    }

    states: [
        State {
            name: "show"
            AnchorChanges { target: messages; anchors { bottom: parent.bottom; top: undefined } }
//            PropertyChanges { target: messages; anchors.bottomMargin: 0 }
        }
    ]

    transitions: Transition {
        AnchorAnimation { easing.type: Easing.OutQuart; duration: 300 }
    }
}
