import QtQuick 2.4

import "../Common"

import "../Common/sizes.js" as Sizes
import "../Common/palette.js" as Palette

VLabel {
    anchors.left: parent.left
    font.pixelSize: Sizes.FONT_SIZE_SMALL
    color: Palette.LIST_ITEM_SUBTEXT
}

