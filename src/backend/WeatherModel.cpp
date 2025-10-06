#include "WeatherModel.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QSettings>
#include <QUrl>

WeatherModel::WeatherModel(QObject *parent)
    : QObject(parent)
{
    QSettings settings;
    m_darkMode = settings.value("darkMode", false).toBool();
    emit darkModeChanged();

    connect(&m_timer, &QTimer::timeout, this, &WeatherModel::refreshWeather);
    m_timer.start(300000); // Update every 5 minutes
    refreshWeather();
    connect(&m_networkManager, &QNetworkAccessManager::finished,
            this, &WeatherModel::onWeatherDataReceived);
}

QString WeatherModel::city() const { return m_city; }
QString WeatherModel::temperature() const { return m_temperature; }
QString WeatherModel::description() const { return m_description; }
QString WeatherModel::icon() const { return m_icon; }
bool WeatherModel::darkMode() const { return m_darkMode; }

void WeatherModel::refreshWeather() {
    QString apiKey = "26df05cdb9ecfcd58f0d8a9a7c61d4c8"; // Your key
    QString city = "Lagos";
    QUrl url(QString("https://api.openweathermap.org/data/2.5/weather?q=%1&appid=%2&units=metric").arg(city).arg(apiKey));
    m_networkManager.get(QNetworkRequest(url));
}

void WeatherModel::setDarkMode(bool enabled) {
    if (m_darkMode != enabled) {
        m_darkMode = enabled;
        QSettings().setValue("darkMode", enabled);
        emit darkModeChanged();
    }
}

void WeatherModel::onWeatherDataReceived(QNetworkReply *reply) {
    if (reply->error() == QNetworkReply::NoError) {
        QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
        if (!doc.isNull() && doc.isObject()) {
            QJsonObject obj = doc.object();
            m_city = obj["name"].toString("Unknown");
            m_temperature = QString::number(obj["main"].toObject()["temp"].toDouble(), 'f', 0) + "°C";
            m_description = obj["weather"].toArray().first().toObject()["description"].toString();
            m_icon = obj["weather"].toArray().first().toObject()["icon"].toString();
            emit weatherChanged();
        }
    }
    reply->deleteLater();
}
