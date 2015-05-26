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
    default property alias _contentChildren: content.data
    property alias icon: toolabrIcon.icon
    property alias text: toolbarText.text
    property alias textColor: toolbarText.color
    property bool shadow: false

    signal action

    MouseArea{
        //Catch all
        anchors.fill: parent
        onClicked: {return true}
    }

    RowLayout {
        id: content
        anchors.fill: parent
        anchors {leftMargin: Sizes.MARGIN_HALF; rightMargin: Sizes.MARGIN;}
        spacing: Sizes.MARGIN
        RowLayout {
            id: row1
            spacing: Sizes.MARGIN_HALF
            Layout.fillWidth: true
            VToolbarButton {
                id: toolabrIcon
                anchors.verticalCenter: parent.verticalCenter
                onClicked: toolbar.action()
                Layout.fillWidth: false
            }
            VLabel{
                id: toolbarText
                height: parent.height
                color: Palette.TOOLBAR_TEXT
                verticalAlignment: Text.AlignVCenter
                lineHeight: 1
                Layout.fillWidth: true
            }
       }
    }

    Rectangle {
        id: _border
        height: Sizes.BORDER * 4
        color: Palette.BORDER
        opacity: 0
        anchors.top: parent.bottom
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
        Behavior on opacity {NumberAnimation{duration: 100}}
    }
    states: [
        State {
            name: "borderShadow"
            when: shadow
            PropertyChanges {
                target: _border
                opacity: 1
            }
        }
    ]

}

