import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import Qt.labs.lottieqt 1.0

import Constant 1.0

Label
{
	id:root

	signal done()

	property int countNumber: 4
	property int interval: 1000
	property int currentNumer: countNumber
	property int numberSize: 1000

	Component.onCompleted:
	{
		mainWindow.hideMenus();
	}

//	Component.onDestruction:
//	{
//		lottieAnimation. gotoAndStop(0)
//	}

	LottieAnimation
	{
		id: lottieAnimation
		anchors.centerIn:parent
		loops: 1
		quality: LottieAnimation.HighQuality
		source: "qrc:/lottie/countdown.json"
		onStatusChanged:
		{
			if (status === LottieAnimation.Ready) {
				gotoAndPlay(0);
			}
		}

		onFinished:
		{
			gotoAndPlay(0);
			done()
		}
	}

	verticalAlignment:Qt.AlignVCenter
	horizontalAlignment:Qt.AlignHCenter

	background: Rectangle
	{
		id:countdownBackRect

		anchors.fill: parent
		color:Constant.whiteColor
	}
}
