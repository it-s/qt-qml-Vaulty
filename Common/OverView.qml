import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import "sizes.js" as Sizes
import "palette.js" as Palette

Item
{
    id: overView
    width: 320
    height: 480
    anchors.fill: parent
    enabled: false
    opacity: 0

    default property alias _contentChildren: pageBody.data
    property var _editing: null

    property alias title: pageTitle.text
    property string saveButtonText: "Save"
    property string closeButtonText: "Cancel"
    property alias saveButtonEnabled: saveButton.enabled

    function open(){
        //Open code here
        state = "OPEN"
    }

    function opened(){

    }

    function edit(item){
        //Edit code here
        _editing = item;
        open();
    }

    function save(){
        //Save code here
        close();
    }

    function clear(){
        //Clear code here
    }

    function close(){
        state = ""
    }

    function _reset(){
        pageViewWrapper.contentY = 0
        _editing = null;
        clear();
    }

    Rectangle
    {
        id: pageOverlay
        color: Palette.DARK
        anchors.fill: parent
        MouseArea{
            anchors.fill: parent
            onClicked: if (mouse.y < pageViewWrapper.y || mouse.y > pageViewWrapper.y + pageViewWrapper.height) overView.close();
        }
    }


    Flickable {
        id: pageViewWrapper
        width: parent.width
        height: pageView.height > app.height? parent.height: pageView.height

        contentHeight: pageView.height

        flickableDirection: Flickable.VerticalFlick
        interactive: pageView.height > app.height

        anchors.verticalCenter: parent.verticalCenter

        Rectangle
        {
            id: pageView
            color: Palette.PAGE
            width: overView.width
            height: childrenRect.height + Sizes.MARGIN * 3

            Column
            {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: Sizes.MARGIN_DOUBLE
                spacing: Sizes.MARGIN

                VLabel {
                    id: pageTitle
                    font.pixelSize: Sizes.FONT_SIZE_HEADLINE
                    color: Palette.ACCENT3
                    text: ""
                    visible: text != ""
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.rightMargin:Sizes.MARGIN
                    anchors.leftMargin: Sizes.MARGIN
                }

                Column
                {
                    id: pageBody
                    spacing: Sizes.MARGIN
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.rightMargin:Sizes.MARGIN
                    anchors.leftMargin: Sizes.MARGIN

                    //Overlay body

                }

                RowLayout
                {
                    id: pageFooter
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.rightMargin:Sizes.MARGIN
                    anchors.leftMargin: Sizes.MARGIN
                    Item {
                        Layout.fillWidth: true
                    }

                    VButton {
                        id: cancelButton
                        text: overView.closeButtonText
                        onClicked: overView.close();
                        visible: overView.closeButtonText != ""
                        Layout.alignment: Qt.AlignRight
                        Layout.fillWidth: false
                    }
                    VButton {
                        id: saveButton
                        text: overView.saveButtonText
                        onClicked: overView.save();
                        visible: overView.saveButtonText != ""
                        Layout.alignment: Qt.AlignRight
                        Layout.fillWidth: false
                    }
                }
            }
        }
    }

    transitions: [
        Transition {
            from: ""
            to: "OPEN"
            SequentialAnimation{
                NumberAnimation{
                    target: overView
                    properties: "opacity"
                }
                ScriptAction {
                    script: opened();
                }
            }
        },
        Transition {
            from: "OPEN"
            to: ""
            SequentialAnimation{
                NumberAnimation{
                    target: overView
                    properties: "opacity"
                }
                ScriptAction {
                    script:  _reset();
                }
            }
        }
    ]

    states: [
        State {
            name: "OPEN"

            PropertyChanges {
                target: overView
                enabled: true
                opacity: 1
            }
        }
    ]



}
