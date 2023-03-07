import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import Constant 1.0

Button {
    id:root

//    property color firstBackgroundColor: Constant.gold
//    property color secondBackgroundColor: Constant.orange
	property Gradient backGroundGradient: Constant.goldGradient
    property color fontColor: Constant.whiteColor
    property double buttonRadius: 20
	property double textVerticalCenterOffset: 0
	property bool enableTextShadow: false

	contentItem: Text {
		anchors.centerIn: parent
		anchors.verticalCenterOffset: textVerticalCenterOffset
		text: root.text
		visible: true
		horizontalAlignment: Qt.AlignHCenter
		verticalAlignment: Qt.AlignVCenter
		color: fontColor
		font.bold: true
		font.pixelSize: root.font.pixelSize
		textFormat: Text.RichText


		layer.enabled: enableTextShadow
		layer.effect: DropShadow {
			transparentBorder: true
			horizontalOffset: 0
			verticalOffset: 0
			color: Constant.shadowColor
			samples: 8
			radius: 8
			spread: 0.0
		}

	}

    background: Rectangle{
        id:button_back
        radius: buttonRadius
        RadialGradient  {
			anchors.fill: parent
			source: parent
            angle: 45
			verticalRadius: parent.width
			horizontalRadius: parent.width
			horizontalOffset:-parent.width/2
			verticalOffset: -parent.height/2
			gradient: backGroundGradient
        }
    }

    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: 0
        color: Constant.shadowColor
        samples: 8
        radius: 8
        spread: 0.0
    }
}
