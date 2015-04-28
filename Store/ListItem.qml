import QtQuick 2.4

MouseArea {
    width: parent.width
    height: 64

    Column {
        anchors.bottomMargin: 16
        anchors.topMargin: 16
        anchors.fill: parent
        spacing: 10
        Text {
            text: title
            font.bold: true
        }
        Text {
            text: number
            font.bold: true
            visible: number != ""
        }
    }
}

