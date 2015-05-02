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
                "Vault":    Qt.resolvedUrl("/Vault.qml"),
                "Store":    Qt.resolvedUrl("/Store.qml"),
                "Item":    Qt.resolvedUrl("/Item.qml"),
    }

    property var _intent

    property bool firstRun: true

    //---------------------------
    //Application global functions
    //---------------------------

    function isFirstRun(){
        return firstRun;
    }

    function setIntent(intent){
        if (intent) _intent = intent;
    }

    function getIntent(){
        return _intent;
    }

    function clearIntent(){
        _intent = null;
    }

    /**
     * Go To Previous Page
     */
    function goBack(intent){
        setIntent(intent);
        if (stack.depth > 1) stack.pop();
    }

    /**
     * Go To specific
     * @param page: Page Component
     */
    function goToPage(page, intent){
        setIntent(intent);
        stack.push(pages[page]);
    }

    /*
    -
    - Application settings
    -
    */

    Settings {
        property alias firstRun: app.firstRun
    }

    Component.onCompleted: {
    }

    Component.onDestruction: {
        firstRun = false;
    }

    StackView {
        id: stack
        anchors.fill: parent
        // Implements back key navigation
//        focus: true

//        Keys.onReleased: {
//            if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
//                event.accepted = currentItem.back();
//            }
//            if (event.key === Qt.Key_Menu || event.key === Qt.Key_Meta ) {
//                event.accepted = currentItem.menu();
//            }
//        }

        initialItem: app.pages["Vault"]

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
