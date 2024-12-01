import QtQuick
import QtQuick.Controls
import QtCore

ApplicationWindow  {
    id: rootWindow
    width: 480
    height: 720
    visible: true
    title: qsTr("VR Tour 237")


    font {
        family: "Helvetica"
        pointSize: 13
        bold: true
    }



    menuBar: VRT_TabBar {
        id: vrt_tabBar
    }

    Settings {
        id: favorite_settings
        category: "Favorites"

        function addFavorites(place_id: int) {
            let allFavorites = getSettings()
            allFavorites.push(place_id)
            updateSettings(allFavorites)
        }

        function removeFavorites(place_id: int) {
            let allFavorites = getSettings()
            let newFavorites = []
            for (let i = 0; i < allFavorites.length; i++) {
                if (allFavorites[i] !== place_id) {
                    newFavorites.push(allFavorites[i])
                }
            }
            updateSettings(newFavorites)
        }

        function updateSettings(allFavorites) {
            favorite_settings.setValue("numFavorites", allFavorites.length)
            for (let i = 0; i < allFavorites.length; i++) {
                favorite_settings.setValue(`fav${i}`, allFavorites[i])
            }

            vrt_homePage.favQuery = allFavorites
            vrt_favoritePage.favQuery = allFavorites
        }

        function getSettings(): list<int> {
            let allFavorites = []
            let numFavorites = favorite_settings.value("numFavorites", 0)
            for (let i = 0; i < numFavorites; i++) {
                allFavorites.push(favorite_settings.value(`fav${i}`))
            }
            return allFavorites
        }
    }




    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: vrt_tabBar.currentIndex
        interactive: false

        VRT_HomePage {
            id: vrt_homePage
        }

        VRT_Page {
            id: vrt_searchPage
            searchActive: true
        }

        VRT_Page {
            id: vrt_favoritePage
            searchActive: false
        }
    }

    Component.onCompleted: {
        let allFavorites = favorite_settings.getSettings()
        vrt_homePage.favQuery = allFavorites
        vrt_favoritePage.favQuery = allFavorites
    }
}
