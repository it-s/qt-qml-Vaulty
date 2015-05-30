import QtQuick 2.4

import "sizes.js" as Sizes

VButton {
    width: Sizes.ICON
    height: width
    anchors.right: parent.right
    enabled: parent.text.length > 0
//    anchors.rightMargin: Sizes.MARGIN_HALF
}

