import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import Qt.labs.settings 1.0

import "Common"
import "Store"

Page {
    width: 320
    height: 480

    onHidden: store.close()

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        ToolBar {
            height: 64
            Layout.fillWidth: true
            RowLayout {
                anchors.fill: parent
                ToolButton {
                    text: "<"
                    tooltip: "Return to vault selector"
                    onClicked: app.goBack()
                }
                ToolButton {
                    text: "Add"
                    tooltip: "Add new item"
                    onClicked: editView.open()
                }
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                id: vaultsList
                anchors.rightMargin: 16
                anchors.leftMargin: 16
                anchors.fill: parent
                delegate: ListItem {}
                model: store
            }
        }
    }

    EditView{
        id: editView
    }
}
