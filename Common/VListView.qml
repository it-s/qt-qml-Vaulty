import QtQuick 2.4

ListView {
    id: listView
    boundsBehavior: Flickable.DragOverBounds
    headerPositioning: ListView.PullBackHeader

//    property bool draggingUp: draggingVertically && horizontalVelocity < 0
//    property bool draggingDown: draggingVertically && horizontalVelocity > 0
}

