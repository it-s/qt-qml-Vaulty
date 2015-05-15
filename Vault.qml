import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import Qt.labs.settings 1.0

import "Common"
import "Vault"

import "Common/sizes.js" as Size
import "Common/palette.js" as Palette

Page {
    width: 320
    height: 480

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        VToolbar {
            icon: "image://icons/32x32/bars"
            text: "Vaults"
            shadow: vaultsList.contentY > 0
            Layout.fillHeight: false
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
                        source: "image://icons/32x32/lock"
                    }

                    VLabel {
                        text: name
                        color: Palette.LIST_ITEM_TEXT
                    }
                    VLabel {
                        text: description
                        color: Palette.LIST_ITEM_SUBTEXT
                        font.pixelSize: Size.FONT_SIZE_SMALL
                    }
                    onClicked: keyView.open(file)
                    onPressAndHold: editView.edit({
                                                      name: name,
                                                      description: description,
                                                   callback: callback
                                                  });
                    function callback(data){
                        name = data.name;
                        description = data.description;
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

    EditView {
        id: editView
    }

    KeyView {
        id: keyView
    }
}
