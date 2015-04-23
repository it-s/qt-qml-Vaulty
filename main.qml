import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import Qt.labs.settings 1.0

ApplicationWindow {
    id: app
    width: 320
    height: 480

    visible: true

    property var pages: {
                "VaultList":    Qt.resolvedUrl("/VaultList.qml"),
                "Store":        Qt.resolvedUrl("/Store.qml"),
    }

    StackView {
        id: stack
        anchors.fill: parent
        // Implements back key navigation
        focus: true

        Keys.onReleased: {
            if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
                event.accepted = currentItem.back();
            }
            if (event.key === Qt.Key_Menu || event.key === Qt.Key_Meta ) {
                event.accepted = currentItem.menu();
            }
        }

        initialItem: app.pages["VaultList"]

        delegate: StackViewDelegate {

            replaceTransition: StackViewTransition {
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            Qt.inputMethod.hide(); //Hide all input methods
                            if (exitItem) exitItem.hide();
                            enterItem.show()
                            if (exitItem) exitItem.enabled = false
                        }
                    }
                    PropertyAnimation {
                        duration: enterItem.pageTransitionDuration
                        target: enterItem
                        property: "x"
                        from: enterItem.width
                        to: 0
                    }
                    ScriptAction {
                        script: {
                            if (exitItem) exitItem.hidden()
                            enterItem.shown()
                        }
                    }
                }
            }

            pushTransition: StackViewTransition {
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            Qt.inputMethod.hide(); //Hide all input methods
                            if (exitItem) exitItem.hide();
                            enterItem.show()
                            if (exitItem) exitItem.enabled = false
                        }
                    }
                    PropertyAnimation {
                        duration: enterItem.pageTransitionDuration
                        target: enterItem
                        property: "x"
                        from: enterItem.width
                        to: 0
                    }
                    ScriptAction {
                        script: {
                            if (exitItem) exitItem.hidden()
                            enterItem.shown()
                        }
                    }
                }
            }

            popTransition: StackViewTransition {
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            Qt.inputMethod.hide(); //Hide all input methods
                            exitItem.hide()
                            enterItem.show()
                            enterItem.enabled = true
                        }
                    }
                    PropertyAnimation {
                        duration: enterItem.pageTransitionDuration
                        target: exitItem
                        property: "x"
                        to: enterItem.width
                        from: 0
                    }
                    ScriptAction {
                        script: {
                            exitItem.hidden()
                            enterItem.shown()
                        }
                    }
                }
            }
        }
    }


}
