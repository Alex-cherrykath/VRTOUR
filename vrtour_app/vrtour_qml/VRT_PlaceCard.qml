import QtQuick.Controls
import QtQuick
import QtQuick.Layouts
import QtPositioning
import QtLocation

Frame {
    id: frame

    property string _place_id
    property string _name
    property url _img
    property url _link_vr
    property string _text
    property bool favorited: false
    property real _latitude
    property real _longitude

    Location {
        id: place_position
        coordinate: QtPositioning.coordinate(_latitude, _longitude)
    }

    visible: true

    height: 250

    GridLayout {
        columns: 3
        rows: 3

        columnSpacing: 5
        rowSpacing: 5

        anchors.fill: parent

        ColumnLayout {
            Layout.columnSpan: 1
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Frame {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignCenter
                clip: true

                Image {
                    anchors.fill: parent
                    source: frame._img
                    fillMode: Image.PreserveAspectFit
                    Layout.alignment: Qt.AlignCenter
                    clip: true
                    z: -1
                }
            }

            Label {
                text: frame._name
                Layout.alignment: Qt.AlignCenter
            }
        }

        RowLayout {
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter| Qt.AlignTop
            Layout.margins: 20
            RoundButton {
                text: "VR"
                icon.source: "./img/vr-brille.png"
            }
            RoundButton {
                id: map_button
                text: "Map"
                checkable: true
                icon.source: "./img/pin-karte.png"
            }
            RoundButton {
                id: favorite_button
                text: "Like"
                checkable: true
                checked: frame.favorited
                icon.source: "./img/herz.png"
                palette.accent: "red"

                onToggled: {
                    if (checked) {
                        favorite_settings.addFavorites(frame._place_id)
                    }
                    else {
                        favorite_settings.removeFavorites(frame._place_id)
                    }
                }
            }
        }

        Map {
            id: map
            visible: map_button.checked    
            center: QtPositioning.coordinate(3.844119, 11.501346) // Yaoundé
            copyrightsVisible: false
            zoomLevel: 10

            Layout.columnSpan: 3
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 500

            property bool initialized: false

            onVisibleChanged: {
                if (visible && !initialized) {
                    map.fitViewportToVisibleMapItems()
                    routeModel.update()
                    initialized = true
                }
            }

            plugin: Plugin {
                id: plugin
                name: 'osm'
                PluginParameter {
                    name: "osm.mapping.providersrepository.disabled"
                    value: "true"
                }
                PluginParameter {
                    name: "osm.mapping.providersrepository.address"
                    value: "http://maps-redirect.qt.io/osm/5.6/"
                }
            }

            MapView {
                id: mapView
            }


            MapItemView {
                id: mapItemView
                model: routeModel
                delegate: MapRoute {
                    route: routeData
                    line {
                        color: "blue"
                        width: 7
                    }
                    smooth: true
                    opacity: 0.8
                }
                autoFitViewport: true
            }

            MapQuickItem {
                id: marker
                anchorPoint {
                    x: img.width/2
                    y: img.height
                }

                sourceItem: Image {
                    id: img
                    source: "./img/location-pin.png"
                    width: 40
                    height: 40
                }

                coordinate: QtPositioning.coordinate(frame._latitude, frame._longitude)
            }

            MapCircle {
                id: startPoint
                color: "white"
                radius: 35
                border.color: "red"
                border.width: 10
                center: QtPositioning.coordinate(3.844119, 11.501346) // Yaoundé
            }

            RouteModel {
                id: routeModel
                plugin: plugin
                query: RouteQuery {
                    waypoints: [
                        map.center,
                        marker.coordinate
                    ]
                }
                autoUpdate: false

            }
        }

        TextArea {
            id: textArea
            readOnly: true
            wrapMode: TextEdit.Wrap
            text: frame._text
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.columnSpan: 3

            onPressed: {
                console.log("TextArea pressed")
                if (frame.height === 250) {frame.height += textArea.contentHeight}
                else {frame.height = 250}
            }
        }

    }


}
