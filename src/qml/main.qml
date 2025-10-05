import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 800
    height: 600
    visible: true
    title: ""Qt Dashboard Template""

    Theme { id: theme }

    background: Rectangle {
        color: theme.background
    }

    header: ToolBar {
        background: Rectangle { color: theme.surface }
        RowLayout {
            anchors.fill: parent
            spacing: 10

            Label {
                text: ""Dashboard""
                font.pixelSize: 18
                color: theme.textPrimary
                padding: 10
            }

            Item { Layout.fillWidth: true } // spacer

            Switch {
                id: darkModeSwitch
                checked: theme.isDark
                onCheckedChanged: theme.toggleDarkMode()
                Layout.alignment: Qt.AlignVCenter
            }

            Label {
                text: ""Dark Mode""
                color: theme.textSecondary
                font.pixelSize: 12
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        ChartCard {
            title: ""Performance Metrics""
            subtitle: ""CPU, Memory, Network""
        }

        Label {
            text: ""Status: "" + backend.status
            color: theme.textSecondary
            font.pixelSize: 16
        }

        Button {
            text: ""Update Status""
            onClicked: backend.updateStatus(""Updated at "" + new Date().toLocaleTimeString())
            palette.button: theme.primary
            palette.buttonText: ""white""
        }
    }
}
