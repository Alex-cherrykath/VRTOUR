#ifndef VRT_DOWNLOADER_H
#define VRT_DOWNLOADER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QFile>
#include <QDir>
#include <QtDebug>
#include <QDataStream>
#include <QByteArray>


class VRT_Downloader : public QObject {
    Q_OBJECT
public:
    explicit VRT_Downloader(QObject *parent = 0);
    virtual ~VRT_Downloader();

    void downloadFile(const QUrl& fileURL, const QString& fileName);

private:
    QNetworkAccessManager* m_manager;
    QNetworkReply* m_reply;
    QFile* m_file;

    QString m_fileName;
    QUrl m_fileUrl;

signals:
    void downloadFinished();

private slots:
    void onDownloadProgress(qint64,qint64);
    void onFinished(QNetworkReply*);
    void onReadyRead();
    void onReplyFinished();
};

#endif // VRT_DOWNLOADER_H
