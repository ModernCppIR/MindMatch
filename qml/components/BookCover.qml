import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import Constant 1.0

import "../../js/Utilities.js" as Utilities

Item
{

	id:root

	signal clicked
	property int logoSize


	Button
	{
		anchors.fill: parent

		onClicked:{
			root.clicked()
		}

		background: Rectangle
		{
			id:button_back

			anchors.fill: parent
			color:Constant.whiteColor
			radius: 20



			//        RadialGradient  {
			//            anchors.fill:button_back

			//            source: button_back
			//            angle: 45
			//            verticalRadius: 300
			//            horizontalRadius: 300
			//            horizontalOffset:-button_back.width/2
			//            verticalOffset: -button_back.height/2
			//            gradient: Gradient {
			//                GradientStop { position: 0; color: Constant.whiteColor}
			//                GradientStop { position: 1; color: Constant.whiteColor }
			//            }
			//        }
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

		ColumnLayout
		{
			anchors.fill: parent

			spacing:0

			Text
			{
				text: name
				font.pixelSize: Constant.h2FontSize
				font.bold: true
				color: Constant.darkTextColor

				Layout.alignment: Qt.AlignCenter
				verticalAlignment: Qt.AlignVCenter
				horizontalAlignment: Qt.AlignHCenter
			}

			RowLayout
			{
				Item
				{
					Layout.fillWidth:true
				}

				Repeater
				{

					model: operationList

					RotatedHexagon
					{
						edgeSize: logoSize
						Layout.rightMargin:10

						Text{
							text: modelData
							color: Constant.whiteColor
							anchors.centerIn: parent
							anchors.verticalCenterOffset: 10
							font {
								bold: true
								pixelSize: Constant.h2FontSize
							}
							verticalAlignment: Qt.AlignVCenter
							horizontalAlignment: Qt.AlignHCenter
						}
					}
				}

				Item
				{
					Layout.fillWidth:true
				}
			}

			Item
			{
				Layout.fillHeight:true
			}

			IconicLabel
			{
				backgroundGradient: score == 0  ? Constant.whiteGradient  : Constant.blueGradient
				textColor: score == 0 ? Constant.darkTextColor : Constant.lightTextColor
				text: Utilities.thousandSeparator(score)
				iconSrc: "qrc:/img/diamond.png"
				implicitHeight: 100
				Layout.fillWidth: true
				Layout.leftMargin: 20
				Layout.rightMargin: 20
			}

			IconicLabel
			{
				backgroundGradient: achievedStars == totalStars ? Constant.goldGradient : Constant.whiteGradient
				text: achievedStars +"/"+totalStars
				iconSrc: "qrc:/img/star.png"
				implicitHeight: 100
				Layout.fillWidth: true
				Layout.leftMargin: 20
				Layout.rightMargin: 20
				Layout.bottomMargin: 20
			}
		}
	}
}
