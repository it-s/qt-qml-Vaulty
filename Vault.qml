import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.2

import "Common"
import "Vault"

import "Common/sizes.js" as Size
import "Common/palette.js" as Palette
import "Common/icons.js" as Icons

Page {
    id: page
    width: 320
    height: 480

    color: Palette.THEME

    property alias openVaultID: keyView.openVaultID

    function back(){
        return false;
    }

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        VToolbar {
            theme: Palette.TOOLBAR.THEME
            shadow: true
            icon: Icons.UI_MENU
            text: "Vaults"
//            shadow: vaultsList.contentY > 0
            Layout.fillHeight: false
            VToolbarButton {
                icon: Icons.UI_ADD
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
                boundsBehavior: Flickable.DragOverBounds

                delegate: VListItem {

                    state: (parent.count - 1) == index? "borderNone": ""

                    prefix: Icon {
                        name: page.openVaultID==ID? Icons.UI_LOCK_OFF: Icons.UI_LOCK_ON
                        size: Size.ICON_32
                        color: Palette.WHITE
                    }

                    VLabel {
                        text: title
                        color: Palette.WHITE
                    }
                    VLabel {
                        text: description
                        color: Palette.ACCENT4
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
}
