#pragma once
#include <QObject>
#include <QString>

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString status READ status NOTIFY statusChanged)

public:
    explicit Backend(QObject *parent = nullptr);
    QString status() const;

public slots:
    void updateStatus(const QString &newStatus);

signals:
    void statusChanged();

private:
    QString m_status = "Ready";
};
