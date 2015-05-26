import QtQuick 2.4

import "sizes.js" as Sizes
import "palette.js" as Palette

MouseArea {
    id: button
    width: Sizes.ICON_32
    height: width
    property alias icon: contentIcon.source

    opacity: enabled? 1: 0.5

    Rectangle {
        id: content
        anchors.fill: parent
        color: Palette.BUTTON
    }
    Image {
        id: contentIcon
        anchors.centerIn: parent
        scale: parent.pressed? 0.8: 1
        fillMode: Image.Pad
    }
}

