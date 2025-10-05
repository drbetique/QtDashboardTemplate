#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include ""backend/backend.h""
#include ""backend/DataModel.h""

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Backend backend;
    DataModel dataModel; // <-- new!

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty(""backend"", &backend);
    engine.rootContext()->setContextProperty(""dataModel"", &dataModel); // <-- expose to QML
    engine.loadFromModule(""QtDashboardTemplate"", ""Main"");

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
