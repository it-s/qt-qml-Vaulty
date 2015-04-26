import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

Item
{
    id: editView
    width: 320
    height: 480
    anchors.fill: parent

    property int rowID

    Rectangle
    {
        id: pageOverlay
        color: "#000"
        anchors.fill: parent
        opacity: 0.8
    }

    Rectangle
    {
        id: pageView
        color: "#fff"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.left: parent.left
        height: childrenRect.height

        Column
        {
            anchors.left: parent.left
            anchors.right: parent.right

            Item
            {
                id: pageBody
                anchors.left: parent.left
                anchors.right: parent.right

                Column
                {
                    anchors.left: parent.left
                    anchors.right: parent.right

                }

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
                }
                Button{
                    text: "Save"
                    Layout.alignment: Qt.AlignRight
                }
            }
        }
    }



}

