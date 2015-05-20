import QtQuick 2.4

import "sizes.js" as Sizes
import "palette.js" as Palette

MouseArea {
    id: button
    width: buttonRow.width + Sizes.MARGIN_DOUBLE
    height: Sizes.ICON_32

    opacity: enabled? 1: 0.5

    property alias icon: contentIcon.source
    property alias text: contentLabel.text
    property bool primary: false

    Rectangle {
        id: content
        anchors.fill: parent
        color: Palette.BUTTON
    }

    Row {
        id: buttonRow
        height: parent.height
        scale: parent.pressed? 0.8: 1
        anchors.centerIn: parent
        Image {
            id: contentIcon
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.Pad
        }
        VLabel {
            id: contentLabel
//                height: parent.height
            anchors.verticalCenter: parent.verticalCenter
//                verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            visible: text != ""
            lineHeight: 1
            color: primary? Palette.BUTTON_TEXT_PRIMARY: Palette.BUTTON_TEXT
        }
    }
}

