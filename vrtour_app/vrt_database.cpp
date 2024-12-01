#include "vrt_database.h"

VRT_Database::VRT_Database(QObject *parent)
    : QObject{parent}
{
    loadDatabase();
}

QVariantList VRT_Database::getAllPlaces()
{
    QVariantList list;

    for (auto place : m_allPlaces) {
        list.push_back(QVariant(place.toVariantMap()));
    }

    return list;
}

void VRT_Database::gatherData()
{
    if (!openDatabase()) {
        qWarning() << "Could not open database";
    }

    qDebug() << "List of tables in db: " << m_db.tables();

    if (!getData()) {
        qWarning() << "Could not get database data";
    }

    delete m_downloader;
}

bool VRT_Database::loadDatabase()
{

    if (!downloadDatabase()) {
        qWarning() << "Could not download database";
        return false;
    }

    connect(m_downloader, &VRT_Downloader::downloadFinished, this, &VRT_Database::gatherData);

    return true;
}

bool VRT_Database::openDatabase()
{
    m_db = QSqlDatabase::addDatabase("QSQLITE");

    QFile db ("vrtour.db");

    if (!db.exists()) {
        qWarning() << "Cannot find db file";
        return false;
    }

    auto fullDBPath = std::filesystem::absolute(db.filesystemFileName());
    auto path = QString::fromStdString(fullDBPath.u8string());

    qDebug() << "Full db path: " << path;
    m_db.setDatabaseName(path);

    return m_db.open();
}

bool VRT_Database::downloadDatabase()
{
    QUrl dbUrl = QUrl("https://docs.google.com/uc?export=download&confirm=1&id=1BVRzehQOssoqponn2FSimjxtAlkcFr_P");
    QString m_dbFileName = "vrtour.db";

    m_downloader = new VRT_Downloader();

    m_downloader -> downloadFile(dbUrl, m_dbFileName);

    return true;
}

bool VRT_Database::getData()
{
    auto query = QSqlQuery(m_db);

    auto prepared = query.prepare("SELECT * FROM destinations");
    auto preparationError = query.lastError();

    if (!prepared || !query.exec()) {
        qWarning() << "Could not run query; prepared? " << prepared << " : " << preparationError;
        qWarning() << "Last Query Error: " << query.lastError();
        return false;
    }

    while (query.next()) {
        m_allPlaces.emplaceBack(
            query.value("place_id").toInt(),
            query.value("name").toString(),
            query.value("img").toUrl(),
            query.value("latitude").toFloat(),
            query.value("longitude").toFloat(),
            query.value("link_vr").toUrl(),
            query.value("description").toString()
        );
    }

    qInfo() << "Uploaded all places. Size: " << m_allPlaces.size();

    emit dbLoaded();

    return true;
}


