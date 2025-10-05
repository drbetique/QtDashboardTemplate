import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: chartCard
    property string title: ""System Metrics""
    color: theme.surface
    radius: 12
    border.color: theme.isDark ? ""#333333"" : ""#e9ecef""
    border.width: 1

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 12

        Text {
            text: title
            font.bold: true
            color: theme.textPrimary
            Layout.alignment: Qt.AlignHCenter
        }

        // Live time
        Text {
            text: ""?? "" + dataModel.currentTime
            color: theme.textSecondary
            font.pixelSize: 14
            Layout.alignment: Qt.AlignHCenter
        }

        // CPU Usage
        RowLayout {
            spacing: 8
            Layout.alignment: Qt.AlignHCenter
            Text {
                text: ""CPU:""
                color: theme.textPrimary
                font.bold: true
            }
            Text {
                text: dataModel.cpuUsage + ""%""
                color: theme.primary
            }
        }

        // Memory Usage
        RowLayout {
            spacing: 8
            Layout.alignment: Qt.AlignHCenter
            Text {
                text: ""Memory:""
                color: theme.textPrimary
                font.bold: true
            }
            Text {
                text: dataModel.memoryUsage + ""%""
                color: theme.success
            }
        }
    }
}
