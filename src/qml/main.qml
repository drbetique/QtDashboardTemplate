import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 800
    height: 600
    visible: true
    title: "Qt Dashboard Template"

    header: ToolBar {
        Label {
            text: "Dashboard"
            font.pixelSize: 18
            padding: 10
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        Label {
            text: "Status: " + backend.status
            font.pixelSize: 16
        }

        Button {
            text: "Update Status"
            onClicked: backend.updateStatus("Updated at " + new Date().toLocaleTimeString())
        }
    }
}
