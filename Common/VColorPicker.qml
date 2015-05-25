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
    standardButtons: StandardButton.Cancel | StandardButton.Ok
    width: app.width * 0.8 + Size.MARGIN_DOUBLE
    property int selection
    property color selectionColor
    property alias colors: colorPickerRepeater.model

    Grid {
        id: colorPickerGrid
        width: app.width * 0.8 + Size.BORDER * 3
        columns: 4
        rowSpacing: Size.BORDER
        columnSpacing: rowSpacing
        Repeater {
            id: colorPickerRepeater
            model: ItemStyles{
                id : itemStyles
            }
            Rectangle {
                width: app.width * 0.2
                height: width
                color: itemStyles.color(value)

                Rectangle {
                    height: childrenRect.height
                    anchors {left: parent.left; right: parent.right; bottom: parent.bottom;}
                    anchors.margins: Size.BORDER_DOUBLE
                    color: value == colorPicker.selection?Palette.ACCENT3 :Palette.BLANK
                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: color
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
