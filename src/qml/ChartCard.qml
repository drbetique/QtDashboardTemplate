import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: chartCard
    property string title: "GitHub Stats"
    color: theme.surface
    radius: 12
    border.color: theme.isDark ? "#333333" : "#e9ecef"
    border.width: 1
    implicitWidth: 340
    implicitHeight: 200

    // Top accent bar
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 4
        color: theme.primary
        radius: 2
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 14

        // Title with icon
        RowLayout {
            spacing: 8
            Layout.alignment: Qt.AlignHCenter

            Text {
                text: "??"
                font.pixelSize: 18
                Layout.alignment: Qt.AlignVCenter
            }

            Text {
                text: title
                font.bold: true
                font.pixelSize: 16
                color: theme.textPrimary
                Layout.alignment: Qt.AlignVCenter
            }
        }

        // User Name
        Text {
            text: dataModel.githubName
            color: theme.textPrimary
            font.pixelSize: 16
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            Layout.maximumWidth: chartCard.width - 32
        }

        // Repo Count with badge
        RowLayout {
            spacing: 10
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true

            Rectangle {
                width: 80
                height: 32
                radius: 6
                color: Qt.rgba(theme.primary.r, theme.primary.g, theme.primary.b, 0.1)
                border.color: theme.primary
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: "Repos"
                    color: theme.primary
                    font.pixelSize: 10
                    font.bold: true
                }
            }

            Text {
                text: dataModel.githubPublicRepos
                color: theme.primary
                font.bold: true
                font.pixelSize: 20
                Layout.alignment: Qt.AlignVCenter
            }
        }

        // Timestamp
        Text {
            text: "Updated: " + dataModel.currentTime
            color: theme.textSecondary
            font.pixelSize: 10
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 4
        }
    }
}
