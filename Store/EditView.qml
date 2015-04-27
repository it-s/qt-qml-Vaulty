import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "../Common"

OverView {
    id: editView

    onStateChanged: itemTitle.focus = true

    function clear(){
//        type: 0,
//        style: 0,
        itemTitle.text = "";
        itemLogin.text = "";
        itemNumber.text = "";
        itemPass.text = "";
        itemPin.text = "";
        itemRelate.text = "";
        itemDescription.text = "";
    }

    function edit(item){
        //Edit code here
        _editing = item;
        if (_editing !== null){
//            type: 0,
//            style: 0,
            itemTitle.text = item.title;
            itemLogin.text = item.login;
            itemNumber.text = item.number;
            itemPass.text = item.password;
            itemPin.text = item.pin;
            itemRelate.text = item.relate;
            itemDescription.text = item.description;
        }
        open();
    }

    function save(){
        var data = {
            type: itemType.value,
            style: 0,
            title: itemTitle.text,
            login: itemLogin.text,
            number: itemNumber.text,
            password: itemPass.text,
            pin: itemPin.text,
            relate: itemRelate.text,
            description: itemDescription.text
         };

        if (_editing !== null){
            _editing.callback(data);
        }else{
            if (itemTitle.text != "")
                vaults.add(data);
        }
        close();
    }

//    mDataRoles[TypeRole] = "type",
//    mDataRoles[StyleRole] = "style",
//    mDataRoles[TitleRole] = "title",
//    mDataRoles[LoginRole] = "login",
//    mDataRoles[NumberRole] = "number",
//    mDataRoles[PasswordRole] = "password",
//    mDataRoles[PinRole] = "pin",
//    mDataRoles[RelateRole] = "relate",
//    mDataRoles[DescriptionRole] = "description";

    Label {
        text: qsTr("Service Type:")
        anchors.left: parent.left
    }

    ComboBox {
        id: itemType
        property int value: 0
        anchors.right: parent.right
        anchors.left: parent.left
        model: ItemTypes{
            id: itemTypeModel
        }
        onAccepted: value = itemTypeModel.get(currentIndex).value
    }

    TextField {
        id: itemTitle
        anchors.left: parent.left
        anchors.right: parent.right
        placeholderText: qsTr("Service Name")
    }

    TextField {
        id: itemNumber
        anchors.left: parent.left
        anchors.right: parent.right
        placeholderText: qsTr("Account Number (if any)")
        inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhNoPredictiveText
    }

    TextField {
        id: itemLogin
        anchors.left: parent.left
        anchors.right: parent.right
        placeholderText: qsTr("User Name")
        inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
    }

    TextField {
        id: itemPass
        anchors.left: parent.left
        anchors.right: parent.right
        placeholderText: qsTr("Password")
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
    }

    TextField {
        id: itemPin
        anchors.left: parent.left
        anchors.right: parent.right
        placeholderText: qsTr("Pin Number (if any)")
        inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhNoPredictiveText
    }

    TextField {
        id: itemRelate
        anchors.left: parent.left
        anchors.right: parent.right
        placeholderText: qsTr("Service URL (if any)")
        inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
    }

    Label {
        text: qsTr("Additional notes:")
        anchors.left: parent.left
    }

    TextArea {
        id: itemDescription
        anchors.right: parent.right
        anchors.left: parent.left
    }

}
