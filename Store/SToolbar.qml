import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

import "../Common"
import "../Common/sizes.js" as Size
import "../Common/palette.js" as Palette

Rectangle {
    id: itemBody

    property bool shadow: false
    property alias filterText: searchInput.text
    property int filterType: -1
    property alias typePickerText: typePickerLabel.text

    anchors.right: parent.right
    anchors.left: parent.left
    height: Size.SEARCHBAR
    color: Palette.SEARCHBAR
    z: 99

    signal filterTextEntered
    signal typeFilterPressed
    signal typeFilterCleared

    onFilterTextChanged:
        app.stashSet("filterText", filterText);
    onFilterTypeChanged:
        app.stashSet("filterType", filterType);
    onTypePickerTextChanged:
        app.stashSet("typePickerText", typePickerText);

    Component.onCompleted: {
        filterText = app.stashGet("filterText", "");
        filterType = app.stashGet("filterType", -1);
        typePickerText = app.stashGet("typePickerText", "");
    }


    //        ComboBox {
    //            id: category
    //            anchors {left: parent.left; leftMargin: Size.MARGIN; right: parent.right; rightMargin: Size.MARGIN; verticalCenter: parent.verticalCenter}
    //            onCurrentIndexChanged: store.setFilterType(itemTypeModel.value(currentIndex))
    //        }
//    Rectangle {
//        anchors.right: parent.right
//        anchors.left: parent.left
//        anchors.top: parent.top
//        height: Size.BORDER
//        color: Palette.BORDER
//        opacity: 0.5
//    }

    MouseArea{
        //No click throughts
        anchors.fill: parent
    }

    Item {
        id: searchLabel
        height: parent.height
        anchors.right: typeFilter.left
        anchors.left: parent.left
        anchors.leftMargin: Size.MARGIN
        Layout.fillWidth: true
        VButton {
            id: searchLabelIcon
            width: Size.ICON
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            icon: searchInput.text.length
                  == 0 ? "image://icons/#5B85AA/20x20/search" : "image://icons/times"
            onClicked: {
                if (searchInput.text.length > 0) {
                    searchInput.text = ""
                    searchInput.focus = false
                    itemBody.filterTextEntered()
                } else {
                    searchInput.focus = true
                    searchInput.forceActiveFocus()
                }
            }
        }
        VLabel {
            id: searchLabelTitle
            text: "Search by title"
            anchors.left: searchLabelIcon.right
            anchors.leftMargin: Size.MARGIN_HALF
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            color: Palette.LIST_ITEM_TITLE
            lineHeight: 1
            visible: searchInput.text.length == 0 && !searchInput.focus
        }
        TextInput {
            id: searchInput
            anchors.left: searchLabelIcon.right
            anchors.leftMargin: Size.MARGIN_HALF
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            font.family: "sans"
            font.pixelSize: Size.FONT_SIZE_BODY
            selectByMouse: false
            inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
            onEditingFinished: finishEditing()
            color: Palette.TEXT
            onTextChanged: {
                if (focus)
                    searchInputTimeout.restart();
            }
            onFocusChanged: {
                if (focus) searchInputTimeout.start();
                else searchInputTimeout.stop();
            }
            function finishEditing(){
                focus = false;
                itemBody.filterTextEntered();
            }
        }
        Timer {
            id: searchInputTimeout
            interval: 3000
            onTriggered: searchInput.finishEditing()
        }
    }
    Rectangle {
        id: typeFilter
        width: typePickerLabel.text.length > 0 ? U.px(90) : Size.ICON
        height: Size.ICON
        color: Palette.ACCENT2
        radius: Size.BUTTON_RADIUS
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: Size.MARGIN

        Behavior on width {
            NumberAnimation {
                duration: 100
            }
        }

        VLabel {
            id: typePickerLabel
            anchors.leftMargin: Size.MARGIN_HALF
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Size.FONT_SIZE_SMALL
            font.capitalization: Font.AllLowercase
            lineHeight: 1
            color: Palette.WHITE
            anchors.right: typePickerIcon.left
            anchors.left: parent.left
        }

        MouseArea {
            anchors.fill: parent
            onClicked: itemBody.typeFilterPressed();
        }

        VButton {
            id: typePickerIcon
            width: Size.ICON
            height: width
            anchors.right: parent.right
            icon: typePickerLabel.text.length
                  == 0 ? "image://icons/light/16x16/list" : "image://icons/light/16x16/times"
            onClicked: {
                if (typePickerLabel.text.length > 0){
                    typePickerLabel.text = "";
                    itemBody.filterType = -1;
                    itemBody.typeFilterCleared();
                }else
                    itemBody.typeFilterPressed();
            }
        }
    }

    Rectangle {
        id: _border
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.bottom
        height: Size.BORDER * 4
        color: Palette.BORDER
        opacity: parent.shadow ? 1 : 0
        gradient: Gradient {
            GradientStop {
                id: gradientStop2
                position: 0
                color: Palette.BORDER
            }

            GradientStop {
                id: gradientStop1
                position: 1
                color: "#00000000"
            }
        }
        Behavior on opacity {
            NumberAnimation {
            }
        }
    }
}

