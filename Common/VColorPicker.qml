import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

import "sizes.js" as Size
import "palette.js" as Palette

import "../Store"

VDialog{
    id: colorPicker
    title: "Style Picker"
    property color selectionColor
    property alias colors: colorPickerRepeater.model
    width: app.width*0.7
    height: colorPickerGrid.height

    Flow {
        id: colorPickerGrid
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: Size.BORDER
        Repeater {
            id: colorPickerRepeater
            model: ItemStyles{
                id : itemStyles
            }
            Rectangle {
                width: Size.ICON_64
                height: width
                color: itemStyles.color(value)

                Rectangle {
                    height: childrenRect.height
                    anchors {left: parent.left; right: parent.right; bottom: parent.bottom;}
                    anchors.margins: Size.BORDER_DOUBLE
                    color: value == colorPicker.selection?Palette.ACCENT3 :Palette.BLANK
                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: itemStyles.name(value)
                        font.pixelSize: Size.FONT_SIZE_SMALL
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        colorPicker.selection = value;
                        colorPicker.selectionColor = color;
                    }
                }
            }
        }
    }
}
