#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QFileInfo>
#include "backend/WeatherModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Get path to main.qml
    QString sourceDir = QFileInfo(__FILE__).absolutePath();
    QString qmlPath = sourceDir + "/../src/qml/main.qml";

    WeatherModel weatherModel;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("weatherModel", &weatherModel);
    engine.load(QUrl::fromLocalFile(qmlPath));

    if (engine.rootObjects().isEmpty()) {
        qDebug() << "Failed to load QML:" << qmlPath;
        return -1;
    }

    return app.exec();
}
