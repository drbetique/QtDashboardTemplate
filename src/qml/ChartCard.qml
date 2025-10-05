import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Placeholder for real QtCharts later
Rectangle {
    id: chartCard
    property string title: ""Chart""
    property string subtitle: ""Data visualization""

    color: theme.surface
    radius: 12
    border.color: theme.isDark ? ""#333333"" : ""#e9ecef""
    border.width: 1

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 8

        Text {
            text: chartCard.title
            font.bold: true
            color: theme.textPrimary
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: chartCard.subtitle
            color: theme.textSecondary
            font.pixelSize: 12
            Layout.alignment: Qt.AlignHCenter
        }

        Rectangle {
            width: 200; height: 100
            color: theme.isDark ? ""#2a2a2a"" : ""#f0f0f0""
            radius: 6

            Text {
                anchors.centerIn: parent
                text: ""??""
                font.pixelSize: 24
                color: theme.primary
            }
        }
    }
}
