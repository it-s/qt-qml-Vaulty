import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

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
        keyText.text = "";
        keyText.focus = false;
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
            app.msg("Wrong key format", error, StandardIcon.Information);
        }else{
            var key = Utils.toKey(keyText.text);
            if (store.open(_editing, key)){
                close();
                openVaultID = _editing.ID;
                app.toast("Unlocked");
                app.goToPage("Store",{title: _editing.title});
            }else {
                app.msg("Unlocking failed", "Could not unlock "+_editing.title+" with the key provided.", StandardIcon.Warning);
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
//        menu: Menu {
//            property var attachedTo: keyText
//            MenuItem {
//                text: "Clear"
//                onTriggered: attachedTo.text = ""
//            }
//        }
        onFocusChanged: {
            if (focus) editToolbar.show(keyText, {canClear:true});
        }
        onEditingFinished: editToolbar.hide();
    }

    VLabel{
        anchors.right: parent.right
        anchors.left: parent.left
        text: "Key must contain at least six characters, including uppercase, lowercase letters and numbers."
        wrapMode: Text.WordWrap
        color: Palette.SUBTEXT
        font.pixelSize: Size.FONT_SIZE_SMALL
    }

}
