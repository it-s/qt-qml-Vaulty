import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "../Common"

OverView {
    id: editView

    saveButtonEnabled: titleText.text != ""

//    onStateChanged: nameText.focus = true
    function opened(){
        titleText.forceActiveFocus()
        titleText.focus = true;
    }

    function clear(){
        titleText.text = "";
        descriptionText.text = "";

        titleText.focus = false;
        descriptionText.focus = false;
    }

    function edit(id){
        //Edit code here
        if (id !== null){
            _editing = vaults.get(id);
            titleText.text = _editing.title;
            descriptionText.text = _editing.description;
        }
        open();
    }

    function save(){
        var data = {
            title: titleText.text,
            description: descriptionText.text
         };

        if (_editing !== null){
            vaults.set(_editing.ID, data);
            app.toast("Saved")
        }else{
            vaults.add(data);
            app.toast("Added")
        }
        editView.close();
    }

    TextField {
        id: titleText
        anchors.right: parent.right
        anchors.left: parent.left
        placeholderText: qsTr("Vault name")
//        menu: VTextEditMenu{
//            attachedTo: titleText
//        }
//        onFocusChanged: {
//            if (focus) editToolbar.show(titleText);
//        }
//        onEditingFinished: editToolbar.hide()
        VInputItemButton{
            icon: "image://icons/16x16/times"
            onClicked: parent.text = ""
        }
    }
    TextField {
        id: descriptionText
        anchors.right: parent.right
        anchors.left: parent.left
        placeholderText: qsTr("Vault description")
//        menu: VTextEditMenu{
//            attachedTo: descriptionText
//        }
//        onFocusChanged: {
//            if (focus) editToolbar.show(descriptionText);
//        }
//        onEditingFinished: editToolbar.hide()
        VInputItemButton{
            icon: "image://icons/16x16/times"
            onClicked: parent.text = ""
        }
    }
}
