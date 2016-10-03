import QtQuick 2.0
import "sizes.js" as Size
import "palette.js" as Palette
Item {
    id: icon
    width: size
    height: size

    property int size: Size.ICON_24
    property alias name: glyph.text
    property alias color: glyph.color
    property alias iconStyle: glyph.style
    property alias iconStyleColor: glyph.styleColor

    Text {
        id: glyph
        color: Palette.TEXT
        lineHeight: 1
        font.family: "icons"
        font.pixelSize: parent.width
        textFormat: Text.PlainText
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        z: 1
    }
}
