import QtQuick 2.5

import "sizes.js" as Sizes
import "palette.js" as Palette

Text{
    font.pixelSize: Sizes.FONT_SIZE_BODY
    lineHeight: Sizes.FONT_LINE_HEIGHT_BODY
//    font.family: "sans"
    color: Palette.TEXT
    elide: Text.ElideRight
}

