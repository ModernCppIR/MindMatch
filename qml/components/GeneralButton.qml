import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import Constant 1.0

Button {
    id:root

    property color firstBackgroundColor: Constant.gold
    property color secondBackgroundColor: Constant.orange
    property color fontColor: Constant.whiteColor
    property double buttonRadius: 20

	contentItem: Text {
		anchors.centerIn: parent
		text: root.text
		visible: true
		horizontalAlignment: Qt.AlignHCenter
		verticalAlignment: Qt.AlignVCenter
		color: fontColor
		font.bold: true
		font.pixelSize: root.font.pixelSize
	}

    background: Rectangle{
        id:button_back
        radius: buttonRadius
        RadialGradient  {
            anchors.fill: button_back
            source: button_back
            angle: 45
            verticalRadius: 300
            horizontalRadius: 300
            horizontalOffset:-button_back.width/2
            verticalOffset: -button_back.height/2
            gradient: Gradient {
                GradientStop { position: 0; color: firstBackgroundColor }
                GradientStop { position: 1; color: secondBackgroundColor }
            }
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
