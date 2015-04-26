import QtQuick 2.4

Rectangle {
    width: 100
    height: 62
    signal clicked
    Column {
        anchors.bottomMargin: 16
        anchors.topMargin: 16
        anchors.fill: parent
        spacing: 10
        Text {
            text: title
            font.bold: true
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}

