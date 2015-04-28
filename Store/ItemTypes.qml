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
        text: "Unknown"
    }
    ListElement {
        value: 1001
        text: "Digital Service"
    }
    ListElement {
        value: 1101
        text: "Web Sites"
    }
    ListElement {
        value: 2001
        text: "Financial Services"
    }
    ListElement {
        value: 2101
        text: "Card Services"
    }
    ListElement {
        value: 3001
        text: "Locks & Codes"
    }
}
