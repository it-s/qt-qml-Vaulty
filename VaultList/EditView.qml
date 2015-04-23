import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

Item
{
    id: editView
    anchors.fill: parent

    property int rowID

    Rectangle
    {
        id: pageOverlay
        color: "#000"
        anchors.fill: parent
        opacity: 0.8
    }



}

