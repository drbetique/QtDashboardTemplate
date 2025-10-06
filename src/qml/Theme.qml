import QtQuick

QtObject {
    id: theme

    // Controlled by C++ backend
    property bool isDark: false

    // Light theme
    readonly property color backgroundLight: "#f8f9fa"
    readonly property color surfaceLight: "#ffffff"
    readonly property color textPrimaryLight: "#212529"
    readonly property color textSecondaryLight: "#6c757d"

    // Soft Dark theme
    readonly property color backgroundDark: "#1a1a1a"
    readonly property color surfaceDark: "#252525"
    readonly property color textPrimaryDark: "#f8f9fa"
    readonly property color textSecondaryDark: "#b0b0b0"

    // Dynamic colors
    readonly property color background: isDark ? backgroundDark : backgroundLight
    readonly property color surface: isDark ? surfaceDark : surfaceLight
    readonly property color textPrimary: isDark ? textPrimaryDark : textPrimaryLight
    readonly property color textSecondary: isDark ? textSecondaryDark : textSecondaryLight

    readonly property color primary: "#4361ee"
    readonly property color secondary: "#3f37c9"
    readonly property color success: "#4cc9f0"
    readonly property string defaultFont: "Segoe UI, sans-serif"
}
