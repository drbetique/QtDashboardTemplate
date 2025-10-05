import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 800
    height: 600
    visible: true
    title: ""Qt Dashboard Template""

    // Apply theme
    Theme { id: theme }

    background: Rectangle {
        color: theme.background
    }

    header: ToolBar {
        background: Rectangle { color: theme.surface }
        Label {
            text: ""Dashboard""
            font.pixelSize: 18
            color: theme.textPrimary
            padding: 10
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        Rectangle {
            width: 400; height: 200
            color: theme.surface
            radius: 12
            border.color: ""#e9ecef""
            border.width: 1

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 10

                Text {
                    text: ""?? Performance Chart""
                    font.bold: true
                    color: theme.textPrimary
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: ""(QtCharts integration coming soon)""
                    color: theme.textSecondary
                    font.pixelSize: 12
                    Layout.alignment: Qt.AlignHCenter
                }
            }
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
