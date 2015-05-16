import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import Qt.labs.settings 1.0

import "Common"
import "Store"

import "Common/sizes.js" as Size
import "Common/palette.js" as Palette

Page {
    id: page
    width: 320
    height: 480

//    onHidden: store.close()
    property alias title: toolbar.text

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        VToolbar {
            id: toolbar
            icon: "image://icons/chevronleft"
            text: "Vaults"
            shadow: vaultsList.contentY > 0
            Layout.fillHeight: false
            onAction: app.goBack()
            VToolbarButton {
                icon: "image://icons/32x32/pluscircle"
                Layout.alignment: Qt.AlignRight
                onClicked: app.goToPage("StoreEditor");//editView.open()
            }
        }
//        Rectangle {
//            height: U.px(32)
//            Layout.fillWidth: true
//            color: "white"
//            z: 1
//            RowLayout{
//                anchors.fill: parent

//                ComboBox{
//                    Layout.fillWidth: true
//                    model: ItemTypes{
//                            id: itemTypeModel
//                            Component.onCompleted: insert(0,{text:"All Types",value:-1})
//                        }
//                    onCurrentIndexChanged: store.setFilterType(itemTypeModel.value(currentIndex))
//                }
//                TextField {
//                    Layout.fillWidth: true
//                    placeholderText: "Filter"
//                    onTextChanged: store.setFilterRegExp(text)
//                }

//            }
//        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                id: vaultsList
                anchors.fill: parent
                delegate: VListItem {
                    border: index < (vaultsList.count - 1)
                    state: ListView.section !== ListView.nextSection? "borderShadow": ""
                    prefix: Image {
                        source: itemTypeModel.icon(type)
                    }
                    VLabel {
                        text: title
                        color: Palette.LIST_ITEM_TEXT
                    }
                    VLabel {
                        text: number.length ? number : login
                        color: Palette.LIST_ITEM_SUBTEXT
                        font.pixelSize: Size.FONT_SIZE_SMALL
                    }
                    onClicked: cardView.show({
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
                    onPressAndHold: app.goToPage("StoreEditor", {title: title, storeID: ID});//editView.edit(ID);
                }
                section.property: "type"
//                section.labelPositioning: ViewSection.CurrentLabelAtStart
                section.criteria: ViewSection.FullString
                section.delegate: VListSection {
                    state: "borderNone"
                    text: itemTypeModel.name(section)
                }
                model: store
            }
        }
    }
    ItemTypes {
        id: itemTypeModel
        Component.onCompleted: insert(0,{text:"All Types",value:-1})
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

}
