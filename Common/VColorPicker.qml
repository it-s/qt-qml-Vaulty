import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

import "sizes.js" as Size
import "palette.js" as Palette
import "icons.js" as Icons

import "../Store"

VDialog{
    id: colorPicker
    title: "Style Picker"

    property color selectionColor

    function getNameByID(id){
        return itemStyles.name(id);
    }

    Flow {
        id: colorPickerGrid
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: Size.MARGIN

//        spacing: Size.BORDER
        spacing: Size.MARGIN_HALF

        Repeater {
            id: colorPickerRepeater
            model: ItemStyles{
                id : itemStyles
            }
            Rectangle {
//                width: (colorPickerGrid.width - colorPickerGrid.spacing * 4) / 4
                width: (colorPickerGrid.width - Size.MARGIN_HALF * 3) / 4
                height: width
                radius: width / 2
                border.width: Size.BORDER_DOUBLE
                border.color: Palette.BORDER

                color: itemStyles.color(value)

                Rectangle {
                    width: Size.ICON
                    height: width
                    radius: width / 2
                    anchors.centerIn: parent
                    color: Palette.BLANK

                    visible: value == colorPicker.selection

                    Icon {
                        name: Icons.UI_CHECKMARK
                        anchors.centerIn: parent
                    }
                }

//                Rectangle {
//                    height: childrenRect.height
//                    anchors {left: parent.left; right: parent.right; bottom: parent.bottom;}
//                    anchors.margins: Size.BORDER_DOUBLE
//                    color: value == colorPicker.selection?Palette.ACCENT3 :Palette.BLANK
//                    VLabel {
//                        anchors.horizontalCenter: parent.horizontalCenter
//                        text: itemStyles.name(value)
//                        font.pixelSize: Size.FONT_SIZE_SMALL
//                    }
//                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        colorPicker.selection = value;
                        colorPicker.selectionColor = color;
                        close();
                        selectionMade();
                    }
                }
            }
        }
    }
}
