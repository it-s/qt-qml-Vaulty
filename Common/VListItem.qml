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

    drag.target: itemBody
    drag.axis: Drag.XAxis
    drag.minimumX: 0
    drag.maximumX: width

    Connections {
        onReleased: {
            if (itemBody.x > width / 2)
            {
                active = true;
                itemBody.x = width / 2;
            } else {
                active = false;
                itemBody.x = 0;
            }
        }
    }

    default property alias _contentChildren: listItemContent.data
    property bool active: false
    property alias border: _border.visible
    property alias prefix: listItemPrefix.data
    property alias suffix: listItemSuffix.data
    property alias anctionText: itemActionButton.text

    signal action

    Rectangle {
        id: selection
        anchors.fill: parent
        color: Palette.LIST_ITEM_SELECT
        opacity: parent.pressed? 1: 0
        clip: true
        Behavior on opacity {NumberAnimation{duration: 100}}
        Rectangle {
            id: highlight
            anchors.centerIn: parent
            width: listItem.pressed && !listItem.drag.active? parent.width: 0
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
    }

    Rectangle {
        id: itemAction
        color: Palette.BLANK
        anchors.fill: parent
        opacity: itemBody.x / (parent.width / 2)

        VButton {
            id: itemActionButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Sizes.MARGIN_DOUBLE
            text: "Delete"
            enabled: listItem.active
            onClicked: listItem.action()
        }

    }


    Rectangle {
        id: itemBody
        color: Palette.BUTTON
        width: parent.width
        height: parent.height
        Behavior on x {NumberAnimation{duration: 50}}
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
    }

    Rectangle {
        id: _border
        color: Palette.BORDER
        height: Sizes.BORDER
        clip: true
        gradient: Gradient {
            GradientStop {
                id: gradientStop2
                position: 0
                color: "#c5cbd6"
            }

            GradientStop {
                id: gradientStop1
                position: 1
                color: "#00000000"
            }
        }
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.bottom

    }
    states: [
        State {
            name: "borderNone"
            PropertyChanges {
                target: _border
                visible: false
            }
        },
        State {
            name: "borderShadow"
            PropertyChanges {
                target: _border
                height: Sizes.BORDER * 4
            }
        },
        State {
            name: "borderShadowTop"
            AnchorChanges {
                target: _border
                anchors.top: parent.top
                anchors.bottom: undefined
            }
            PropertyChanges {
                target: _border
                height: Sizes.BORDER * 4
            }
        }
    ]
}
