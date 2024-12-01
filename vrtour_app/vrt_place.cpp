#include "vrt_place.h"

VRT_Place::VRT_Place(int id, QString name, QUrl img, float latitude, float longitude, QUrl link_vr, QString description)
    :m_id(id),
    m_name(name),
    m_img(img),
    m_latitude(latitude),
    m_longitude(longitude),
    m_link_vr(link_vr),
    m_description(description)
{}

QVariantMap VRT_Place::toVariantMap()
{
    QVariantMap map;

    map["place_id"] =  QVariant(m_id);
    map["name"] =  QVariant(m_name);
    map["img"] =  QVariant(m_img);
    map["latitude"] =  QVariant(m_latitude);
    map["longitude"] =  QVariant(m_longitude);
    map["link_vr"] =  QVariant(m_link_vr);
    map["description"] = QVariant(m_description);

    return map;
}
