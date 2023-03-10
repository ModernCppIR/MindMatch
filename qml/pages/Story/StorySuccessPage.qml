import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

import "../../components"
import "../../../js/Utilities.js" as Utilities
import "../../../js/Progress.js" as Pro
import "../../components/lottie" as Lottie


import Constant 1.0

Rectangle
{
	id: root

	property color particleColor: Constant.darkblue

	Component.onCompleted:
	{
		mainMenuBar.visible = true
		navigationBar.visible = false
	}

	color:"transparent"
	property int starSize : infoCard.width/6

	ColumnLayout
	{
		anchors.fill: parent
		spacing: 15
		Card
		{
			id: infoCard
			Layout.fillHeight: true
			Layout.leftMargin: 35
			Layout.rightMargin: 35
			Layout.topMargin: 35
			Layout.bottomMargin: 25
			Layout.fillWidth: true

			// NOTE workaround for conflicting gradient and shadow
			Rectangle
			{
				id: infoRect
				anchors.fill: parent
				radius: infoCard.radius
			}

			RadialGradient
			{
				anchors.fill: infoRect
				source: infoRect
				angle: 45
				verticalRadius: 300
				horizontalRadius: 300
				horizontalOffset:-infoRect.width/2
				verticalOffset: -infoRect.height/2
				gradient:Constant.goldGradient
			}

			ColumnLayout
			{
				spacing:0
				anchors.fill: parent

				// NOTE chapter title
				Label
				{
					id: bookAndChapterNameLabel
					text:  qsTr(gameManager.currentBookName + " / " + storyGameSession.sessionName)
					font.pixelSize: Constant.h5FontSize
					font.bold: true
					color: Constant.darkTextColor

					Layout.topMargin: 20
					Layout.fillWidth: true

					verticalAlignment:Qt.AlignVCenter
					horizontalAlignment:Qt.AlignHCenter
				}

				// NOTE stars
				RowLayout
				{
					id: starsRow
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
							property double scale : index == 1 ? 1.3 : 1
							Layout.leftMargin: 5
							Layout.bottomMargin: index == 1 ? 10 : 0
							source: storyGameSession.starCount > index ? "qrc:/img/star.svg": "qrc:/img/star_off.svg"
							sourceSize: Qt.size(starSize * scale ,starSize  * scale)
							antialiasing: true
							smooth: true
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

				Item {
					Layout.fillWidth: true
					Layout.fillHeight: true
					Lottie.LottieAnimation
					{
						id: lottieAnim
						width:  parent.width
						height:  parent.height * 2
						anchors.centerIn: parent
						anchors.verticalCenterOffset:  height * 1/10
						source: "qrc:/lottie/champion.json"
						running: true
						clearBeforeRendering: true
						clip: true
						loops: 0
						fillMode: Image.PreserveAspectFit

						onFinished:
						{
							console.log("finish is working");
						}
					}
				}

				Label
				{
					text:qsTr("برنده شدی!")
					font.pixelSize: Constant.h3FontSize
					font.bold: true
					color: Constant.whiteColor

					Layout.topMargin: 20
					Layout.fillWidth: true

					verticalAlignment:Qt.AlignVCenter
					horizontalAlignment:Qt.AlignHCenter
				}

				IconicLabel
				{
					backgroundGradient:  Constant.blueGradient
					textColor:  Constant.lightTextColor
					text: Utilities.thousandSeparator(storyGameSession.currentLevelScore)
					iconSrc: "qrc:/img/diamond.svg"
					implicitHeight: 100
					Layout.fillWidth: true
					Layout.leftMargin: 20
					Layout.rightMargin: 20
				}

				//				Item
				//				{
				//					Layout.fillHeight: true
				//				}
			}


			//			Canvas
			//			{
			//				id: canvas
			//				anchors.fill: parent

			//				property  bool firstTime : true

			//				Timer
			//				{
			//					interval: 1000/60
			//					running: true
			//					repeat: true
			//					onTriggered: canvas.requestPaint()
			//				}

			//				onWidthChanged:Pro.setSizes(canvas.width , canvas.height)
			//				onHeightChanged: Pro.setSizes(canvas.width , canvas.height)

			//				onPaint:
			//				{
			//					if(firstTime)
			//					{
			//						Pro.setSizes(canvas.width , canvas.height)
			//						Pro.setCtx(canvas.getContext("2d"));
			//						Pro.setBar(new Pro.Progressbar())
			//						Pro.x = 0;
			//						Pro.y = starsRow.y + starsRow.height;
			//						Pro.particleColor = root.particleColor
			//						firstTime = false
			//					}

			//					Pro.draw();
			//				}
			//			}


			//			Lottie.LottieAnimation {
			//							anchors.fill: parent
			//		//		Layout.fillWidth: true
			//		//		implicitHeight: 200
			//		//					width:  parent.width
			//		//					height:  parent.height
			//				source: "qrc:/lottie/success-particles.json"
			//				running: true
			//				clearBeforeRendering: true
			//				//		speed: speedSlider.value
			//				loops: 0
			//				fillMode: Image.PreserveAspectFit

			//				onFinished:
			//				{
			//					console.log("finish is working");
			//		//						done();
			//				}
			//			}

		}

		Item
		{
			Layout.fillHeight: true
		}

		GeneralButton
		{
			text: gameManager.currentChapter + 1 == 9 ? qsTr("کتاب بعد"):qsTr("مرحله بعد")
			visible: !gameManager.currentBookIsLast

			implicitHeight:70
			Layout.leftMargin: 50
			Layout.rightMargin: 50
			Layout.fillWidth: true
			font.pixelSize: Constant.h4FontSize

			onClicked:
			{
				if(gameManager.currentChapter + 1 == 9)
				{
					gameManager.goToNextChapter();
					stackView.pop()
				}
				else
				{
					gameManager.goToNextChapter();
					stackView.replace(countdownComponent)
				}
			}
		}

		GeneralButton
		{
			text: qsTr("بازگشت به منوی اصلی")
			backGroundGradient: Constant.whiteGradient
			fontColor: Constant.bluegray
			font.pixelSize: Constant.h5FontSize
			implicitHeight:70
			Layout.leftMargin: 50
			Layout.rightMargin: 50
			Layout.bottomMargin:  50
			Layout.fillWidth: true

			onClicked:
			{
				storyGameSession.restartSession();

				var item = stackView.find(function(item, index) { return item.objectName === "BookList" })
				console.log(item)
				stackView.pop(item);

//				stackView.pop(bookListComponent)
//				stackView.pop()
			}
		}
	}
}
