import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

import "../../components"
import "../../../js/Utilities.js" as Utilities
import "../../../js/Progress.js" as Pro

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
//				Label
//				{
//					id: bookAndChapterNameLabel
//					text:  qsTr(gameManager.currentBookName + " / " + storyGameSession.sessionName)
//					font.pixelSize: Constant.h5FontSize
//					font.bold: true
//					color: Constant.darkTextColor

//					Layout.topMargin: 20
//					Layout.fillWidth: true

//					verticalAlignment:Qt.AlignVCenter
//					horizontalAlignment:Qt.AlignHCenter
//				}

				// NOTE stars
//				RowLayout
//				{
//					id: starsRow
//					Layout.fillWidth: true

//					Item
//					{
//						Layout.fillWidth: true
//					}
//					Repeater
//					{
//						model:3

//						Image
//						{
//							property double scale : index == 1 ? 1.3 : 1
//							Layout.leftMargin: 5
//							Layout.bottomMargin: index == 1 ? 10 : 0
//							source: storyGameSession.starCount > index ? "qrc:/img/star.svg": "qrc:/img/star_off.svg"
//							sourceSize: Qt.size(starSize * scale ,starSize  * scale)

//							layer.enabled: true
//							layer.effect: DropShadow {
//								transparentBorder: true
//								horizontalOffset: 0
//								verticalOffset: 0
//								color: Constant.shadowColor
//								samples: 8
//								radius: 8
//								spread: 0.0
//							}
//						}
//					}

//					Item
//					{
//						Layout.fillWidth: true
//					}
//				}




//				Image
//				{
//					Layout.alignment: Qt.AlignCenter
//					source: "qrc:/img/throphy.png"
//					sourceSize: Qt.size((infoCard.width/3)*2 - 40,480/400 *((infoCard.width/3)*2 -40))

//					layer.enabled: true
//					layer.effect: DropShadow {
//						transparentBorder: true
//						horizontalOffset: 0
//						verticalOffset: 0
//						color: Constant.shadowColor
//						samples: 8
//						radius: 8
//						spread: 0.0
//					}
//				}

				Label
				{
					text:qsTr("آقای ریاضی")
					font.pixelSize: Constant.h3FontSize
					font.bold: true
					color: Constant.whiteColor

//					Layout.topMargin: 20
					Layout.fillWidth: true

					verticalAlignment:Qt.AlignVCenter
					horizontalAlignment:Qt.AlignHCenter
				}

				Image
				{

					sourceSize: Qt.size(infoCard.width - 10, infoCard.width)
					source: "qrc:/img/mustache.png"

					Layout.topMargin: 15
					Layout.leftMargin: 5
					Layout.rightMargin: 5

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

				IconicLabel
				{
					backgroundGradient: Constant.goldGradient
					text: 186 +"/"+327
					iconSrc: "qrc:/img/star.svg"
					implicitHeight: 100
					Layout.fillWidth: true
					Layout.leftMargin: 20
					Layout.rightMargin: 20
				}

				Item
				{
					Layout.fillHeight: true
				}
			}
		}

		Item
		{
			Layout.fillHeight: true
		}

		GeneralButton
		{
			text: qsTr("بستن")
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
				bannerpopup.close();
			}
		}
	}
}
