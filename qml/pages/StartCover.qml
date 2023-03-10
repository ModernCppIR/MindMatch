import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

import Constant 1.0

import "../components/lottie" as Lottie
import '../components'

Item
{
	id: root

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

	RoundButton
	{
		text:"شروع"

		font.pixelSize: Constant.h2FontSize

		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter

		width: parent.width
		height: parent.width

		radius: 200

		contentItem: Text {
			anchors.centerIn: parent
			text: parent.text
			visible: true
			horizontalAlignment: Qt.AlignHCenter
			verticalAlignment: Qt.AlignVCenter
			color: Constant.whiteColor
			font.bold: true
			font.pixelSize: parent.font.pixelSize

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

		onClicked:
		{
			lottieAnim.stop()
			lottieAnim.clear()
			stackView.replace(bookListComponent)
		}

		background: Lottie.LottieAnimation
		{
			id: lottieAnim
			anchors.centerIn: parent
			width:  parent.width * 1.4
			height:  parent.height * 1.4
			source: "qrc:/lottie/liquid-button-background.json"
			running: true
			clearBeforeRendering: true
			loops: Animation.Infinite
			fillMode: Image.PreserveAspectFit

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

			onClicked:
			{
				stackView.push(settingPageComponent)
			}
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

			onClicked:
			{
				stackView.push(leaderboardComponent)
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

			onClicked:
			{
				// FIXME add rel share api from jni android
				console.log("add real share")
			}
		}

		Item
		{
			Layout.fillWidth: true
		}
	}
}
