import QtQuick 2.4

MouseArea {
    width: parent.width
    height: U.px(76)
    Column {
        anchors.rightMargin: U.px(16)
        anchors.leftMargin: U.px(16)
        anchors.bottomMargin: U.px(16)
        anchors.topMargin: U.px(16)
        anchors.fill: parent
        spacing: U.px(10)
        Text {
            text: name
            font.bold: true
        }
        Text {
            text: description
        }
    }
    Rectangle {
        height: U.px(1)
        color: "#dddddd"
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom

    }
}

