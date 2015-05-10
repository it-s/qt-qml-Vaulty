import QtQuick 2.4

MouseArea {
    width: parent.width
    height: U.px(64)

    function toJSON(callback){
        return {
            type: type,
            style: style,
            title: title,
            login: login,
            number: number,
            password: password,
            pin: pin,
            relate: relate,
            description: description,
            callback: callback
        }
    }

    Column {
        anchors.bottomMargin: U.px(16)
        anchors.topMargin: U.px(16)
        anchors.fill: parent
        spacing: U.px(10)
        Text {
            text: title
            font.bold: true
        }
        Text {
            text: number
            font.bold: true
            visible: number != ""
        }
        Rectangle{
            width: parent.width
            height: U.px(1)
            color: "silver"
        }
    }
}

