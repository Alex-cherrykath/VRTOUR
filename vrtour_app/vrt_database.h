#ifndef VRT_DATABASE_H
#define VRT_DATABASE_H


#include "vrt_place.h"
#include "vrt_downloader.h"

#include <QObject>
#include <QQmlEngine>
#include <QList>
#include <QFile>

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>

#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class VRT_Database : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariantList allPlaces READ getAllPlaces NOTIFY dbLoaded)

    QML_ELEMENT
public:
    explicit VRT_Database(QObject *parent = nullptr);
    QVariantList getAllPlaces();
    void gatherData();

public slots:
    bool loadDatabase();

private:
    bool openDatabase();

    // To be threaded
    bool downloadDatabase();
    bool getData();

private:
    QSqlDatabase m_db;
    QList<VRT_Place> m_allPlaces;

    VRT_Downloader* m_downloader;

signals:
    void dbLoaded();
};

#endif // VRT_DATABASE_H
