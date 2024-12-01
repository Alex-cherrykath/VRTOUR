#ifndef VRT_PLACE_H
#define VRT_PLACE_H

#include <QString>
#include <QUrl>
#include <QVariantMap>

class VRT_Place
{
public:
    VRT_Place(int id, QString name, QUrl img, float latitude, float longitude, QUrl link_vr, QString description);

    QVariantMap toVariantMap();

private:
    int m_id;
    QString m_name;
    QUrl m_img;
    float m_latitude;
    float m_longitude;
    QUrl m_link_vr;
    QString m_description;
};

#endif // VRT_PLACE_H
