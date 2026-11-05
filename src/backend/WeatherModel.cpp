#include "WeatherModel.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QSettings>
#include <QUrl>
#include <QUrlQuery>

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
    // The key is read from the environment so it never lives in the source tree.
    const QString apiKey = qEnvironmentVariable("OPENWEATHER_API_KEY");
    if (apiKey.isEmpty()) {
        m_description = QStringLiteral("Set OPENWEATHER_API_KEY");
        emit weatherChanged();
        return;
    }
    const QString city = qEnvironmentVariable("OPENWEATHER_CITY", QStringLiteral("Helsinki,FI"));

    QUrl url(QStringLiteral("https://api.openweathermap.org/data/2.5/weather"));
    QUrlQuery query;
    query.addQueryItem(QStringLiteral("q"), city);
    query.addQueryItem(QStringLiteral("appid"), apiKey);
    query.addQueryItem(QStringLiteral("units"), QStringLiteral("metric"));
    url.setQuery(query);
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
    reply->deleteLater();

    if (reply->error() != QNetworkReply::NoError) {
        m_description = QStringLiteral("Error loading weather");
        emit weatherChanged();
        return;
    }

    const QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
    if (!doc.isObject()) {
        m_description = QStringLiteral("Error loading weather");
        emit weatherChanged();
        return;
    }

    const QJsonObject obj = doc.object();
    const QString country = obj["sys"].toObject()["country"].toString();
    m_city = obj["name"].toString(QStringLiteral("Unknown"));
    if (!country.isEmpty())
        m_city += QStringLiteral(", ") + country;
    m_temperature = QString::number(obj["main"].toObject()["temp"].toDouble(), 'f', 0)
                    + QStringLiteral("\u00B0C");

    // "weather" can be empty; reading .first() on an empty array is undefined.
    const QJsonArray weather = obj["weather"].toArray();
    if (!weather.isEmpty()) {
        const QJsonObject current = weather.first().toObject();
        m_description = current["description"].toString();
        m_icon = current["icon"].toString();
    }
    emit weatherChanged();
}
