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

    property string selectionText
    property bool includeAllTypes: true

    function getNameByID(id){
        return itemTypes.name(id);
    }

    Column {
        id: typePickerGrid
        anchors.right: parent.right
        anchors.left: parent.left

        spacing: 0
        Repeater {
            id: typePickerRepeater
            model: ItemTypes{
                id : itemTypes
//                Component.onCompleted: if(includeAllTypes)insert(0,{text:"All Types",value:-1,icon:""})
            }
            Item {
                width: typePickerGrid.width
                height: Size.LIST_ITEM_HEAD * 0.8
//                CheckBox {
//                    anchors.right: parent.right
//                    anchors.left: parent.left
//                    anchors.verticalCenter: parent.verticalCenter
//                    text: itemTypes.name(value)
//                    checked: typePicker.selection == value;
//                }
                Row {
                    anchors.fill: parent
                    spacing: Size.MARGIN
                    Image {
                        source: typePicker.selection == value?"image://icons/checkcircleo":"image://icons/light/circleo"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    VLabel{
                        text: itemTypes.name(value)
                        lineHeight: 1
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

//                Rectangle {
//                    id: _border
//                    height: Size.BORDER
//                    color: Palette.BORDER
//                    anchors.top: parent.bottom
//                    anchors.right: parent.right
//                    anchors.left: parent.left
//                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        typePicker.selection = value;
                        typePicker.selectionText = text;
                        close();
                        selectionMade();
                    }
                }
            }
        }
    }
}
