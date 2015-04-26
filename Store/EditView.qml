import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "../Common"

OverView {
    id: editView

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

    function save(){
        if (_editing !== null){

        }else{
            if (itemTitle.text != "")
            store.add({
                          type: 0,
                          style: 0,
                          title: itemTitle.text,
                          login: itemLogin.text,
                          number: itemNumber.text,
                          password: itemPass.text,
                          pin: itemPin.text,
                          relate: itemRelate.text,
                          description: itemDescription.text
                      });
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

//    Label {
//        text: qsTr("Service Type:")
//        anchors.left: parent.left
//    }

//    ComboBox {
//        id: itemType
//        anchors.right: parent.right
//        anchors.left: parent.left
//    }

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
