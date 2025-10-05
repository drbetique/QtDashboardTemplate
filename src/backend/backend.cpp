#include "backend.h"

Backend::Backend(QObject *parent) : QObject(parent) {}

QString Backend::status() const {
    return m_status;
}

void Backend::updateStatus(const QString &newStatus) {
    if (m_status != newStatus) {
        m_status = newStatus;
        emit statusChanged();
    }
}
