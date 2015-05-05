import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "../Common"

OverView {
    id: keyView

    saveButtonText: "OK"

    onStateChanged: keyText.focus = true

    function clear(){
        keyText.text = "";
    }

    function open(data) {
        _editing = data;
        state = "OPEN";
    }

    function save(){
        if (_editing!=null&&keyText.text != "")
            _editing.callback(store.open(_editing.store, keyText.text));
        close();
    }

    TextField {
        id: keyText
        anchors.right: parent.right
        anchors.left: parent.left
        placeholderText: qsTr("Vault Key")
        echoMode: TextInput.Password
    }
}
