import QtQuick 2.15
import QtGraphicalEffects 1.15

import Constant 1.0

import '../components'

Item {

	Component.onCompleted: {
		mainWindow.hideMenus()
	}

	Rectangle
	{
		id:backRect
		anchors.fill: parent
		LinearGradient {
			anchors.fill: backRect
			source: backRect
			start: Qt.point(0, backRect.height/2)
			end: Qt.point(backRect.width, backRect.height/2)
			gradient: Constant.blueGradient
		}
	}

	LiquidButton{
		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter

		width: parent.width * 1.4
		height: parent.width * 1.4

		batteryState: 2
		batteryLevel: 90

		onClicked: {
			opacityAnim.start()
			lowAnim.start()
		}

		PropertyAnimation on batteryLevel
		{
			running:false
			loops:1
			id: lowAnim
			from: 90
			to: 10
			duration: 200
			onFinished:{
				console.log("finished")
				timer.start()
			}
		}
		PropertyAnimation on opacity
		{
			running:false
			loops:1
			id: opacityAnim
			from: 1
			to: 0
			duration: 200

		}

		Timer{
			id:timer
			interval: 50
			onTriggered:				stackView.push("qrc:/qml/pages/Story/BookList.qml")

		}


	}


}
