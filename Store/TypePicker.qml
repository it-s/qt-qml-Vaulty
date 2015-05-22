import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "../Common/sizes.js" as Sizes
import "../Common/palette.js" as Palette
import "../Common"

OverView {
    id: typePicker

    saveButtonText: ""
    property int selection

//    onStateChanged: nameText.focus = true
    function opened(){

    }

    function clear(){
        selection = -1;
    }

    function save(value){
        selection = value;
        close();
    }

    Repeater {
        model: ItemTypes {
                id: itemTypeModel
                Component.onCompleted: insert(0,{text:"All Types",value:-1,icon:""})
            }
        delegate: VListItem {
            height: Sizes.LIST_ITEM_HEAD
            onClicked: typePicker.save(value)
            VLabel {
                id: label
                text: itemTypeModel[index].text
            }
        }
    }

}
