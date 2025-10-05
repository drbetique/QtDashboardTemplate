#include ""DataModel.h""
#include <QRandomGenerator>

DataModel::DataModel(QObject *parent)
    : QObject(parent)
{
    // Update data every second
    connect(&m_timer, &QTimer::timeout, this, &DataModel::refreshData);
    m_timer.start(1000);
    refreshData(); // initial update
}

QString DataModel::currentTime() const {
    return m_currentTime;
}

int DataModel::cpuUsage() const {
    return m_cpuUsage;
}

int DataModel::memoryUsage() const {
    return m_memoryUsage;
}

void DataModel::refreshData() {
    // Update time
    m_currentTime = QDateTime::currentDateTime().toString(""hh:mm:ss"");
    emit currentTimeChanged();

    // Mock CPU/Memory (random between 20-80%)
    m_cpuUsage = QRandomGenerator::global()->bounded(20, 81);
    m_memoryUsage = QRandomGenerator::global()->bounded(30, 91);
    emit cpuUsageChanged();
    emit memoryUsageChanged();
}
