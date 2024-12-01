import QtQuick
import QtQuick.Controls
import QtPositioning
import QtQuick.Layouts

Page {
    id: page
    property list<int> favQuery: []

    clip: true

    header: ToolBar {
        height: 75
        RowLayout {
            anchors.fill: parent
            Label {
                text: qsTr("VR Tour App")
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                Layout.alignment: Qt.AlignCenter
            }

            Frame {
                clip: true
                Layout.preferredWidth: page.width / 2
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignCenter
                Image {
                    source: "./img/icon.jpg"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    // z: -1
                }
            }
        }


    }

    background: Rectangle {
        anchors.fill: parent
        opacity: 0.05
        Image {
            anchors.fill: parent
            source: "./img/icon.jpg"
            fillMode: Image.PreserveAspectCrop
        }
    }


    ScrollView {
        anchors.fill: parent
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        ListView {
            id: listView
            model: __vrt_database__.allPlaces
            anchors.fill: parent
            spacing: 70
            anchors.margins: 25


            delegate: VRT_PlaceCard {
                id: delegate

                required property int place_id
                required property string name
                required property url img
                required property url link_vr
                required property string description
                required property real latitude
                required property real longitude

                _place_id: place_id
                _name: name
                _img: img
                _link_vr: link_vr
                _text: description
                _latitude: latitude
                _longitude: longitude

                favorited: {
                    for (let i =0; i < page?.favQuery.length; i++) {
                        if (_place_id == page?.favQuery[i]) {
                            return true
                        }
                    }
                    return false
                }

                width: ListView.view.width
            }
        }
    }


    /* The following serve as example for the C++ backend*/

    ListModel {
        id: _vrt_backend_
        ListElement {
            place_id: 0
            name: "Berlin"
            img: "./img/berlin.jpeg"
            latitude: 52.50
            longitude: 13.42
            link_vr: "https://360-grad-panorama.de/wp-content/uploads/2013/02/Potsdamer_Platz.jpg"
            text: `Kindness to he horrible reserved ye.
            Effect twenty indeed beyond for not had county. The use him without
            greatly can private. Increasing it unpleasant no of contrasted no
            continuing. Nothing colonel my no removed in weather. It dissimilar
            in up devonshire inhabiting.So insisted received is occasion advanced
            honoured. Among ready to which up. Attacks smiling and may out assured
            moments man nothing outward. Thrown any behind afford either the set
            depend one temper. Instrument melancholy in acceptance collecting frequently
            be if. Zealously now pronounce existence add you instantly say offending.
            Merry their far had widen was. Concerns no in expenses raillery formerly.
            Give lady of they such they sure it. Me contained explained my education.
            Vulgar as hearts by garret. Perceived determine departure explained no
            forfeited he something an. Contrasted dissimilar get joy you instrument
            out reasonably. Again keeps at no meant stuff. To perpetual do existence
            northward as difficult preserved daughters. Continued at up to zealously
            necessary breakfast. Surrounded sir motionless she end literature. Gay
            direction neglected but supported yet her.Sigh view am high neat half to
            what. Sent late held than set why wife our. If an blessing building
            steepest. Agreement distrusts mrs six affection satisfied. Day blushes
            visitor end company old prevent chapter. Consider declared out expenses
            her concerns. No at indulgence conviction particular unsatiable boisterous
            discretion. Direct enough off others say eldest may exeter she. Possible
            all ignorant supplied get settling marriage recurred.`
        }

        ListElement {
            place_id: 1
            name: "Kribi"
            img: "./img/berlin.jpeg"
            latitude: 2.940594
            longitude: 9.910191
            link_vr: "https://360-grad-panorama.de/wp-content/uploads/2013/02/Potsdamer_Platz.jpg"
            text: `Kindness to he horrible reserved ye.
            Effect twenty indeed beyond for not had county. The use him without
            greatly can private. Increasing it unpleasant no of contrasted no
            continuing. Nothing colonel my no removed in weather. It dissimilar
            in up devonshire inhabiting.So insisted received is occasion advanced
            honoured. Among ready to which up. Attacks smiling and may out assured
            moments man nothing outward. Thrown any behind afford either the set
            depend one temper. Instrument melancholy in acceptance collecting frequently
            be if. Zealously now pronounce existence add you instantly say offending.
            Merry their far had widen was. Concerns no in expenses raillery formerly.
            Give lady of they such they sure it. Me contained explained my education.
            Vulgar as hearts by garret. Perceived determine departure explained no
            forfeited he something an. Contrasted dissimilar get joy you instrument
            out reasonably. Again keeps at no meant stuff. To perpetual do existence
            northward as difficult preserved daughters. Continued at up to zealously
            necessary breakfast. Surrounded sir motionless she end literature. Gay
            direction neglected but supported yet her.Sigh view am high neat half to
            what. Sent late held than set why wife our. If an blessing building
            steepest. Agreement distrusts mrs six affection satisfied. Day blushes
            visitor end company old prevent chapter. Consider declared out expenses
            her concerns. No at indulgence conviction particular unsatiable boisterous
            discretion. Direct enough off others say eldest may exeter she. Possible
            all ignorant supplied get settling marriage recurred.`
        }

        ListElement {
            place_id: 2
            name: "Douala"
            img: "./img/berlin.jpeg"
            latitude: 4.061536
            longitude: 9.786072
            link_vr: "https://360-grad-panorama.de/wp-content/uploads/2013/02/Potsdamer_Platz.jpg"
            text: `Kindness to he horrible reserved ye.
            Effect twenty indeed beyond for not had county. The use him without
            greatly can private. Increasing it unpleasant no of contrasted no
            continuing. Nothing colonel my no removed in weather. It dissimilar
            in up devonshire inhabiting.So insisted received is occasion advanced
            honoured. Among ready to which up. Attacks smiling and may out assured
            moments man nothing outward. Thrown any behind afford either the set
            depend one temper. Instrument melancholy in acceptance collecting frequently
            be if. Zealously now pronounce existence add you instantly say offending.
            Merry their far had widen was. Concerns no in expenses raillery formerly.
            Give lady of they such they sure it. Me contained explained my education.
            Vulgar as hearts by garret. Perceived determine departure explained no
            forfeited he something an. Contrasted dissimilar get joy you instrument
            out reasonably. Again keeps at no meant stuff. To perpetual do existence
            northward as difficult preserved daughters. Continued at up to zealously
            necessary breakfast. Surrounded sir motionless she end literature. Gay
            direction neglected but supported yet her.Sigh view am high neat half to
            what. Sent late held than set why wife our. If an blessing building
            steepest. Agreement distrusts mrs six affection satisfied. Day blushes
            visitor end company old prevent chapter. Consider declared out expenses
            her concerns. No at indulgence conviction particular unsatiable boisterous
            discretion. Direct enough off others say eldest may exeter she. Possible
            all ignorant supplied get settling marriage recurred.`
        }
    }

}
