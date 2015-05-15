import QtQuick 2.4

import "sizes.js" as Sizes
import "palette.js" as Palette

MouseArea {
    id: button
    width: childrenRect.width
    height: Sizes.ICON_32

    readonly property string type_Default: ""
    readonly property string type_Link: "link"
    readonly property string type_Primary: "primary"

    property alias icon: contentIcon.source
    property alias text: contentLabel.text
    property alias type: button.state

    Rectangle {
        id: content
        width: contentIcon.width + contentLabel.width + Sizes.MARGIN_DOUBLE
        height: Sizes.ICON_32
        color: Palette.BUTTON
        radius: Sizes.BUTTON_RADIUS
        border.width: Sizes.BORDER
        border.color: Palette.BUTTON_BORDER

        Row {
            scale: button.pressed? 0.8: 1
            anchors.centerIn: parent
            Image {
                id: contentIcon
            }
            VLabel {
                id: contentLabel
                color: Palette.BUTTON_TEXT
            }
        }

    }
    states: [
        State {
            name: "link"

            PropertyChanges {
                target: content
                border.color: "#00000000"
            }
        },
        State {
            name: "primary"
        }
    ]
}

