import QtQuick 2.4
import QtQuick.Layouts 1.1

import "../Common"

import "../Common/sizes.js" as Size
import "../Common/palette.js" as Palette
import "../Common/icons.js" as Icons

import "utils.js" as Utils

Item {
    id: cardItem
    width: 320
    anchors.left: parent.left
    anchors.right: parent.right
    height: Math.max(Size.LIST_ITEM_HEAD, listItemContent.height)
    property string text
    property bool masked: false
    property bool revealed: false
    property bool multiline: false
    property alias description: itemDescription.text
    property alias isURL: listItemURL.visible
    visible: itemValue.text!=""

    function masktext(){
        if (cardItem.text != "") itemValue.text = "******";
        revealed = false;
    }

    function revealtext(){
        itemValue.text = cardItem.text;
        revealed = true;
    }

    onTextChanged: {
        if (masked && cardItem.text != "") masktext();
        else revealtext();
    }

    RowLayout{
        anchors.fill: parent
        anchors.leftMargin: Size.MARGIN
        anchors.rightMargin: Size.MARGIN
        spacing: Size.MARGIN
        Column {
            id: listItemContent
            spacing: cardItem.multiline? Size.MARGIN_HALF: 0
            Layout.fillWidth: true
            VLabel {
                id: itemValue
                anchors.left: parent.left
                anchors.right: parent.right
                color: Palette.LIST_ITEM_TEXT
                font.pixelSize: cardItem.multiline? Size.FONT_SIZE_SMALL: Size.FONT_SIZE_BODY
                wrapMode: cardItem.multiline? Text.WordWrap: Text.NoWrap
            }
            VLabel {
                id: itemDescription
                anchors.left: parent.left
                anchors.right: parent.right
                color: Palette.LIST_ITEM_SUBTEXT
                font.pixelSize: Size.FONT_SIZE_SMALL
            }
        }
        VButton {
            id: listItemURL
            width: Size.ICON
            height: width
            visible: false
            anchors.verticalCenter: parent.verticalCenter
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignRight
            icon: Icons.UI_URL
            iconSize: Size.ICON_16
            onClicked: {Qt.openUrlExternally(Utils.formatURL(itemValue.text));app.toast("Opening URL");}
        }
        VButton {
            id: listItemSuffix
            width: Size.ICON
            height: width
            anchors.verticalCenter: parent.verticalCenter
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignRight
            icon: Icons.UI_COPY
            iconSize: Size.ICON_16
            onClicked: {clipboard.copy(cardItem.text);app.toast("Copied");}
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
