import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

import Constant 1.0

import '../components'

Item
{
	id:root

	Component.onCompleted:
	{
		mainWindow.hideMenus()
	}

	FontLoader
	{
		id: sadafFont
		source: "qrc:/fonts/ttf/SOGAND.ttf"
	}

	Rectangle
	{
		id:backRect

		anchors.fill: parent

		LinearGradient
		{
			anchors.fill: backRect
			source: backRect
			start: Qt.point(0, backRect.height/2)
			end: Qt.point(backRect.width, backRect.height/2)
			gradient: Constant.blueGradient
		}
	}

	Text
	{
		id: logotext
		text:"آقای ریاضی"
		font
		{
			letterSpacing: 5
			family: sadafFont.name
			pixelSize: Constant.h1FontSize
		}
		color: Constant.whiteColor
		horizontalAlignment: Qt.AlignHCenter
		verticalAlignment: Qt.AlignVCenter
		anchors
		{
			top: parent.top
			left: parent.left
			right: parent.right
			topMargin: 125
		}

		layer.enabled: true
		layer.effect: DropShadow
		{
			transparentBorder: true
			horizontalOffset: 0
			verticalOffset: 0
			color: Qt.darker("#608da2")
			samples: 7
			radius: 8
			spread: 0.0

		}
	}

	Image
	{

		sourceSize: Qt.size(root.width , root.width)
		source: "qrc:/img/mustache.png"

		anchors.top: logotext.bottom
		anchors.topMargin: 10

		layer.enabled: true
		layer.effect: DropShadow
		{
			transparentBorder: true
			horizontalOffset: 0
			verticalOffset: 0
			color: Qt.darker("#608da2")
			samples: 7
			radius: 8
			spread: 0.0
		}
	}

	LiquidButton
	{
		text:"شروع"

		font.pixelSize: Constant.h2FontSize

		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter

		width: parent.width * 1.4
		height: parent.width * 1.4

		batteryState: 2
		batteryLevel: 90

		onClicked:
		{
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
			onFinished:
			{
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

		Timer
		{
			id:timer
			interval: 50
			onTriggered: stackView.push(bookListComponent)
		}
	}

	RowLayout
	{
		spacing:10

		anchors
		{
			bottom: parent.bottom
			bottomMargin: 10
			left:parent.left
			right:parent.right
		}

		Item
		{
			Layout.fillWidth: true
		}

		GeneralButton
		{
			text: Constant.gearIconUnicode
			implicitWidth: root.width/6
			implicitHeight: implicitWidth
			Layout.bottomMargin: 40
			buttonRadius:implicitWidth
			font.pixelSize: Constant.h3FontSize
			textVerticalCenterOffset: 8
			enableTextShadow: true
			backGroundGradient: Constant.blueGradient
		}

		GeneralButton
		{
			text: Constant.trophyIconUnicode
			implicitWidth: root.width/6
			implicitHeight: implicitWidth
			buttonRadius:implicitWidth

			font.pixelSize: Constant.h3FontSize
			textVerticalCenterOffset: 8
			enableTextShadow: true
			background: Rectangle
			{
				id:button_back
				radius: parent.implicitWidth

				RadialGradient
				{
					anchors.fill: parent
					source: parent
					angle: 45
					verticalRadius: parent.width
					horizontalRadius: parent.width
					horizontalOffset:-parent.width/2
					verticalOffset: -parent.height/2
					gradient: Constant.goldGradient
				}
			}
		}

		GeneralButton
		{
			text: Constant.shareIconUnicode
			implicitWidth: root.width/6
			implicitHeight: implicitWidth
			Layout.bottomMargin: 40
			buttonRadius:implicitWidth
			font.pixelSize: Constant.h3FontSize
			textVerticalCenterOffset: 8
			enableTextShadow: true
			backGroundGradient: Constant.blueGradient
		}

		Item
		{
			Layout.fillWidth: true
		}
	}
}
