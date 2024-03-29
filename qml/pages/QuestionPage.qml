import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

import Constant 1.0

import "../components/lottie" as Lottie
import "../components"

Item
{
	id:root

	property int starSize : root.width/6
	property bool correctAnswerSelected: false
	property bool matchFailed: false

	Component.onCompleted:
	{
		correctAnswerSelected= false
		matchFailed= false
		mainWindow.hideMenus()
	}

	Rectangle
	{
		id: questuionPageBackRect

		anchors.fill: parent

		RadialGradient
		{
			anchors.fill: questuionPageBackRect
			source: questuionPageBackRect
			gradient: Constant.blueGradient
		}
	}

	Label
	{
		id: questionCard

		anchors
		{
			top: parent.top
			left: parent.left
			right: parent.right
			bottom: parent.verticalCenter
			margins: 20
		}

		layer.enabled: true
		layer.effect: DropShadow
		{
			transparentBorder: true
			horizontalOffset: 0
			verticalOffset: 0
			color: Constant.shadowColor
			samples: 8
			radius: 8
			spread: 0.0
		}

		background:Rectangle
		{
			implicitHeight: root.implicitHeight
			implicitWidth:root.implicitWidth
			radius:10
		}


		ColumnLayout
		{
			anchors.fill: parent

			Item {
				Layout.alignment: Qt.AlignHCenter
				Layout.fillWidth: true
				implicitHeight:  50
				Lottie.LottieAnimation {
					id: lottieAnim

					width:  parent.width
					anchors.verticalCenter: parent.top
					anchors.verticalCenterOffset: 40
					source: "qrc:/lottie/ornament-animation.json"
					running: true
					clearBeforeRendering: true
					speed: 2
					loops: 0
					fillMode: Image.PreserveAspectFit
				}
			}

			RowLayout
			{
				RoundButton
				{
					id: backButton

					Layout.leftMargin: 5
					Layout.topMargin: 5

					contentItem: Text
					{
						text: "\uf0d9"
						font.family: fontLoader.name
						font.pixelSize: Constant.h5FontSize
						font.styleName: "Solid"
						anchors.verticalCenter:parent.verticalCenter
						width: 45
						height: 45
						anchors.centerIn: parent
						color: Constant.darkTextColor
						antialiasing:true
						verticalAlignment:Qt.AlignVCenter
						horizontalAlignment:Qt.AlignHCenter
					}

					implicitHeight: 50
					implicitWidth:implicitHeight

					background: Rectangle
					{
						id: currentButtonActive
						implicitWidth: backButton.implicitWidth
						implicitHeight: backButton.implicitHeight
						opacity: enabled ? 1 : 0.3
						radius: backButton.radius
						color: Constant.whiteColor
					}
				}

				Item
				{
					Layout.fillWidth: true
				}

				Label
				{
					text: qsTr(gameManager.currentBookName + " / " + storyGameSession.sessionName)
					verticalAlignment: Qt.AlignVCenter
					horizontalAlignment: Qt.AlignHCenter
				}

				Item
				{
					Layout.fillWidth: true
				}

				RoundButton
				{
					id:voiceButton
					implicitHeight: 50
					implicitWidth: implicitHeight
					palette.shadow: "#222"
					palette.button: Constant.lightBackgroundColor
					Layout.rightMargin: 5
					Layout.topMargin: 5

					onClicked:
					{
						storyGameSession.muted = !storyGameSession.muted;
					}

					contentItem: Text
					{
						text: storyGameSession.muted? "\uf6a9": "\uf028"
						font.family: fontLoader.name
						font.pixelSize: Constant.h5FontSize
						font.styleName: "Solid"
						anchors.verticalCenter: parent.verticalCenter
						width: 45
						height: 45
						anchors.centerIn: parent
						color: storyGameSession.muted ? Constant.bluegrayTextColor : Constant.whiteColor
						antialiasing:true

						verticalAlignment:Qt.AlignVCenter
						horizontalAlignment:Qt.AlignHCenter
					}

					background: Rectangle
					{
						id: voiceButtonBackRect
						implicitWidth: voiceButton.implicitWidth
						implicitHeight: voiceButton.implicitHeight
						opacity: enabled ? 1 : 0.3
						radius: voiceButton.radius

						RadialGradient
						{
							anchors.fill: voiceButtonBackRect
							source: voiceButtonBackRect
							angle: 45
							horizontalOffset:-voiceButtonBackRect.width/2
							verticalOffset: -voiceButtonBackRect.height/2
							gradient: storyGameSession.muted ? Constant.lightBackgroundGradient : Constant.blueGradient
						}
					}
				}
			}

			RowLayout
			{
				Layout.fillWidth: true
				Item
				{
					Layout.fillWidth: true
				}

				Repeater
				{
					model:3

					Image
					{
						property double scale : index == 1? 1.3 : 1
						Layout.leftMargin: 5
						Layout.bottomMargin: index == 1 ? 10 : 0
						source: storyGameSession.starCount > index ? "qrc:/img/star.svg": "qrc:/img/star_off.svg"
						sourceSize: Qt.size(starSize*scale ,starSize*scale)

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
				}

				Item
				{
					Layout.fillWidth: true
				}
			}

			Label
			{
				text: storyGameSession.currentQuestion + "/" + storyGameSession.totalQuestionsCount

				Layout.fillWidth: true

				verticalAlignment: Qt.AlignVCenter
				horizontalAlignment: Qt.AlignHCenter

				color: Constant.bluegrayTextColor
				font.pixelSize: Constant.h5FontSize
			}

			BlueProgressBar
			{
				from: 0
				to: 100
				value: storyGameSession.remainingTime
				Layout.fillWidth: true
				Layout.leftMargin: 10
				Layout.rightMargin: 10

			}

			Label
			{
				text: storyGameSession.questionString
				font.pixelSize: Constant.h3FontSize
				font.bold: true
				color: Constant.darkTextColor

				verticalAlignment: Qt.AlignVCenter
				horizontalAlignment: Qt.AlignHCenter

				Layout.fillHeight: true
				Layout.fillWidth: true
			}
		}
	}

	ColumnLayout
	{
		anchors
		{
			top: parent.verticalCenter
			left: parent.left
			right: parent.right
			bottom: parent.bottom
			margins: 20
		}

		Timer
		{
			id: nextQuestionTimer

			interval:500

			onTriggered:
			{
				storyGameSession.gotoNextQuestion();
				correctAnswerSelected = false;
			}
		}

		Timer
		{
			id:failedTimer

			interval:500

			onTriggered:
			{
				stackView.replace(storyFailurePageComponent)
				storyGameSession.leaveMatch();
			}
		}

		GridLayout
		{
			columns: 2
			columnSpacing: 10

			Repeater
			{
				model:storyGameSession

				Button
				{
					id: answerButton

					property bool doneQuestion : isSelected && isCorrect;

					text: context
					Layout.margins: 5
					Layout.fillWidth:  true
					Layout.fillHeight: true

					onClicked:
					{
						if(!correctAnswerSelected && !matchFailed && !isSelected)
						{
							storyGameSession.answerSelected(index);
						}
					}

					onDoneQuestionChanged:
					{
						if(doneQuestion == true)
						{
							correctAnswerSelected = true;
							nextQuestionTimer.start();
						}
					}

					layer.enabled: true
					layer.effect: DropShadow
					{
						transparentBorder: true
						horizontalOffset: 0
						verticalOffset: 0
						color: Qt.darker("#aa608da2")
						samples: 8
						radius: 8
						spread: 0.0
					}

					contentItem:Label
					{
						text: answerButton.text
						font.pixelSize: Constant.h3FontSize
						color: Constant.darkTextColor
						font.bold: true
						verticalAlignment: Qt.AlignVCenter
						horizontalAlignment: Qt.AlignHCenter
					}

					background:Rectangle
					{
						id: answerBackRect
						implicitHeight: 70
						implicitWidth:root.width - 20
						radius:10
						color: isSelected ? isCorrect ? Constant.greenColor : Constant.redColor : Constant.whiteColor

						RadialGradient
						{
							anchors.fill:  parent
							source: parent
							angle: 45
							verticalRadius: 300
							horizontalRadius: 300
							horizontalOffset: - parent.width/2
							verticalOffset: - parent.height/2
							gradient: isSelected && isCorrect ? Constant.greenGradient : isSelected ? Constant.redGradient : Constant.whiteGradient
						}
					}
				}
			}
		}
	}

	Connections
	{
		target : storyGameSession

		function onSuccessed()
		{
			stackView.replace(storySuccessPageComponent)

			if(gameManager.checkIfAllTheStarsAchieved())
			{
				mainWindow.showBanner(celebrateAllTheStarsAchievedComponent)
			}

			storyGameSession.leaveMatch();
		}

		function onFailed()
		{
			console.log("onFailed" )

			matchFailed = true;
			failedTimer.start();
		}
	}

}
