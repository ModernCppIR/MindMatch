pragma Singleton

import QtQuick.Controls.Material 2.15
import QtQuick 2.15
QtObject {
    property color orange: "#FF9800"
    property color gold: "#FFEB3B"

//    property color lightblue: "#4DD0E1"
//    property color darkblue: "#2196F3"
//    property color bluegray: "#92afc5"

    property int h1FontSize: 75
    property int h2FontSize: 60
    property int h3FontSize: 45
    property int h4FontSize: 35
    property int h5FontSize: 20

    property color whiteColor: "#FFF"
    property color redColor: "#F44336"
    property color lightBackgroundColor: "#f3fbff"

    property color shadowColor:Qt.darker("#aa608da2")

    property color lightblue: "#65e5f1"
    property color darkblue: "#06d1f7"
    property color bluegray: "#92afc5"

    property color darkTextColor: "#454545"
    property color lightTextColor: "#FFF"
    property color bluegrayTextColor: "#8eafc6"


    property var blueGradient :  Gradient {
        GradientStop { position: 0; color: Constant.lightblue}
        GradientStop { position: 1; color: Constant.darkblue }
    }
    property var goldGradient : Gradient {
        GradientStop { position: 0; color: Constant.gold }
        GradientStop { position: 1; color: Constant.orange }
    }
    property var lightBackgroundGradient : Gradient {
        GradientStop { position: 0; color: Constant.lightBackgroundColor }
        GradientStop { position: 1; color: Constant.lightblue }
    }

    // from greenhouse
    property color primaryColor : "#4CAF50"
    property color darkPrimaryColor : "#388E3C"
    property color lightPrimaryColor : "#C8E6C9"
    property color primaryTextColor : "#212121"
    property color secondaryTextColor : "#757575"
    property color accentColor : "#8BC34A"
    property color textIconColor : "#FFFFFF"
    property color dividerColor : "#FFFFFF"
    property color backgroundColor : "#fff"

    property int cornerRadius: 100
}
