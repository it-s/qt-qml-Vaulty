import QtQuick 2.5

import "sizes.js" as Sizes
import "palette.js" as Palette

MouseArea {
    id: button
    width: buttonRow.width + Sizes.MARGIN_DOUBLE
    height: Sizes.ICON_32

    opacity: enabled? 1: 0.5

    property alias icon: contentIcon.name
    property alias text: contentLabel.text

    property alias iconSize: contentIcon.size
    property color textColor: Palette.BUTTON_TEXT

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
        Icon {
            id: contentIcon
            anchors.verticalCenter: parent.verticalCenter
            color: contentLabel.color
        }
        VLabel {
            id: contentLabel
//                height: parent.height
            anchors.verticalCenter: parent.verticalCenter
//                verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            visible: text != ""
            lineHeight: 1
            color: primary? Palette.BUTTON_TEXT_PRIMARY: button.textColor
        }
    }
}

