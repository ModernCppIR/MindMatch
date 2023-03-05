import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

import Constant 1.0

import "../../js/Utilities.js" as Utilities


Item{
    id: root
    property string text : ""
    property string iconSrc: ""
	property color textColor: Constant.darkTextColor
    property Gradient backgroundGradient: Constant.blueGradient

    Card {
        id: backCard
        anchors.fill: parent
        anchors.bottomMargin: 20
        anchors.topMargin: 20

        radius :100

        Rectangle{
            anchors.fill: parent
            id: backCardRect
            radius: backCard.radius
        }

        RadialGradient  {
            anchors.fill: backCardRect
            source: backCardRect
            angle: 45
            verticalRadius: 300
            horizontalRadius: 300
            horizontalOffset:-backCardRect.width/2
            verticalOffset: -backCardRect.height/2
            gradient: backgroundGradient
        }

        Text{
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter

            text: root.text
			color: textColor
            font.pixelSize: Constant.h4FontSize

            Layout.leftMargin:20
            Layout.alignment: Qt.AlignVCenter

            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
        }
    }
    Image{
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter

        source: iconSrc
        sourceSize: Qt.size(logoSize,logoSize)

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 0
            color: Qt.darker("#608da2")
            samples: 7
            radius: 8
            spread: 0.0

        }
    }


}
