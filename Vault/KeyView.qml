import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1

import "../Common"
import "../Common/sizes.js" as Size
import "../Common/palette.js" as Palette
import "utils.js" as Utils


OverView {
    id: keyView

    property string openVaultID: ""
    saveButtonEnabled: keyText.text != ""
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

    function open(id){
        if (!id) return;
        _editing = vaults.get(id);
        if (openVaultID != id){
            title = _editing.title;
            state = "OPEN"
        }else{
            close();
            app.goToPage("Store",{title: _editing.title});
        }
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
                openVaultID = _editing.ID;
                app.goToPage("Store",{title: _editing.title});
            }else {
                messageDialog.text = error;
                messageDialog.open();
            }
        }
    }

    TextField {
        id: keyText
        anchors.right: parent.right
        anchors.left: parent.left
        placeholderText: qsTr("Vault key")
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhHiddenText | Qt.ImhNoPredictiveText
    }

    VLabel{
        anchors.right: parent.right
        anchors.left: parent.left
        text: "Key must contain at least six characters, including uppercase, lowercase letters and numbers."
        wrapMode: Text.WordWrap
        color: Palette.SUBTEXT
        font.pixelSize: Size.FONT_SIZE_SMALL
    }

    MessageDialog {
        id: messageDialog
        icon: StandardIcon.Warning
        title: "Error"
        text: ""
        standardButtons: StandardButton.Ok
    }
}
