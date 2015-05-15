import QtQuick 2.4

import "sizes.js" as Sizes
import "palette.js" as Palette

VListItem {
    id: vListItem
    state: "borderShadowTop"
    height: Sizes.LIST_ITEM_HEAD
    enabled: false
    property alias text: textElement.text
    VLabel {
        id: textElement
//        font.pixelSize: Sizes.FONT_SIZE_SMALL
        color: Palette.LIST_ITEM_TITLE
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
    }
}
