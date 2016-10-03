import QtQuick 2.2
import QtQuick.Dialogs 1.0

FileDialog {
    title: "Please choose a store path"
    selectFolder: true
    selectMultiple: false
    selectExisting: true
    folder: shortcuts.documents

    onAccepted: {
        vaults.dataPath = pathView.folder
    }
}
