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
                TextField {
                    placeholderText: "Filter"
                    onTextChanged: store.setFilterRegExp("^"+text)
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
                delegate: ListItem {
//                    onClicked: app.openStore(file);
                    onPressAndHold: editView.edit({
                                                      type: type,
                                                      style: style,
                                                      title: title,
                                                      login: login,
                                                      number: number,
                                                      password: password,
                                                      pin: pin,
                                                      relate: relate,
                                                      description: description,
                                                   callback: callback
                                                  });
                    function callback(data){
                        type = data.type || 0;
                        style = data.style || 0;
                        title = data.title;
                        login = data.login || "";
                        number = data.number || "";
                        password = data.password || "";
                        pin = data.pin || "";
                        relate = data.relate || "";
                        description = data.description || "";
                    }
                }
                section.property: "type"
                section.criteria: ViewSection.FullString
                section.delegate:  Rectangle {
                    width: parent.width
                    height: childrenRect.height
                    color: "lightsteelblue"
                    Text {
                        text: itemTypeModel.name(section)
                        font.bold: true
                        font.pixelSize: 20
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: store.setFilterType(section)
                    }
                }
                model: store
            }
        }
    }
    ItemTypes{
        id: itemTypeModel
    }
    ItemStyles{
        id: itemStyleModel
    }

    EditView{
        id: editView
    }
}
