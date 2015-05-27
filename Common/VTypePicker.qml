import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

import "sizes.js" as Size
import "palette.js" as Palette

import "../Store"

VDialog{
    id: typePicker
    title: "Type Picker"
    property int selection: -1
    property string selectionText
    property alias types: typePickerRepeater.model

    Column {
        id: typePickerGrid
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: 0
        Repeater {
            id: typePickerRepeater
            model: ItemTypes{
                id : itemTypes
                Component.onCompleted: insert(0,{text:"All Types",value:-1,icon:""})
            }
            Item {
                width: typePickerGrid.width
                height: Size.LIST_ITEM_HEAD
                CheckBox {
                    anchors {left: parent.left; leftMargin: Size.MARGIN; verticalCenter: parent.verticalCenter}
                    text: itemTypes.name(value)
                    checked: typePicker.selection == value;
                }

                Rectangle {
                    id: _border
                    height: Size.BORDER
                    color: Palette.BORDER
                    anchors.top: parent.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        typePicker.selection = value;
                        typePicker.selectionText = text;
                    }
                }
            }
        }
    }
}
