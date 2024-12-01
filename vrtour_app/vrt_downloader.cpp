#include "vrt_downloader.h"


VRT_Downloader::VRT_Downloader(QObject *parent) :
    QObject(parent),
    m_manager(new QNetworkAccessManager),
    m_file(new QFile)
{
}

VRT_Downloader::~VRT_Downloader()
{
    m_manager->deleteLater();
}

void VRT_Downloader::downloadFile(const QUrl& fileURL, const QString& fileName)
{
    QNetworkRequest request;
    request.setUrl(fileURL);
    m_reply = m_manager->get(request);

    m_file -> setFileName(fileName);

    connect(m_reply,SIGNAL(downloadProgress(qint64,qint64)),this,SLOT(onDownloadProgress(qint64,qint64)));
    connect(m_manager,SIGNAL(finished(QNetworkReply*)),this,SLOT(onFinished(QNetworkReply*)));
    connect(m_reply,SIGNAL(readyRead()),this,SLOT(onReadyRead()));
    connect(m_reply,SIGNAL(finished()),this,SLOT(onReplyFinished()));
}


void VRT_Downloader::onDownloadProgress(qint64 bytesRead,qint64 bytesTotal)
{
    qDebug() << bytesRead << " - " << bytesTotal;

}


void VRT_Downloader::onFinished(QNetworkReply *reply)
{
    switch(reply->error())
    {
    case QNetworkReply::NoError:
    {
        qDebug("file is downloaded successfully.");

        if (m_file->exists()) {
            m_file->remove();
        }

        if (!m_file->isOpen()) {
            m_file->open(QIODevice::WriteOnly);
            m_file->setTextModeEnabled(false);
        }

        m_file -> write(m_reply->readAll());
        break;
    }
    default:{
        qWarning() << reply->errorString();
    };
    }

    m_file -> close();

}

void VRT_Downloader::onReadyRead()
{
    qDebug() << "Ready";
}

void VRT_Downloader::onReplyFinished()
{
    if(m_file->error()>0){
        qWarning() << "Error while saving file";
    }

    if (!m_reply->error() && !m_file->error()){
        qDebug() << "Successfully download file: " << m_file->fileName();
        emit downloadFinished();
    }

    if(m_file->isOpen()){
        m_file->close();
        m_file->deleteLater();
    }

    m_reply -> deleteLater();
}
