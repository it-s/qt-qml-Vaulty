import QtQuick 2.4

import "sizes.js" as Sizes
import "palette.js" as Palette

MouseArea {
    id: button
    width: Sizes.ICON_32
    height: width
    property alias icon: contentIcon.name

    opacity: enabled? 1: 0.5

    Rectangle {
        id: content
        anchors.fill: parent
        color: Palette.BUTTON
    }
    Icon {
        id: contentIcon
        color: (button['parent'] && button.parent._iconColor) || Palette.TEXT
        anchors.centerIn: parent
        scale: parent.pressed? 0.8: 1
    }
}

