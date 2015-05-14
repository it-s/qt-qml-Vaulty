import QtQuick 2.4

import "sizes.js" as Sizes
import "palette.js" as Palette

Text{
    font.pixelSize: Sizes.FONT_SIZE_BODY
    lineHeight: Sizes.FONT_LINE_HEIGHT_BODY
    font.family: "sans"
    color: Palette.TEXTs
    text: "test"
}

