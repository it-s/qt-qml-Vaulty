import QtQuick 2.4

import "../Common"
import "../Common/sizes.js" as Sizes
import "../Common/palette.js" as Palette

VListItem {
    VLabel {
        text: name
        color: Palette.LIST_ITEM_TEXT
    }
    VLabel {
        text: description
        color: Palette.LIST_ITEM_SUBTEXT
        font.pixelSize: Sizes.FONT_SIZE_SMALL
    }
}

