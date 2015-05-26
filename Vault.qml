import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.2

import "Common"
import "Vault"

import "Common/sizes.js" as Size
import "Common/palette.js" as Palette

Page {
    id: page
    width: 320
    height: 480

    property alias openVaultID: keyView.openVaultID

    function back(){
        if(editView.isOpen)editView.close();
        else if(keyView.isOpen)keyView.close();
        else return false; //Allow android to manage activities
//            app.msg("Close Vaulty", "Are you sure you want to close this app?",StandardIcon.Question, StandardButton.No|StandardButton.Yes, function (accepted){
//            if (accepted) app.suspend();
//        });
        return true;
    }

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        VToolbar {
            icon: "image://icons/bars"
            text: "Vaults"
            shadow: vaultsList.contentY > 0
            Layout.fillHeight: false
            VToolbarButton {
                icon: "image://icons/cog"
                Layout.alignment: Qt.AlignRight
                onClicked: colorPicker.open()
            }
            VToolbarButton {
                icon: "image://icons/cog"
                Layout.alignment: Qt.AlignRight
                onClicked: typePicker.open()
            }
            VToolbarButton {
                icon: "image://icons/32x32/pluscircle"
                Layout.alignment: Qt.AlignRight
                onClicked: editView.open()
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                id: vaultsList
                anchors.fill: parent

                delegate: VListItem {
                    prefix: Image {
                        source: page.openVaultID==ID? "image://icons/32x32/unlock": "image://icons/32x32/lock"
                    }

                    VLabel {
                        text: title
                        color: Palette.LIST_ITEM_TEXT
                    }
                    VLabel {
                        text: description
                        color: Palette.LIST_ITEM_SUBTEXT
                        font.pixelSize: Size.FONT_SIZE_SMALL
                    }
                    onClicked: keyView.open(ID)
                    onPressAndHold: editView.edit(ID)
                    onAction: {
                        app.msg("Remove " + title, "Are you sure you want to permanently remove this vault and all the associated data?", StandardIcon.Warning, StandardButton.Cancel | StandardButton.Yes, function(accepted){
                            console.log ("MSG callback");
                            if (accepted){
                                vaults.remove(ID);
                                app.toast("Removed");
                            }else
                                deactivate();
                        });
                    }
                }
                model: vaults
//                    ListModel{
//                    ListElement {
//                        name: "Apple"
//                        description: "A green, yellow, or red fruit"
//                    }
//                    ListElement {
//                        name: "Orange"
//                        description: "Large orange fruit"
//                    }
//                    ListElement {
//                        name: "Banana"
//                        description: "Yellow long and sweet grass"
//                    }
//                }
            }
        }
    }

    VLabel{
        color: Palette.HEAD
        font.pixelSize: Size.FONT_SIZE_DISPLAY
        anchors.centerIn: parent
        text: "No Valuts"
        visible: vaultsList.count == 0
    }

    EditView {
        id: editView
    }

    KeyView {
        id: keyView
    }

    VTypePicker{
        id: typePicker
    }

    VColorPicker{
        id: colorPicker
    }
}
