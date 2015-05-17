import QtQuick 2.4

import "sizes.js" as Sizes
import "palette.js" as Palette

MouseArea {
    id: button
    width: childrenRect.width
    height: Sizes.ICON_32

    opacity: enabled? 1: 0.5

    property alias icon: contentIcon.source
    property alias text: contentLabel.text
    property alias type: button.state

    Rectangle {
        id: content
        width: contentIcon.width + contentLabel.width + Sizes.MARGIN_DOUBLE
        height: parent.height
        color: Palette.BUTTON

        Row {
            id: row1
            height: parent.height
            scale: button.pressed? 0.8: 1
            anchors.centerIn: parent
            Image {
                id: contentIcon
            }
            VLabel {
                id: contentLabel
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                font.capitalization: Font.AllUppercase
                visible: text != ""
                lineHeight: 1
            }
        }

    }
}

