import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "../Common"

OverView {
    id: editView

    onStateChanged: nameText.focus = true

    function clear(){
        nameText.text = "";
        descriptionText.text = "";
    }

    function edit(item){
        //Edit code here
        _editing = item;
        if (_editing !== null){
            nameText.text = _editing.name;
            descriptionText.text = _editing.description;
        }
        open();
    }

    function save(){
        var data = {
            name: nameText.text,
            description: descriptionText.text
         };

        if (_editing !== null){
            _editing.callback(data);
        }else{
            if (nameText.text != "")
                vaults.add(data);
        }
        editView.close();
    }

    TextField {
        id: nameText
        anchors.right: parent.right
        anchors.left: parent.left
        placeholderText: qsTr("Vault name")
    }
    TextField {
        id: descriptionText
        anchors.right: parent.right
        anchors.left: parent.left
        placeholderText: qsTr("Vault description")
    }
}
