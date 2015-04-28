import QtQuick 2.0

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
        return model.get(i).text
    }

    function value(index){
        return model.get(index).value
    }

    ListElement {
        value: 0
        text: "None"
        preview: ""
    }
    ListElement {
        value: 1001
        text: "White"
        preview: ""
    }
    ListElement {
        value: 1002
        text: "Black"
        preview: ""
    }
    ListElement {
        value: 1003
        text: "Red"
        preview: ""
    }
    ListElement {
        value: 1004
        text: "Yellow"
        preview: ""
    }
    ListElement {
        value: 1005
        text: "Orange"
        preview: ""
    }
    ListElement {
        value: 1006
        text: "Green"
        preview: ""
    }
    ListElement {
        value: 1007
        text: "Emerald"
        preview: ""
    }
    ListElement {
        value: 1008
        text: "Aqua"
        preview: ""
    }
    ListElement {
        value: 1009
        text: "Blue"
        preview: ""
    }
    ListElement {
        value: 1010
        text: "Purple"
        preview: ""
    }
}
