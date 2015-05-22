import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.2

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

    function back(){
        if(cardView.isOpen)cardView.close();
        else app.goBack();
        return true;
    }

//    onHidden: filterBar.reset()

    onShow: vaultsList.focus();

    onShown: {
        var header = store.header();
        console.log ("Version: " + header.storeVersion);
        console.log ("Title: " + header.title);
        console.log ("Description: " + header.description);        
    }


    ItemTypes {
        id: itemTypeModel
    }

    ItemStyles{
        id: itemStyleModel
    }


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

        VListView {
            id: vaultsList
            clip: true
            anchors.top: toolbar.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            function focus(){
                positionViewAtIndex(currentIndex, ListView.Beginning);
            }

            header: SToolbar {
                id: filterBar
                shadow: vaultsList.contentY > 0
                onFilterTextEntered: store.filterRegExp(filterText)
                onTypeFilterCleared: store.setFilterType(-1);
                onTypeFilterPressed: typeSelector.open()
            }

            delegate: VListItem {
                stubColor: itemStyleModel.color(style)
                border: index < (vaultsList.count - 1)
                state: ListView.section !== ListView.nextSection? "borderShadow": ""
                prefix: Rectangle{
                    width: U.px(40)
                    height: width
                    radius: width / 2
//                    color: itemStyleModel.color(style)
                    color: Palette.ACCENT3
                    Image {
                        source: itemTypeModel.icon(type)
                        anchors.centerIn: parent
                    }
                }
                VLabel {
                    text: title
                    color: Palette.LIST_ITEM_TEXT
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
                VLabel {
                    text: number.length ? number : login
                    color: Palette.LIST_ITEM_SUBTEXT
                    font.pixelSize: Size.FONT_SIZE_SMALL
                    anchors.left: parent.left
                    anchors.right: parent.right
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
                onPressAndHold: {
                    vaultsList.currentIndex = index;
                    app.goToPage("StoreEditor", {title: title, storeID: ID});//editView.edit(ID);
                }
                onAction:
                    app.msg("Remove " + title, "Are you sure you want to permanently remove this card?", StandardIcon.Warning, StandardButton.No | StandardButton.Yes, function(accepted){
                        console.log ("MSG callback");
                        if (accepted){
                            store.remove(ID);
                            app.toast("Removed");
                        }else
                            deactivate();
                    });
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

    CardView{
        id: cardView
    }

    TypePicker {
        id: typeSelector
    }

}
