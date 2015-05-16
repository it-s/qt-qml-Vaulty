import QtQuick 2.4
import QtQuick.Layouts 1.1

import "../Common"

import "../Common/sizes.js" as Size
import "../Common/palette.js" as Palette

Item {
    width: 320
    anchors.left: parent.left
    anchors.right: parent.right
    height: Size.LIST_ITEM_HEAD
    property alias text: itemValue.text
    property alias description: itemDescription.text
    visible: itemValue.text!=""
    RowLayout{
        anchors.fill: parent
        anchors.leftMargin: Size.MARGIN
        anchors.rightMargin: Size.MARGIN
        spacing: Size.MARGIN
        Column {
            id: listItemContent
            spacing: 0//Sizes.FONT_MARGIN
            Layout.fillWidth: true
            VLabel {
                id: itemValue
                color: Palette.LIST_ITEM_TEXT
                text: "Title"
            }
            VLabel {
                id: itemDescription
                color: Palette.LIST_ITEM_SUBTEXT
                font.pixelSize: Size.FONT_SIZE_SMALL
                text: "Description:"
            }
        }
        VButton {
            id: listItemSuffix
            width: Size.ICON
            height: width
            anchors.verticalCenter: parent.verticalCenter
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignRight
            icon: "image://icons/16x16/clipboard"
            onClicked: clipboard.copy(itemValue.text)
        }
    }

    Rectangle {
        id: _border
        color: Palette.BORDER
        height: Size.BORDER
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: Size.MARGIN
    }
}
