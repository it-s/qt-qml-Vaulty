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


        VToolbar {
            id: toolbar
            icon: "image://icons/chevronleft"
            text: "Vaults"
            anchors.top: parent.top
            onAction: app.goBack()
            VToolbarButton {
                icon: "image://icons/32x32/pluscircle"
                Layout.alignment: Qt.AlignRight
                onClicked: app.goToPage("StoreEditor");//editView.open()
            }
        }
        SToolbar{
            id: filterBar
            anchors.top: toolbar.bottom
            shadow: vaultsList.contentY > 0
        }

        ListView {
            id: vaultsList
            clip: true
            anchors.top: filterBar.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left

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
                onAction: store.remove(ID)
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

        VLabel{
            color: Palette.HEAD
            font.pixelSize: Size.FONT_SIZE_DISPLAY
            anchors.centerIn: parent
            text: "Empty Store"
            visible: vaultsList.count == 0
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

}
