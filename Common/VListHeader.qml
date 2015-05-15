import QtQuick 2.4

import "sizes.js" as Sizes
import "palette.js" as Palette

VListItem {
    id: vListItem1
    state: "borderShadow"
    enabled: false
    property alias text: textElement.text
    VLabel {
        id: textElement
        font.pixelSize: Sizes.FONT_SIZE_HEADLINE
        color: Palette.LIST_ITEM_HEAD
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
    }
}

