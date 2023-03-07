import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

import "../../components"
import Constant 1.0



Rectangle
{

    id:root

    property int starSize : root.width/12

	Component.onCompleted:
	{
		mainMenuBar.visible = true
		navigationBar.visible = false
		console.log(stackView.depth)
    }

    color:"transparent"

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
            Layout.bottomMargin: 50
            Layout.fillWidth: true

            // NOTE workaround for conflicting gradient and shadow
			Rectangle
			{
                id: infoRect
                anchors.fill: parent
                radius:infoCard.radius
            }
					RadialGradient
					{
                        anchors.fill:infoRect
                        source: infoRect
                        angle: 45
                        verticalRadius: 300
                        horizontalRadius: 300
                        horizontalOffset:-infoRect.width/2
                        verticalOffset: -infoRect.height/2
                        gradient: Constant.blueGradient
                    }

			ColumnLayout
			{
                anchors.fill: parent

                // NOTE chapter title
				Label
				{
                    text:qsTr("فصل اول")
                    font.pixelSize: Constant.h5FontSize
                    font.bold: true
                    color: Constant.darkTextColor

                    Layout.topMargin: 20
                    Layout.fillWidth: true

                    verticalAlignment:Qt.AlignVCenter
                    horizontalAlignment:Qt.AlignHCenter
                }

                // stars
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
                            source: 0 > index ? "qrc:/img/star.png": "qrc:/img/star_off.png"
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
                    text:qsTr("متاسفانه باختی")
                    font.pixelSize: Constant.h3FontSize
                    font.bold: true
                    color:Constant.whiteColor

                    Layout.topMargin: 20
                    Layout.fillWidth: true

                    verticalAlignment:Qt.AlignVCenter
                    horizontalAlignment:Qt.AlignHCenter
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
            text: qsTr("تلاش مجدد")
            implicitHeight:70
            Layout.leftMargin: 50
            Layout.rightMargin: 50
            Layout.fillWidth: true
			font.pixelSize: Constant.h4FontSize

			onClicked:
			{
				console.log("تلاش مجدد کلیک شد ")
				storyGameSession.restartSession();
				stackView.pop()
				stackView.push(countdownComponent)
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

			onClicked:
			{
				storyGameSession.restartSession();
				stackView.pop()
			}
        }
    }
}
