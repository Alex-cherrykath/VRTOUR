#include "vrt_database.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#ifdef ANDROID
#include <android/log.h>

const char*const applicationName="VRTour";

void myMessageHandler(
    QtMsgType type,
    const QMessageLogContext& context,
    const QString& msg
    ) {
    QString report=msg;
    if (context.file && !QString(context.file).isEmpty()) {
        report+=" in file ";
        report+=QString(context.file);
        report+=" line ";
        report+=QString::number(context.line);
    }
    if (context.function && !QString(context.function).isEmpty()) {
        report+=+" function ";
        report+=QString(context.function);
    }
    const char*const local=report.toLocal8Bit().constData();
    switch (type) {
    case QtDebugMsg:
        __android_log_write(ANDROID_LOG_DEBUG,applicationName,local);
        break;
    case QtInfoMsg:
        __android_log_write(ANDROID_LOG_INFO,applicationName,local);
        break;
    case QtWarningMsg:
        __android_log_write(ANDROID_LOG_WARN,applicationName,local);
        break;
    case QtCriticalMsg:
        __android_log_write(ANDROID_LOG_ERROR,applicationName,local);
        break;
    case QtFatalMsg:
    default:
        __android_log_write(ANDROID_LOG_FATAL,applicationName,local);
        abort();
    }
}
#endif

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
