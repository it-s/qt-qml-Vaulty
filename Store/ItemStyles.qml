import QtQuick 2.0

import "../Common/palette.js" as Palette

ListModel{
    id: model

    function index(value){
        for(var i=0; i < count; i++){
            if (model.get(i).value == value) return i;
        }
        return 0;
    }

    function name(value){
        var i = model.index(value);
        return model.get(i).text;
    }

    function value(index){
        return model.get(index).value;
    }

    function color(value){
        var i = model.index(value);
        return model.get(i).color;
    }

    ListElement {
        value: 0
        text: "None"
        preview: ""
        color: "#5B85AA"
    }
    ListElement {
        value: 1001
        text: "White"
        preview: ""
        color: "#fff"
    }
    ListElement {
        value: 1002
        text: "Black"
        preview: ""
        color: "#2c1b11"
    }
    ListElement {
        value: 1003
        text: "Red"
        preview: ""
        color: "#d20607"
    }
    ListElement {
        value: 1004
        text: "Yellow"
        preview: ""
        color: "#eef207"
    }
    ListElement {
        value: 1005
        text: "Orange"
        preview: ""
        color: "#feae01"
    }
    ListElement {
        value: 1006
        text: "Green"
        preview: ""
        color: "#577d58"
    }
    ListElement {
        value: 1007
        text: "Emerald"
        preview: ""
        color: "#0ec8bb"
    }
    ListElement {
        value: 1008
        text: "Aqua"
        preview: ""
        color: "#0ec8bb"
    }
    ListElement {
        value: 1009
        text: "Blue"
        preview: ""
        color: "#0084c2"
    }
    ListElement {
        value: 1010
        text: "Purple"
        preview: ""
        color: "#532b71"
    }
}
