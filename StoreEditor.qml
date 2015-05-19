import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "Common"
import "Store"

import "Common/sizes.js" as Sizes
import "Common/palette.js" as Palette

import "Store/utils.js" as Utils

Page {
    id: page
    width: 320
    height: 480
    color: Palette.MODAL

    property string storeID: ""
    property alias title: toolbar.text

    function save(){
        var data = {
            type: itemTypeModel.value(itemType.currentIndex),
            style: itemStyleModel.value(itemStyle.currentIndex),
            title: itemTitle.text,
            login: itemLogin.text,
            number: itemNumber.text,
            password: itemPass.text,
            pin: itemPin.text,
            relate: Utils.cleanURL(itemRelate.text),
            description: itemDescription.text
         };

        if (storeID !== ""){
            store.set(storeID, data);
        }else{
            if (itemTitle.text != "")
                store.add(data);
        }
        app.goBack();
    }

    onShow: {
        if (storeID !== ""){
            var v = store.get(storeID);
            itemType.currentIndex = itemTypeModel.index(v.type);
            itemStyle.currentIndex = itemStyleModel.index(v.style);
            itemTitle.text = v.title;
            itemLogin.text = v.login;
            itemNumber.text = v.number;
            itemPass.text = v.password;
            itemPin.text = v.pin;
            itemRelate.text = v.relate;
            itemDescription.text = v.description;
        }
    }

    onHidden: {
        itemType.currentIndex = 0;
        itemStyle.currentIndex = 0;
        itemTitle.text = "";
        itemLogin.text = "";
        itemNumber.text = "";
        itemPass.text = "";
        itemPin.text = "";
        itemRelate.text = "";
        itemDescription.text = "";
        storeID = "";
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        VToolbar {
            id: toolbar
            icon: "image://icons/times"
            text: "New card"
            shadow: true
//            shadow: flickable.contentY > 0
            Layout.fillHeight: false
            onAction: app.goBack()
            VButton {
                text: "save"
                anchors.verticalCenter: parent.verticalCenter
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignRight
                onClicked: page.save()
                enabled: itemTitle.text != ""
            }
        }

        Flickable {
            id: flickable
            flickableDirection: Flickable.VerticalFlick
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: width
            contentHeight: content.height
            clip: true

            Column {
                id: content
                spacing: Sizes.MARGIN
                anchors.right: parent.right
                anchors.left: parent.left
                anchors {rightMargin: Sizes.MARGIN; leftMargin: Sizes.MARGIN}

                Item {
                    anchors.right: parent.right
                    anchors.left: parent.left
                    height: Sizes.MARGIN
                }

                SLabel {
                    text: qsTr("Service type:")
                }

                ComboBox {
                    id: itemType
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.leftMargin: Sizes.MARGIN
                    currentIndex: itemTypeModel.count - 1
                    model: ItemTypes{
                        id: itemTypeModel
                    }
                }

                SLabel {
                    text: qsTr("Service name:")
                }

                TextField {
                    id: itemTitle
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Sizes.MARGIN
                    placeholderText: qsTr("My Service")
                    menu: VTextEditMenu {
                        attachedTo: itemTitle
                    }
                }

                SLabel {
                    text: qsTr("Service detials:")
                }

                TextField {
                    id: itemNumber
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Sizes.MARGIN
                    placeholderText: qsTr("Account number")
                    inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhNoPredictiveText
                    menu: VTextEditMenu{
                        attachedTo: itemNumber
                    }
                }

                TextField {
                    id: itemLogin
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Sizes.MARGIN
                    placeholderText: qsTr("User name / bank card number")
                    inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
                    menu: VTextEditMenu{
                        attachedTo: itemLogin
                    }
                }

                TextField {
                    id: itemPass
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Sizes.MARGIN
                    placeholderText: qsTr("Password")
                    echoMode: TextInput.Password
                    inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
                    menu: VTextEditMenu{
                        attachedTo: itemPass
                    }
                }

                TextField {
                    id: itemPin
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Sizes.MARGIN
                    placeholderText: qsTr("Pin number")
                    echoMode: TextInput.Password
                    inputMethodHints: Qt.ImhPreferNumbers | Qt.ImhNoPredictiveText
                    menu: VTextEditMenu{
                        attachedTo: itemPin
                    }
                }

                TextField {
                    id: itemRelate
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Sizes.MARGIN
                    placeholderText: qsTr("Service URL")
                    inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
                    menu: VTextEditMenu{
                        attachedTo: itemRelate
                    }
                }

                SLabel {
                    text: qsTr("Style:")
                }

                ComboBox {
                    id: itemStyle
                    property int value: 0
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.leftMargin: Sizes.MARGIN
                    model: ItemStyles {
                        id: itemStyleModel
                    }
                }

                SLabel {
                    text: qsTr("Additional notes:")
                }

                TextArea {
                    id: itemDescription
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.leftMargin: Sizes.MARGIN
                    menu: VTextEditMenu{
                        attachedTo: itemDescription
                    }
                }

                Item {
                    anchors.right: parent.right
                    anchors.left: parent.left
                    height: Sizes.MARGIN
                }

            }
        }
    }
}
