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
            height: U.px(64)
            z: 1
            Layout.fillWidth: true
            RowLayout {
                anchors.fill: parent
                ToolButton {
                    text: "Vaulty"
                    tooltip: "Return to vault selector"
                    onClicked: app.goBack()
                    Layout.fillHeight: true
                    iconSource: "image://icons/chevronleft"
                }
                ToolButton {
                    tooltip: "Add new item"
                    onClicked: editView.open()
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight
                    iconSource: "image://icons/pluscircle"
                }
            }
        }
        Rectangle {
            height: U.px(32)
            Layout.fillWidth: true
            color: "white"
            z: 1
            RowLayout{
                anchors.fill: parent

                ComboBox{
                    Layout.fillWidth: true
                    model: ItemTypes{
                            id: itemTypeModel
                            Component.onCompleted: insert(0,{text:"All Types",value:-1})
                        }
                    onCurrentIndexChanged: store.setFilterType(itemTypeModel.value(currentIndex))
                }
                TextField {
                    Layout.fillWidth: true
                    placeholderText: "Filter"
                    onTextChanged: store.setFilterRegExp(text)
                }

            }
        }
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "gray"
            z: 1
        }
        Item {
            height: U.px(15)
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                id: vaultsList
                anchors.rightMargin: U.px(16)
                anchors.leftMargin: U.px(16)
                anchors.fill: parent
                delegate: ListItem {
                    onClicked: cardView.show(toJSON());
                    onPressAndHold: editView.edit(ID);
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
                        font.pixelSize: U.px(20)
                    }
                }
                model: store
            }
        }
    }
    ItemStyles{
        id: itemStyleModel
    }

    CardView{
        id: cardView
    }

    EditView{
        id: editView
    }

//    Component.onCompleted: {
//        var t = "Test string";
//        console.log(t);
//        var c = store.encode(t);
//        console.log(c);
//        console.log(store.decode(c));
//    }
}
