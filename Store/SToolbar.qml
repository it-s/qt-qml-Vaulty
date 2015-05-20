import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

import "../Common/sizes.js" as Sizes
import "../Common/palette.js" as Palette

Rectangle {
    id: toolbar
    width: 320
    anchors.left: parent.left
    anchors.right: parent.right
    height: Sizes.SUBTOOLBAR
    color: Palette.TOOLBAR
    clip: hidden? true: false;
    property bool shadow: false
    property bool hidden: false

    function hide(){
        hidden = true
    }

    function show(){
        hidden = false
    }

    Behavior on height {NumberAnimation{duration: 100}}

    RowLayout {
        id: content
        anchors.fill: parent
        anchors {leftMargin: Sizes.MARGIN; topMargin: 0; rightMargin: Sizes.MARGIN; bottomMargin: Sizes.MARGIN}
        spacing: Sizes.MARGIN
        ComboBox{
            Layout.fillWidth: true
            model: ItemTypes {
                    id: itemTypeModel
                    Component.onCompleted: insert(0,{text:"All Types",value:-1,icon:""})
                }
            onCurrentIndexChanged: store.setFilterType(itemTypeModel.value(currentIndex))
        }
        TextField {
            Layout.fillWidth: true
            placeholderText: "Filter"
            onTextChanged: store.setFilterRegExp(text)
            selectByMouse: false
            menu: null
            inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText
            onAccepted: focus = false
            onEditingFinished: focus = false
        }
    }
    Rectangle {
        id: _border
        height: Sizes.BORDER * 4
        color: Palette.BORDER
        opacity: 0
        anchors.top: parent.bottom
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
        anchors.right: parent.right
        anchors.left: parent.left
        Behavior on opacity {NumberAnimation{duration: 100}}
    }
    states: [
        State {
            name: "borderShadow"
            when: shadow
            PropertyChanges {
                target: _border
                opacity: 1
            }
        }
    ]

}
