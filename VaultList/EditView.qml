import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "../Common"

OverView {
    id: editView

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
        if (_editing !== null){
            _editing.name = nameText.text;
            _editing.description = descriptionText.text;
        }else{
            if (nameText.text != "")
                vaults.add({
                   name: nameText.text,
                   description: descriptionText.text
                });
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

//Item
//{
//    id: editView
//    width: 320
//    height: 480
//    anchors.fill: parent
//    enabled: false
//    opacity: 0

//    property int rowID
//    property alias name: nameText.text
//    property alias description: descriptionText.text

//    function open(name, description){
//        if (name) editView.name = name;
//        if (description) editView.description = description;
//        state = "OPEN"
//    }

//    function close(){
//        state = ""
//    }

//    Rectangle
//    {
//        id: pageOverlay
//        color: "#000"
//        anchors.fill: parent
//        opacity: 0.8
//        MouseArea{
//            anchors.fill: parent
//            onClicked: editView.close()
//        }
//    }

//    Rectangle
//    {
//        id: pageView
//        color: "#fff"
//        anchors.verticalCenter: parent.verticalCenter
//        anchors.right: parent.right
//        anchors.left: parent.left
//        height: childrenRect.height + 24*2

//        Column
//        {
//            anchors.rightMargin: 15
//            anchors.leftMargin: 15
//            anchors.top: parent.top
//            anchors.topMargin: 24
//            spacing: 10
//            anchors.left: parent.left
//            anchors.right: parent.right

//            Column
//            {
//                id: pageBody
//                spacing: 10
//                anchors.left: parent.left
//                anchors.right: parent.right
//                TextField {
//                    id: nameText
//                    anchors.right: parent.right
//                    anchors.left: parent.left
//                    placeholderText: qsTr("Vault name")
//                }
//                TextField {
//                    id: descriptionText
//                    anchors.right: parent.right
//                    anchors.left: parent.left
//                    placeholderText: qsTr("Vault description")
//                }

//            }
//            Rectangle
//            {
//                height: 1
//                color: "#eee"
//                anchors.left: parent.left
//                anchors.right: parent.right
//            }
//            RowLayout
//            {
//                id: pageFooter
//                anchors.left: parent.left
//                anchors.right: parent.right
//                Button{
//                    text: "Cancel"
//                    Layout.alignment: Qt.AlignRight
//                    onClicked: editView.close();
//                }
//                Button{
//                    text: "Save"
//                    Layout.alignment: Qt.AlignRight
//                    onClicked: {
//                        if (editView.name != "")
//                            vaults.add({
//                                           name: editView.name,
//                                           description: editView.description
//                            });
//                        editView.close();
//                    }
//                }
//            }
//        }
//    }
//    states: [
//        State {
//            name: "OPEN"

//            PropertyChanges {
//                target: editView
//                enabled: true
//                opacity: 1
//            }
//        }
//    ]



//}

