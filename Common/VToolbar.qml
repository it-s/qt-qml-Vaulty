import QtQuick 2.4
import QtQuick.Layouts 1.1

import "sizes.js" as Sizes
import "palette.js" as Palette

Rectangle {
    id: toolbar
    width: 320
    anchors.left: parent.left
    anchors.right: parent.right
    height: Sizes.TOOLBAR_MIN
    color: Palette.TOOLBAR
    clip: true
    default property alias _contentChildren: content.data
    property alias icon: toolabrIcon.icon
    property alias text: toolbarText.text

    signal action

    RowLayout {
        id: content
        anchors.fill: parent
        anchors.margins: Sizes.MARGIN
        spacing: Sizes.MARGIN
        Row {
            id: row1
            spacing: Sizes.MARGIN / 2
            Layout.fillWidth: false
            VToolbarButton {
                id: toolabrIcon
                anchors.verticalCenter: parent.verticalCenter
                onClicked: toolbar.action()
            }
            VLabel{
                id: toolbarText
                color: Palette.TOOLBAR_TEXT
                font.pixelSize: Sizes.FONT_SIZE_SUBHEAD
                text: "Toolbar"
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignBottom
            }
       }
    }

}