//import QtQuick 2.4
//import QtQuick.Controls 1.2
//import QtQuick.Layouts 1.1

//import "../Common"
//import "../Common/sizes.js" as Sizes
//import "../Common/palette.js" as Palette

//Rectangle {
//    id: toolbar
//    width: 320
//    anchors.left: parent.left
//    anchors.right: parent.right
//    height: Sizes.SUBTOOLBAR
//    color: Palette.PAGE
//    clip: hidden? true: false;
//    property bool shadow: false
//    property bool hidden: false

//    function reset() {
//        category.currentIndex = 0;
//        filter.text = "";
//    }

//    function hide(){
//        hidden = true
//    }

//    function show(){
//        hidden = false
//    }

//    Behavior on height {NumberAnimation{duration: 100}}

//    RowLayout {
//        id: content
//        anchors.fill: parent
//        anchors {leftMargin: Sizes.MARGIN; rightMargin: Sizes.MARGIN;}
//        spacing: Sizes.MARGIN
//        ComboBox{
//            id: category
//            anchors.verticalCenter: parent.verticalCenter
//            Layout.fillWidth: true
//            model: ItemTypes {
//                    id: itemTypeModel
//                    Component.onCompleted: insert(0,{text:"All Types",value:-1,icon:""})
//                }
//            onCurrentIndexChanged: store.setFilterType(itemTypeModel.value(currentIndex))
//        }
//        TextField {
//            id: filter
//            anchors.verticalCenter: parent.verticalCenter
//            Layout.fillWidth: true
//            placeholderText: "Filter"
//            onTextChanged: store.setFilterRegExp(text)
//            selectByMouse: false
//            menu: null
//            inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
//            onAccepted: focus = false
//            onEditingFinished: focus = false
//            VButton {
//                width: Sizes.ICON
//                height: width
//                icon: "image://icons/16x16/times"
//                anchors.right: parent.right
//                onClicked: parent.text = ""
//                visible: parent.text.length > 0
//            }
//        }
//    }
//    Rectangle {
//        id: _border
//        height: Sizes.BORDER * 4
//        color: Palette.BORDER
//        opacity: 0
//        anchors.top: parent.bottom
//        gradient: Gradient {
//            GradientStop {
//                id: gradientStop2
//                position: 0
//                color: Palette.BORDER
//            }

//            GradientStop {
//                id: gradientStop1
//                position: 1
//                color: "#00000000"
//            }
//        }
//        anchors.right: parent.right
//        anchors.left: parent.left
//        Behavior on opacity {NumberAnimation{duration: 100}}
//    }
//    states: [
//        State {
//            name: "borderShadow"
//            when: shadow
//            PropertyChanges {
//                target: _border
//                opacity: 1
//            }
//        }
//    ]

//}
