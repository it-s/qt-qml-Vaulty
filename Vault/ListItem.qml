import QtQuick 2.4

MouseArea {
    width: parent.width
    height: 76
    Column {
        anchors.rightMargin: 16
        anchors.leftMargin: 16
        anchors.bottomMargin: 16
        anchors.topMargin: 16
        anchors.fill: parent
        spacing: 10
        Text {
            text: name
            font.bold: true
        }
        Text {
            text: description
        }
    }
    Rectangle {
        height: 1
        color: "#dddddd"
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom

    }
}

