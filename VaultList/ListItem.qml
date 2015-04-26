import QtQuick 2.4

Item {
    width: parent.width
    height: 64
    signal clicked
    Column {
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
    MouseArea {
        anchors.fill: parent
        onClicked: app.openStore(file);
    }
}

