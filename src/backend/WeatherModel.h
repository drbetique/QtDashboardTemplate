#pragma once
#include <QObject>
#include <QTimer>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class WeatherModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString city READ city NOTIFY weatherChanged)
    Q_PROPERTY(QString temperature READ temperature NOTIFY weatherChanged)
    Q_PROPERTY(QString description READ description NOTIFY weatherChanged)
    Q_PROPERTY(QString icon READ icon NOTIFY weatherChanged)
    Q_PROPERTY(bool darkMode READ darkMode WRITE setDarkMode NOTIFY darkModeChanged)

public:
    explicit WeatherModel(QObject *parent = nullptr);
    QString city() const;
    QString temperature() const;
    QString description() const;
    QString icon() const;
    bool darkMode() const;

public slots:
    void refreshWeather();
    void setDarkMode(bool enabled);

signals:
    void weatherChanged();
    void darkModeChanged();

private slots:
    void onWeatherDataReceived(QNetworkReply *reply);

private:
    QString m_city = "Loading...";
    QString m_temperature = "--";
    QString m_description = "—";
    QString m_icon = "01d";
    bool m_darkMode = false;
    QTimer m_timer;
    QNetworkAccessManager m_networkManager;
};
