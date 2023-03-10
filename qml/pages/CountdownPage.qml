import QtQuick 2.15

import Constant 1.0

import "../components/lottie" as Lottie

Item
{
	id:root

	signal done()

	Component.onCompleted:
	{
		mainWindow.hideMenus();
	}

	Lottie.LottieAnimation {
		id: lottieAnim
		anchors.centerIn: parent
		width:  parent.width * 1.7
		height:  parent.height * 1.7
		source: "qrc:/lottie/blue-countdown-from-3.json"
		running: true
		clearBeforeRendering: true
		loops: 0
		fillMode: Image.PreserveAspectFit

		onFinished:
		{
			console.log("finish is working");
			done();
		}
	}
}
