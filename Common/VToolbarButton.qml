import QtQuick 2.0

import "sizes.js" as Sizes
import "palette.js" as Palette

MouseArea {
    width: Sizes.ICON_32
    height: width
    property alias icon: content.source
    Image {
        id: content
        anchors.centerIn: parent
        scale: parent.pressed? 0.8: 1

    }
}

