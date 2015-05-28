import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

import "sizes.js" as Size

OverView {
    id: dialog
    property int selection: -1
    saveButtonText: ""

    signal selectionMade

    function open(selected){
        //Open code here
        selection = selected || -1;
        state = "OPEN"
    }

    function close(){
        state = ""
    }

 }
