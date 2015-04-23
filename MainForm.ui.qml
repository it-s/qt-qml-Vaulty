import QtQuick 2.3

Rectangle {
    property alias mouseArea: mouseArea

    width: 360
    height: 360

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        ListView {
            id: listView1
            anchors.fill: parent
            delegate: Item {
                x: 5
                width: 80
                height: 40
                Row {
                    id: row1
                    spacing: 10
                    Text {
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                        MouseArea{
                            anchors.fill: parent
                            onDoubleClicked: vaults.remove(index)
                        }
                    }
                    Text {
                        text: description
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                        MouseArea{
                            anchors.fill: parent
                            onDoubleClicked: {
                                name = name + Math.random(100)*150;
                                description = description + Math.random(100)*150;
                            }
                        }
                    }
                }
            }
            model: vaults
        }
    }
}
