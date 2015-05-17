import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "../Common"

import "../Common/sizes.js" as Sizes
import "../Common/palette.js" as Palette

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
                        icon: "image://icons/eye"
                        onClicked: {
                            itemPass.text = store.decode(itemPass.text);
                            itemPin.text = store.decode(itemPin.text);
                            enabled = false;
                        }
                    }
    }
    CardItem {id: itemNumber; description: "Account number:";}
    CardItem {id: itemLogin; description: "Login:";}
    CardItem {id: itemPass; description: "Password:";}
    CardItem {id: itemPin; description: "Pin Number:";}
    CardItem {id: itemRelate; description: "Service URL:";}
    CardItem {id: itemDescription; description: "Additional notes:";}


}
