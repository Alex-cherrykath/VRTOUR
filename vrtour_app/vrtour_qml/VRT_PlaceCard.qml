import QtQuick.Controls
import QtQuick
import QtQuick.Layouts
import QtPositioning
import QtLocation 6.8

Frame {
    id: frame

    property string _place_id
    property string _name
    property url _img
    property var _coordinates
    property url _link_vr
    property string _text
    property var coordinates
    property bool favorited: false

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
            Rectangle {
                radius: height / 2
                border.width: 1
                border.color: "red"
                color: "transparent"
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignCenter
                clip: true

                Image {
                    anchors.centerIn: parent
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
            visible: map_button.checked
            Layout.columnSpan: 3
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 500
            onVisibleChanged: {
                if (visible) {
                    routeQuery.waypoints = [
                            posSource.position.coordinate,
                            frame.coordinates
                    ]
                }

                routeModel.update()
            }

            PositionSource {
                  id: posSource
                  name: "geoclue2"
                  active: map_button.checked
            }

            RouteQuery {
                id: routeQuery
            }

            RouteModel {
                id: routeModel
                query: routeQuery
            }

            MapItemView {
                model: routeModel
                delegate: routeDelegate
            }

            Component {
                id: routeDelegate

                MapRoute {
                    route: routeData
                    line.color: "blue"
                    line.width: 5
                    smooth: true
                    opacity: 0.8
                }
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
