import QtQuick 2.4
import QtQuick.Layouts 1.1

import "sizes.js" as Sizes
import "palette.js" as Palette

MouseArea {
    id: listItem
    width: 320
    anchors.left: parent.left
    anchors.right: parent.right
    height: Sizes.LIST_ITEM
    clip: true
    default property alias _contentChildren: listItemContent.data
    property alias border: _border.visible
    property alias prefix: listItemPrefix.data
    property alias suffix: listItemSuffix.data

    Rectangle {
        id: highlight
        anchors.centerIn: parent
        width: parent.pressed? parent.width: 0
        height: width
        radius: width
        color: Palette.LIST_ITEM_HIGHLIGHT
        opacity: (width / listItem.width)
        Behavior on width {
            SequentialAnimation{
                PauseAnimation {
                    duration: 500
                }
                NumberAnimation{
                    duration: 300
                }
            }
        }
    }
    Rectangle {
        id: selection
        anchors.fill: parent
        color: Palette.LIGHT
        opacity: parent.pressed? 1: 0
        Behavior on opacity {NumberAnimation{duration: 100}}
    }

    RowLayout{
        anchors.fill: parent
        anchors.margins: Sizes.MARGIN
        spacing: Sizes.MARGIN
        Item {
            id: listItemPrefix
            width: childrenRect.width
            height: childrenRect.height
            Layout.fillWidth: false
        }
        Column {
            id: listItemContent
            spacing: 0//Sizes.FONT_MARGIN
            Layout.fillWidth: true
        }
        Item {
            id: listItemSuffix
            width: childrenRect.width
            height: childrenRect.height
            Layout.fillWidth: false
        }
    }

    Rectangle {
        id: _border
        height: Sizes.BORDER
        color: Palette.BORDER
        gradient: Gradient {
            GradientStop {
                id: gradientStop2
                position: 0
                color: Palette.BORDER
            }

            GradientStop {
                id: gradientStop1
                position: 1
                color: "#00000000"
            }
        }
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom

    }
    states: [
        State {
            name: "borderShadow"

            PropertyChanges {
                target: _border
                height: Sizes.BORDER * 4
            }
        }
    ]
}
