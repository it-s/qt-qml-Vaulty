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

    function icon(value){
        var i = model.index(value);
        return model.get(i).icon
    }

    function value(index){
        return model.get(index).value
    }

    ListElement {
        value: 1001
        text: "Online Services"
        icon: "image://icons/light/cloud"
    }
    ListElement {
        value: 1101
        text: "Web Sites"
        icon: "image://icons/light/globe"
    }
    ListElement {
        value: 2001
        text: "Bank Accounts"
        icon: "image://icons/light/university"
    }
    ListElement {
        value: 2101
        text: "Credit Cards"
        icon: "image://icons/light/creditcard"
    }
    ListElement {
        value: 2201
        text: "Memberships"
        icon: "image://icons/light/users"
    }
    ListElement {
        value: 3001
        text: "Locks and Passcodes"
        icon: "image://icons/light/key"
    }
    ListElement {
        value: 0
        text: "Uncategorized"
        icon: "image://icons/light/questioncircle"
    }
}
