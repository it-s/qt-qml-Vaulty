import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import "../Common"
import "../Common/sizes.js" as Size
import "../Common/palette.js" as Palette
import "../Common/icons.js" as Icons
import "utils.js" as Utils


OverView {
    id: keyView

    property string openVaultID: ""
    property bool _storeExists: false
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
        _storeExists = store.exists(_editing);
        if (openVaultID != id){
            title = _editing.title;
            state = "OPEN"
        }else{
            close();
            app.goToPage("Store",{title: _editing.title});
        }
    }

    function save(){
        var error = Utils.invalidKey(keyText.text, _storeExists? -1: keyMatch.text);
        if (error) {
            app.msg("Wrong key format", error, StandardIcon.Information);
        }else{
            var key = Utils.toKey(keyText.text);
            if (store.open(_editing, key)){
                close();
                openVaultID = _editing.ID;
                app.stashReset();
                app.toast("Unlocked");
                app.goToPage("Store",{title: _editing.title});
            }else {
                app.msg("Unlocking failed", "Could not unlock "+_editing.title+" with the key provided.", StandardIcon.Warning);
            }
        }
    }

    VLabel{
        anchors.right: parent.right
        anchors.left: parent.left
        text: "Since this is a brand new store, you must set the password you will remember."
        wrapMode: Text.WordWrap
        color: Palette.SUBTEXT
        font.pixelSize: Size.FONT_SIZE_SMALL
        visible: !_storeExists
    }

    TextField {
        id: keyText
        anchors.right: parent.right
        anchors.left: parent.left
        placeholderText: qsTr("Vault key")
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhHiddenText | Qt.ImhNoPredictiveText
        onAccepted: _storeExists? save(): (keyMatch.focus = true)
        VInputItemButton{
            icon: Icons.UI_CLEAR
            iconSize: Size.ICON_16
            onClicked: parent.text = ""
        }
    }

    TextField {
        id: keyMatch
        anchors.right: parent.right
        anchors.left: parent.left
        placeholderText: qsTr("Retype key")
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhHiddenText | Qt.ImhNoPredictiveText
        onAccepted: save()
        VInputItemButton{
            icon: Icons.UI_CLEAR
            iconSize: Size.ICON_16
            onClicked: parent.text = ""
        }
        visible: !_storeExists
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
