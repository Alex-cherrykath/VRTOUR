#include "vrt_database.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("JSL Corp");
    QCoreApplication::setApplicationName("VRTour");

    QQmlApplicationEngine engine;

    VRT_Database database;

    engine.rootContext() -> setContextProperty("__vrt_database__", &database);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("vrtour_app", "Main");

    return app.exec();
}
