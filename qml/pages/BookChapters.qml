import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.2
import QtGraphicalEffects 1.15

import Constant 1.0

import "../../js/Utilities.js" as Utilities

Page
{

    Rectangle
    {
        id:backRect
        anchors.fill: parent
        color:Constant.whiteColor
        radius: 20
    }

    ListView
    {
        id:bookList
        anchors.fill: parent
        spacing: 20

		model: chaptersModel

		delegate: RoundButton
		{

            id: chapterButton
			property int starSize : chapterButton.height*0.5

			implicitHeight:70
			text:name
            width : parent? parent.width - 40 : 0
            anchors.left: parent ? parent.left : undefined
            anchors.leftMargin: 20
            radius: 10
            palette.button:Constant.whiteColor
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


			contentItem: RowLayout
			{
                anchors.fill: parent

				ColumnLayout
				{
					RowLayout
					{
						Repeater
						{
                            model:3

							Image
							{
                                Layout.leftMargin: 5
								source: stars > index ? "qrc:/img/star.png": "qrc:/img/star_off.png"
                                sourceSize: Qt.size(starSize,starSize)
                            }

                        }
                    }

					Text
					{
						text: Utilities.thousandSeparator(score)
                        Layout.alignment: Qt.AlignCenter
                    }
                }

				Text
				{
                    text:   chapterButton.text
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignRight
                }
            }

			onClicked:
			{
				gameManager.selectChapter(index)
				stackView.push(countdownComponent)
			}
        }

		header: Rectangle
		{
            height: 50
            anchors.left: parent.left
            anchors.right: parent.right
            color:"transparent"
        }

		footer: Rectangle
		{
            height: 50
            anchors.left: parent.left
            anchors.right: parent.right
            color:"transparent"
        }
    }
}
