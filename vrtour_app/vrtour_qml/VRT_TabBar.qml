import QtQuick.Controls

TabBar {
    id: tabBar

    TabButton {
       id: home
       text: "Home"
       checkable: true
       icon {
           name: "Home"
           source: "./img/heim.png"
       }
    }

    TabButton {
        id: search
        text: "Search"
        checkable: true
        icon {
            name: "Search"
            source: "./img/suche.png"
        }

    }

    TabButton {
        id: favorite
        text: "Favorite"
        checkable: true
        icon {
            name: "Favorite"
            source: "./img/herz.png"
        }

    }

}
