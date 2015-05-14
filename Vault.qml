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

        ToolBar {
            height: Size.TOOLBAR
            Layout.fillWidth: true
            RowLayout {
                anchors.fill: parent
                ToolButton {
                    text: "Vaulty"
                    tooltip: "Configure application"
                    iconSource: "image://icons/bars"
                }

                ToolButton {
                    tooltip: "Add new vault"
                    onClicked: editView.open()
                    Layout.alignment: Qt.AlignRight
                    iconSource: "image://icons/pluscircle"
                }
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                id: vaultsList
                anchors.fill: parent
                header: VListHeader {
                    text: "Vaults"
                }

                delegate: VListItem {
                    prefix: Image {
                        width: 32
                        height: 32
                        source: "image://icons/light/32x32/pluscircle"
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
                model: //vaults
                    ListModel{
                    ListElement {
                        name: "Apple"
                        description: "A green, yellow, or red fruit"
                    }
                    ListElement {
                        name: "Orange"
                        description: "Large orange fruit"
                    }
                    ListElement {
                        name: "Banana"
                        description: "Yellow long and sweet grass"
                    }
                }
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
