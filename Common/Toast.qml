import QtQuick 2.3

import "sizes.js" as Sizes
import "palette.js" as Palette

Item {
    id: banner

    property alias message : messageText.text

    height: Sizes.LIST_ITEM_HEAD

    function blink() {
        blinkAnimation.start();
    }

    Rectangle {
        id: background
        anchors.fill: banner
        color: Palette.DARK
    }

    VLabel {
        id: messageText
        anchors.fill: banner
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        color: Palette.BLANK
        scale: 1
    }

    SequentialAnimation {
        id: blinkAnimation
        loops: 2
        running: false
        NumberAnimation {
            target: messageText
            property: "scale"
            to: 1.2
            duration: 50
        }
        NumberAnimation {
            target: messageText
            property: "scale"
            to: 1
            duration: 50
        }
    }
}
