import QtQuick 2.4

import "sizes.js" as Sizes
import "palette.js" as Palette

MouseArea {
    id: button
    width: childrenRect.width
    height: Sizes.ICON_32

    property alias icon: contentIcon.source
    property alias text: contentLabel.text
    property alias type: button.state

    Rectangle {
        id: content
        width: contentIcon.width + contentLabel.width + Sizes.MARGIN_DOUBLE
        height: Sizes.ICON_32
        color: Palette.BUTTON

        Row {
            scale: button.pressed? 0.8: 1
            anchors.centerIn: parent
            Image {
                id: contentIcon
            }
            VLabel {
                id: contentLabel
                color: button.enabled? Palette.BUTTON_TEXT: Palette.GRAY
                font.capitalization: Font.AllUppercase
            }
        }

    }
}

