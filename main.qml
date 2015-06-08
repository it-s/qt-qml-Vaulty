import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0

import "Common"

ApplicationWindow {
    id: app
    width: 320
    height: 480

    visible: true

    property var _stash: {

    }

    property var pages: {
                "Vault":    Qt.resolvedUrl("/Vault.qml"),
                "Store":    Qt.resolvedUrl("/Store.qml"),
                "StoreEditor": Qt.resolvedUrl("/StoreEditor.qml")
    }

    property bool firstRun: true

    //---------------------------
    //Application global functions
    //---------------------------

    function isFirstRun(){
        return firstRun;
    }

    /**
     * Go To Previous Page
     */
    function goBack(){
        if (stack.depth > 1) stack.pop();
    }

    /**
     * Go To specific
     * @param page: Page Component
     */
    function goToPage(page, properties){
        stack.push(pages[page], properties);
    }

    /**
     * Open message box
     *
     */
    function msg(title, text, icon, buttons, callback) {
        title = title || "Vaulty";
        text = text || "";
        icon = icon || StandardIcon.Information;
        buttons = buttons || StandardButton.Ok;
        callback = callback || function(){};

        messageDialog.title = title;
        messageDialog.text = text;
        messageDialog.icon = icon;
        messageDialog.standardButtons = buttons;
        messageDialog.callback = callback;
        messageDialog.open();
    }

    /**
     * Show toast
     * @param message: Message to show
     */
    function toast(message){
        toaster.displayMessage(message);
    }


    /**
     * Show toast
     * @param message: Message to show
     */
    function stashReset(){
        _stash = {};
    }
    function stashSet(key, value) {
        _stash[key] = value;
    }
    function stashGet(key, def) {
        return _stash[key] || def;
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
        focus: true

        // Implements back key navigation
//        focus: true

        Keys.onReleased: {
            if (event.key === Qt.Key_Back || event.key === Qt.Key_Escape) {
                event.accepted = currentItem.back();
            }
            if (event.key === Qt.Key_Menu || event.key === Qt.Key_Meta) {
                event.accepted = currentItem.menu();
            }
        }

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

//    VEditToolbar {
//        id: editToolbar
//    }

    Toaster {
        id: toaster
    }

    MessageDialog {
        id: messageDialog
        property var callback: function(){}
        onYes:      {callback(true, clickedButton);}
        onAccepted: {callback(true, clickedButton);}
        onApply:    {callback(true, clickedButton);}
        onReset:    {callback(true, clickedButton);}
        onRejected: {callback(false, clickedButton);}
        onNo:       {callback(false, clickedButton);}
    }

}
