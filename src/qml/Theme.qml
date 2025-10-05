import QtQuick
import Qt.labs.settings 1.0

QtObject {
    id: theme

    // Settings to persist dark mode preference
    Settings {
        id: settings
        property bool darkMode: false
    }

    // Expose darkMode state
    readonly property bool isDark: settings.darkMode

    // Light theme
    readonly property color backgroundLight: ""#f8f9fa""
    readonly property color surfaceLight: ""#ffffff""
    readonly property color textPrimaryLight: ""#212529""
    readonly property color textSecondaryLight: ""#6c757d""

    // Dark theme
    readonly property color backgroundDark: ""#121212""
    readonly property color surfaceDark: ""#1e1e1e""
    readonly property color textPrimaryDark: ""#f8f9fa""
    readonly property color textSecondaryDark: ""#adb5bd""

    // Dynamic colors based on mode
    readonly property color background: isDark ? backgroundDark : backgroundLight
    readonly property color surface: isDark ? surfaceDark : surfaceLight
    readonly property color textPrimary: isDark ? textPrimaryDark : textPrimaryLight
    readonly property color textSecondary: isDark ? textSecondaryDark : textSecondaryLight

    readonly property color primary: ""#4361ee""
    readonly property color secondary: ""#3f37c9""
    readonly property color success: ""#4cc9f0""
    readonly property string defaultFont: ""Segoe UI, sans-serif""

    // Function to toggle mode
    function toggleDarkMode() {
        settings.darkMode = !settings.darkMode
    }
}
