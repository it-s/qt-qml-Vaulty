import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "../Common"

OverView {
    id: editView

    saveButtonText: ""
    closeButtonText: "Close"

    onStateChanged: itemTitle.focus = true

    function clear(){
//        itemType.currentIndex = 0;
//        itemStyle.currentIndex = 0;
        itemTitle.text = "";
        itemLogin.text = "";
        itemNumber.text = "";
        itemPass.text = "";
        itemPin.text = "";
        itemRelate.text = "";
        itemDescription.text = "";
    }

    function show(item){
        //Edit code here
//            itemType.currentIndex = itemTypeModel.index(item.type);
//            itemStyle.currentIndex = itemStyleModel.index(item.style);
        itemTitle.text = item.title;
        itemLogin.text = item.login;
        itemNumber.text = item.number;
        itemPass.text = item.password;
        itemPin.text = item.pin;
        itemRelate.text = item.relate;
        itemDescription.text = item.description;
        open();
    }

    Text {
        id: itemTitle
        anchors.left: parent.left
        anchors.right: parent.right
        visible: text!=""
    }
    Text {
        id: itemLogin
        anchors.left: parent.left
        anchors.right: parent.right
        visible: text!=""
    }
    Text {
        id: itemNumber
        anchors.left: parent.left
        anchors.right: parent.right
        visible: text!=""
    }
    Text {
        id: itemPass
        anchors.left: parent.left
        anchors.right: parent.right
        visible: text!=""
    }
    Text {
        id: itemPin
        anchors.left: parent.left
        anchors.right: parent.right
        visible: text!=""
    }
    Text {
        id: itemRelate
        anchors.left: parent.left
        anchors.right: parent.right
        visible: text!=""
    }
    Text {
        id: itemDescription
        anchors.left: parent.left
        anchors.right: parent.right
        visible: text!=""
    }


}
