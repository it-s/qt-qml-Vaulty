import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import Qt.labs.settings 1.0

import "Common"
import "Vault"

Page {
    width: 320
    height: 480

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        ToolBar {
            height: 64
            Layout.fillWidth: true
            RowLayout {
                anchors.fill: parent
                ToolButton {
                    text: "Vaulty"
                    tooltip: "Configure application"
                }

                ToolButton {
                    text: "Add"
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
                delegate: ListItem {
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
