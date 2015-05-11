import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1

import "../Common"
import "utils.js" as Utils

OverView {
    id: keyView

    saveButtonText: "OK"

//    onStateChanged: keyText.focus = true

    function opened(){
        keyText.forceActiveFocus()
        keyText.focus = true;
    }


    function clear(){
        messageDialog.text = "";
        keyText.text = "";
    }

    function open(file){
//        console.log(file);
        if (!file) return;
        _editing = file;
        state = "OPEN"
    }

    function save(){
        var error = Utils.invalidKey(keyText.text);
        if (error) {
            messageDialog.text = error;
            messageDialog.open();
        }else{
            error = "Could not unlock valut with the key provided.";
            var key = Utils.toKey(keyText.text);
//            console.log(key);
            if (store.open(_editing, key)){
                close();
                app.goToPage("Store");
            }else {
                messageDialog.text = error;
                messageDialog.open();
            }
        }
    }
    Label{
        anchors.right: parent.right
        anchors.left: parent.left
        text: "Key must contain at least six characters, including uppercase, lowercase letters and numbers."
        wrapMode: Text.WordWrap
    }

    TextField {
        id: keyText
        anchors.right: parent.right
        anchors.left: parent.left
        placeholderText: qsTr("Vault key")
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhHiddenText | Qt.ImhNoPredictiveText
    }

    MessageDialog {
        id: messageDialog
        icon: StandardIcon.Warning
        title: "Error"
        text: ""
        standardButtons: StandardButton.Ok
    }
}
