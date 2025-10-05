#pragma once
#include <QObject>
#include <QTimer>
#include <QDateTime>

class DataModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentTime READ currentTime NOTIFY currentTimeChanged)
    Q_PROPERTY(int cpuUsage READ cpuUsage NOTIFY cpuUsageChanged)
    Q_PROPERTY(int memoryUsage READ memoryUsage NOTIFY memoryUsageChanged)

public:
    explicit DataModel(QObject *parent = nullptr);

    QString currentTime() const;
    int cpuUsage() const;
    int memoryUsage() const;

public slots:
    void refreshData();

signals:
    void currentTimeChanged();
    void cpuUsageChanged();
    void memoryUsageChanged();

private:
    QString m_currentTime;
    int m_cpuUsage = 0;
    int m_memoryUsage = 0;
    QTimer m_timer;
};
