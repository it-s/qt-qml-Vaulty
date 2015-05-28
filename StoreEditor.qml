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
            type: itemType.currentIndex,
            style: itemStyle.currentIndex,
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
            app.toast("Saved");
        }else if (itemTitle.text != ""){
            store.add(data);
            app.toast("Added");
        }
        app.goBack();
    }

    onShow: {
        if (storeID !== ""){
            var v = store.get(storeID);
            itemType.currentIndex = v.type;
            itemStyle.currentIndex = v.style;
            itemTitle.text = v.title;
            itemLogin.text = v.login;
            itemNumber.text = v.number;
            itemPass.text = v.password;
            itemPin.text = v.pin;
            itemRelate.text = v.relate;
            itemDescription.text = v.description;
        }
    }

    onShown: {
        itemTitle.focus = true;
        itemTitle.forceActiveFocus();
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
//            shadow: true
//            color: Palette.BLANK
            textColor: Palette.TITLE
//            shadow: flickable.contentY > 0
            Layout.fillHeight: false
            onAction: app.goBack()
            VButton {
                text: "save"
                anchors.verticalCenter: parent.verticalCenter
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignRight
                onClicked: page.save()
                enabled: itemTitle.text.length > 0
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

                Item {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Sizes.MARGIN
                    height: itemType.height

                    TextField {
                        id: itemType
                        anchors.left: parent.left
                        anchors.right: parent.right
                        property int currentIndex: 0
                        text: typePicker.getNameByID(0);
                        onCurrentIndexChanged: text = typePicker.getNameByID(currentIndex);
                    }

                    Image {
                        source: "image://icons/16x16/list"
                        anchors.right: parent.right
                        anchors.rightMargin: Sizes.MARGIN_HALF
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: typePicker.open(itemType.currnetIndex)
                    }
                }

//                RowLayout {
//                    anchors.right: parent.right
//                    anchors.left: parent.left

//                    spacing: Sizes.MARGIN_HALF

//                    SLabel {
//                        text: qsTr("Service type:")
//                        Layout.fillWidth: false
//                        lineHeight: 1
//                        anchors.verticalCenter: parent.verticalCenter
//                    }

//                    VLabel {
//                        id: itemType
//                        Layout.fillWidth: true
//                        anchors.verticalCenter: parent.verticalCenter
//                        property int currentIndex: 0
//                        onCurrentIndexChanged: text = typePicker.getNameByID(currentIndex);
//                        Image {
//                            source: "image://icons/16x16/caretdown"
//                            anchors.right: parent.right
//                            anchors.verticalCenter: parent.verticalCenter
//                        }
//                        MouseArea{
//                            anchors.fill: parent
//                            onClicked: typePicker.open(itemType.currnetIndex)
//                        }
//                    }
//                }


//                ComboBox {
//                    id: itemType
//                    anchors.right: parent.right
//                    anchors.left: parent.left
//                    anchors.leftMargin: Sizes.MARGIN
//                    currentIndex: itemTypeModel.count - 1
//                    model: ItemTypes{
//                        id: itemTypeModel
//                    }
//                }

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
                        MenuItem {
                            text: "Generate"
                            shortcut: "Ctrl+G"
                            onTriggered: attachedTo.text = Utils.generatePassword()
                        }
                    }
                    VButton {
                        width: Sizes.ICON
                        height: width
                        icon: parent.echoMode == TextInput.Password? "image://icons/eye": "image://icons/eyeslash"
                        anchors.right: parent.right
                        anchors.rightMargin: Sizes.MARGIN_HALF
                        onClicked: parent.echoMode = (parent.echoMode == TextInput.Password? TextInput.Normal: TextInput.Password)
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
                        MenuItem {
                            text: "Generate"
                            shortcut: "Ctrl+G"
                            onTriggered: attachedTo.text = Utils.generatePin()
                        }
                    }
                    VButton {
                        width: Sizes.ICON
                        height: width
                        icon: parent.echoMode == TextInput.Password? "image://icons/eye": "image://icons/eyeslash"
                        anchors.right: parent.right
                        anchors.rightMargin: Sizes.MARGIN_HALF
                        onClicked: parent.echoMode = (parent.echoMode == TextInput.Password? TextInput.Normal: TextInput.Password)
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


                Item {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Sizes.MARGIN
                    height: itemType.height

                    TextField {
                        id: itemStyle
                        anchors.left: parent.left
                        anchors.right: parent.right
                        property int currentIndex: 0
                        text: colorPicker.getNameByID(0);
                        onCurrentIndexChanged: text = colorPicker.getNameByID(currentIndex);
                    }

                    Image {
                        source: "image://icons/16x16/list"
                        anchors.right: parent.right
                        anchors.rightMargin: Sizes.MARGIN_HALF
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: colorPicker.open(itemStyle.currnetIndex)
                    }
                }
//                ComboBox {
//                    id: itemStyle
//                    property int value: 0
//                    anchors.right: parent.right
//                    anchors.left: parent.left
//                    anchors.leftMargin: Sizes.MARGIN
//                    model: ItemStyles {
//                        id: itemStyleModel
//                    }
//                }

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

    VTypePicker{
        id: typePicker
        onSelectionMade: itemType.currentIndex = selection;
    }

    VColorPicker{
        id: colorPicker
        onSelectionMade: itemStyle.currentIndex = selection;
    }
}
