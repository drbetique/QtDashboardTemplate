#pragma once
#include <QObject>
#include <QString>
#include <QSettings>

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString status READ status NOTIFY statusChanged)
    Q_PROPERTY(bool darkMode READ darkMode WRITE setDarkMode NOTIFY darkModeChanged)

public:
    explicit Backend(QObject *parent = nullptr);
    QString status() const;
    bool darkMode() const;

public slots:
    void updateStatus(const QString &newStatus);
    void setDarkMode(bool enabled);

signals:
    void statusChanged();
    void darkModeChanged();

private:
    QString m_status = "Ready";
    bool m_darkMode = false;
    QSettings m_settings;
};
