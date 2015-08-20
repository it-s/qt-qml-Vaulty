import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "../Common"

import "../Common/sizes.js" as Sizes
import "../Common/palette.js" as Palette
import "../Common/icons.js" as Icons

OverView {
    id: editView

    saveButtonText: ""
    closeButtonText: "Close"

    onStateChanged: itemTitle.focus = true

    function clear(){
//        itemType.currentIndex = 0;
//        itemStyle.currentIndex = 0;
        itemTitle.text = "";
        itemLogin.text = "";
        itemNumber.text = "";
        itemPass.text = "";
        itemPin.text = "";
        itemRelate.text = "";
        itemDescription.text = "";
        showHidden.toggled = false;
    }

    function show(item){
        //Edit code here

//            itemType.currentIndex = itemTypeModel.index(item.type);
//            itemStyle.currentIndex = itemStyleModel.index(item.style);
        itemTitle.text = item.title;
        itemLogin.text = item.login;
        itemNumber.text = item.number;
        itemPass.text = item.password;
        itemPin.text = item.pin;
        itemRelate.text = item.relate;
        itemDescription.text = item.description;
        open();
    }

    VListHeader {
        id: itemTitle
        state: "borderNone"
        anchors.left: parent.left
        anchors.right: parent.right
        suffix: VButton {
            id: showHidden
            width: Sizes.ICON_32
            visible: itemPass.visible || itemPin.visible
            icon: toggled? Icons.UI_VISIBILITY_ON: Icons.UI_VISIBILITY_OFF
            property bool toggled: false
            onClicked: {
                if (toggled){
                    itemPass.masktext();
                    itemPin.masktext();
                    toggled = false;
                }else{
                    itemPass.revealtext();
                    itemPin.revealtext();
                    toggled = true;
                }
            }
        }
    }
    CardItem {id: itemNumber; description: "Account number:";}
    CardItem {id: itemLogin; description: "Login:";}
    CardItem {id: itemPass; description: "Password:"; masked: true;}
    CardItem {id: itemPin; description: "Pin Number:"; masked: true;}
    CardItem {id: itemRelate; description: "Service URL:"; isURL: true; }
    CardItem {id: itemDescription; description: "Additional notes:"; multiline: true;}

}
