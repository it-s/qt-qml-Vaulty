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
                    Layout.fillHeight: true
                }
                ToolButton {
                    text: "Add"
                    tooltip: "Add new item"
                    onClicked: editView.open()
                    Layout.fillHeight: true
                }
                TextField {
                    placeholderText: "Filter"
                    onTextChanged: store.setFilterRegExp(text)
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
        ToolBar{
            height: 24
            Layout.fillWidth: true
            ComboBox{
                anchors.fill: parent
                model: ItemTypes{
                        id: itemTypeModel
                        Component.onCompleted: insert(0,{text:"All Types",value:-1})
                    }
                onCurrentIndexChanged: store.setFilterType(itemTypeModel.value(currentIndex))
//                Component.onCompleted: {model.insert(0,{text:"All Types",value:-1});currentIndex=0}
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
//                    onPressAndHold: editView.edit({
//                                                      type: type,
//                                                      style: style,
//                                                      title: title,
//                                                      login: login,
//                                                      number: number,
//                                                      password: password,
//                                                      pin: pin,
//                                                      relate: relate,
//                                                      description: description,
//                                                   callback: callback
//                                                  });
//                    function callback(data){
//                        type = data.type || 0;
//                        style = data.style || 0;
//                        title = data.title;
//                        login = data.login || "";
//                        number = data.number || "";
//                        password = data.password || "";
//                        pin = data.pin || "";
//                        relate = data.relate || "";
//                        description = data.description || "";
//                    }
                    onPressAndHold: app.goToPage("Item", {
                                         type: type,
                                        style: style,
                                        title: title,
                                        login: login,
                                        number: number,
                                        password: password,
                                        pin: pin,
                                        relate: relate,
                                        description: description
                                  });
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
    ItemStyles{
        id: itemStyleModel
    }

    EditView{
        id: editView
    }
}
