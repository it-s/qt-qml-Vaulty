import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

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

    function open(){
        //Open code here
        state = "OPEN"
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
        _editing = null;
        clear();
        state = ""
    }

    Rectangle
    {
        id: pageOverlay
        color: "#000"
        anchors.fill: parent
        opacity: 0.8
        MouseArea{
            anchors.fill: parent
            onClicked: if (mouse.y < pageView.y || mouse.y > pageView.y + pageView.height) overView.close();
        }
    }


    Rectangle
    {
        id: pageView
        color: "#fff"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.left: parent.left
        height: childrenRect.height + 24*2

        Column
        {
            anchors.rightMargin: 15
            anchors.leftMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 24
            spacing: 10
            anchors.left: parent.left
            anchors.right: parent.right

                Column
                {
                    id: pageBody
                    spacing: 10
                    anchors.left: parent.left
                    anchors.right: parent.right

                    //Overlay body

                }

            Rectangle
            {
                height: 1
                color: "#eee"
                anchors.left: parent.left
                anchors.right: parent.right
            }
            RowLayout
            {
                id: pageFooter
                anchors.left: parent.left
                anchors.right: parent.right
                Button{
                    text: "Cancel"
                    Layout.alignment: Qt.AlignRight
                    onClicked: overView.close();
                }
                Button{
                    text: "Save"
                    Layout.alignment: Qt.AlignRight
                    onClicked: overView.save();
                }
            }
        }
    }

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
