#include "backend.h"

Backend::Backend(QObject *parent) : QObject(parent)
{
    m_darkMode = m_settings.value("darkMode", false).toBool();
    emit darkModeChanged();
}

QString Backend::status() const {
    return m_status;
}

bool Backend::darkMode() const {
    return m_darkMode;
}

void Backend::updateStatus(const QString &newStatus) {
    if (m_status != newStatus) {
        m_status = newStatus;
        emit statusChanged();
    }
}

void Backend::setDarkMode(bool enabled) {
    if (m_darkMode != enabled) {
        m_darkMode = enabled;
        m_settings.setValue("darkMode", enabled);
        emit darkModeChanged();
    }
}
