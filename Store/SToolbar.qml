import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

import "../Common"
import "../Common/sizes.js" as Size
import "../Common/palette.js" as Palette

Rectangle {
        id: itemBody

        property bool shadow: false
        property var model

        anchors.right: parent.right
        anchors.left: parent.left
        height: Size.SUBTOOLBAR
        color: Palette.PAGE
        z: 99

        signal listPressed

//        ComboBox {
//            id: category
//            anchors {left: parent.left; leftMargin: Size.MARGIN; right: parent.right; rightMargin: Size.MARGIN; verticalCenter: parent.verticalCenter}
//            onCurrentIndexChanged: store.setFilterType(itemTypeModel.value(currentIndex))
//        }

        Rectangle {
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
            height: Size.BORDER
            color: Palette.BORDER
            opacity: 0.5
        }

        RowLayout {
            spacing: Size.MARGIN_HALF
            anchors {fill: parent; leftMargin: Size.MARGIN; rightMargin: Size.MARGIN}
            Item {
                id: searchLabel
                height: parent.height
                Layout.fillWidth: true
                VButton {
                    id: searchLabelIcon
                    width: Size.ICON
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    icon: searchInput.text.length == 0? "image://icons/#5B85AA/search": "image://icons/times"
                    onClicked: {
                        if (searchInput.text.length > 0){
                            searchInput.text = "";
                            searchInput.focus = false;
                        }else{
                            searchInput.focus = true;
                            searchInput.forceActiveFocus();
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
                TextInput{
                    id: searchInput
                    anchors.left: searchLabelIcon.right
                    anchors.leftMargin: Size.MARGIN_HALF
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: "sans"
                    font.pixelSize: Size.FONT_SIZE_BODY
                    selectByMouse: false
                    inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
                    onEditingFinished: {
                        store.setFilterRegExp(text);
                        focus = false;
                    }
                    color: Palette.TEXT
                }
            }
            VButton {
                id: filterButton
                width: Size.ICON_32
                icon: "image://icons/#5B85AA/list"
//                text: "Locks and Passcodes"
                Layout.fillWidth: false
                onClicked: itemBody.listPressed()
            }
        }

//        Rectangle {
//            id: tray
//            anchors.right: parent.right
//            anchors.left: parent.left
//            anchors.top: parent.top
//            height: Size.BORDER
//            color: Palette.BORDER
//            opacity: 0.5
//        }

        Rectangle {
            id: _border
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.bottom
            height: Size.BORDER * 4
            color: Palette.BORDER
            opacity: parent.shadow? 1: 0
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
            Behavior on opacity {NumberAnimation{}}
        }
    }

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
