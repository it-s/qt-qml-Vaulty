import QtQuick 2.5

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
        color: Palette.LIST_ITEM_TITLE
        verticalAlignment: Text.AlignVCenter
    }
}
