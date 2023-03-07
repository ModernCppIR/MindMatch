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
    property color greenColor: "#4CAF50"
    property color lightGreenColor: "#8BC34A"
    property color lightBackgroundColor: "#f3fbff"

    property color shadowColor:Qt.darker("#aa608da2")

    property color lightblue: "#00BCD4"
    property color darkblue: "#2196F3"
    property color bluegray: "#92afc5"

    property color darkTextColor: "#454545"
    property color lightTextColor: "#FFF"
    property color bluegrayTextColor: "#8eafc6"
    property color darkBluegrayTextColor: "#c0e1f8"


    property var blueGradient :  Gradient {
        GradientStop { position: 0; color: Constant.lightblue}
        GradientStop { position: 1; color: Constant.darkblue }
    }

    property var darkBlueGradient :  Gradient {
        GradientStop { position: 0; color: "#03A9F4"}
        GradientStop { position: 1; color: "#2196F3"  }
    }

    property var goldGradient : Gradient {
        GradientStop { position: 0; color: Constant.gold }
        GradientStop { position: 1; color: Constant.orange }
    }

    property var redGradient : Gradient {
        GradientStop { position: 0; color: Constant.orange }
        GradientStop { position: 1; color: Constant.redColor }
    }

    property var greenGradient : Gradient {
        GradientStop { position: 0; color:  Constant.lightGreenColor}
        GradientStop { position: 1; color: Constant.greenColor }
    }

    property var whiteGradient : Gradient {
        GradientStop { position: 0; color: Constant.whiteColor }
        GradientStop { position: 1; color: Constant.whiteColor }
    }

    property var lightBackgroundGradient : Gradient {
        GradientStop { position: 0; color: Constant.lightBackgroundColor }
        GradientStop { position: 1; color: Constant.lightblue }
    }

	property string trophyIconUnicode: "\uf091"
	property string gearIconUnicode: "\uf013"
	property string shareIconUnicode: "\uf1e0"
	property string bookIconUnicode: "\uf02d"
	property string videoIconUnicode: "\uf02d"
	property string sourceIconUnicode: "\uf15b"

}
