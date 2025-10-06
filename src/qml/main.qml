import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 840
    height: 660
    title: "Smart Weather Station"

    // Auto dark mode: 6 PM to 6 AM
    readonly property bool isNight: {
        var hour = new Date().getHours();
        return hour >= 18 || hour < 6;
    }

    // Dynamic accent color based on weather
    property string weatherMain: "01d" // default: clear sky
    readonly property color accent: {
        if (weatherMain.startsWith("01")) return isNight ? "#FFD166" : "#FF9E00"; // Clear
        if (weatherMain.startsWith("02")) return isNight ? "#7209B7" : "#5E17EB"; // Few clouds
        if (weatherMain.startsWith("03") || weatherMain.startsWith("04")) return isNight ? "#4CC9F0" : "#4361EE"; // Clouds
        if (weatherMain.startsWith("09") || weatherMain.startsWith("10")) return isNight ? "#4895EF" : "#3A86FF"; // Rain
        if (weatherMain.startsWith("11")) return isNight ? "#BC4749" : "#D00000"; // Thunderstorm
        if (weatherMain.startsWith("13")) return isNight ? "#ADB5BD" : "#7209B7"; // Snow
        return isNight ? "#4CC9F0" : "#4361EE"; // Default
    }

    // Background gradient
    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0; color: isNight ? "#0f0f0f" : "#e0f7fa" }
            GradientStop { position: 1; color: isNight ? "#1a1a1a" : "#f8f9fa" }
        }
    }

    // Weather data
    property string city: "Forssa"
    property string temperature: "—"
    property string description: "Loading..."
    property string icon: "01d"

    Component.onCompleted: {
        fetchWeather()
        timeTimer.start()
    }

    property string currentTime: Qt.formatDateTime(new Date(), "h:mm:ss AP")
    property string currentDate: Qt.formatDateTime(new Date(), "dddd, MMMM d, yyyy")

    Timer {
        id: timeTimer
        interval: 1000
        repeat: true
        onTriggered: {
            currentTime = Qt.formatDateTime(new Date(), "h:mm:ss AP")
            currentDate = Qt.formatDateTime(new Date(), "dddd, MMMM d, yyyy")
        }
    }

    function fetchWeather() {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "https://api.openweathermap.org/data/2.5/weather?q=Forssa,FI&appid=26df05cdb9ecfcd58f0d8a9a7c61d4c8&units=metric");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    city = response.name + ", " + response.sys.country;
                    temperature = Math.round(response.main.temp) + "°C";
                    description = response.weather[0].description;
                    icon = response.weather[0].icon;
                    weatherMain = icon; // Update accent color
                } else {
                    description = "Error loading weather";
                }
            }
        };
        xhr.send();
    }

    header: ToolBar {
        background: Rectangle {
            color: isNight ? "#1e1e1e" : "#ffffff"
            border.color: isNight ? "#333333" : "#e0e0e0"
            border.width: 1
        }
        RowLayout {
            anchors.fill: parent
            Label {
                text: "🌤️ Forssa Weather Forcast"
                font.pixelSize: 16
                font.bold: true
                color: accent
                leftPadding: 12
                verticalAlignment: Text.AlignVCenter
            }
            Item { Layout.fillWidth: true }
            Label {
                text: isNight ? "🌙 Night Mode" : "☀️ Day Mode"
                color: isNight ? "#4CC9F0" : "#4361EE"
                font.pixelSize: 12
                font.bold: true
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 26

        // Digital Clock
        Text {
            text: currentTime
            font.family: "Courier New, monospace"
            font.pixelSize: 36
            font.bold: true
            color: accent
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: currentDate
            font.pixelSize: 16
            color: isNight ? "#b0b0b0" : "#6c757d"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: city
            font.pixelSize: 26
            font.bold: true
            color: isNight ? "#ffffff" : "#212529"
            Layout.alignment: Qt.AlignHCenter
        }

        Image {
            source: "https://openweathermap.org/img/wn/" + icon + "@2x.png"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: temperature
            font.pixelSize: 52
            font.bold: true
            color: accent
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: description
            font.pixelSize: 17
            color: isNight ? "#aaaaaa" : "#495057"
            Layout.alignment: Qt.AlignHCenter
        }
    }

    // name - stylish and visible
    Text {
        text: "Created by Victor Ifeoluwa Betiku"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 16
        font.pixelSize: 10
        font.italic: true
        color: accent
        opacity: 1.0
    }
}
