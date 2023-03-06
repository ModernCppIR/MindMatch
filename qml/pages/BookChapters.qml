import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.2
import QtGraphicalEffects 1.15

import Constant 1.0

import "../../js/Utilities.js" as Utilities

Page {

    Rectangle
    {
        id:backRect
        anchors.fill: parent
        color:Constant.whiteColor
        radius: 20
    }

    ListModel{
        id:booksModel
        ListElement{
            chapterName:"فصل اول"
            achievedStars:3
            achievedScore:7753

        }
        ListElement{
            chapterName:"فصل دوم"
            achievedStars:2
            achievedScore:67291

        }
        ListElement{
            chapterName:"فصل سوم"
            achievedStars:1
            achievedScore:93625
        }
		ListElement{
			chapterName:"فصل چهارم"
			achievedStars:0
			achievedScore:0
		}
		ListElement{
			chapterName:"فصل پنجم"
			achievedStars:0
			achievedScore:0
		}
		ListElement{
			chapterName:"فصل ششم"
			achievedStars:0
			achievedScore:0
		}
		ListElement{
			chapterName:"فصل هفتم"
			achievedStars:0
			achievedScore:0
		}
		ListElement{
			chapterName:"فصل هشتم"
			achievedStars:0
			achievedScore:0
		}
		ListElement{
			chapterName:"فصل نهم"
			achievedStars:0
			achievedScore:0
		}


    }

    ListView
    {
        id:bookList
        anchors.fill: parent
        Component.onCompleted: bookList.model = booksModel

        spacing: 20



        delegate: RoundButton{

            id: chapterButton
            implicitHeight:70
            text:chapterName
            //Text.horizontalAlignment: Qt.AlignRight
            width : parent? parent.width - 40 : 0
            anchors.left: parent ? parent.left : undefined
            anchors.leftMargin: 20
            radius: 10
            palette.button:Constant.whiteColor
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 0
                verticalOffset: 0
                color: Qt.darker("#aa608da2")
                samples: 8
                radius: 8
                spread: 0.0
            }
            property int starSize : chapterButton.height*0.5


            contentItem:
                RowLayout{
                //                implicitHeight: chapterButton.implicitHeight
                //                implicitWidth: chapterButton.implicitWidth
                anchors.fill: parent

                ColumnLayout{
                    RowLayout{
                        Repeater{
                            model:3
                            Image{
                                Layout.leftMargin: 5
                                source: achievedStars > index ? "qrc:/img/star.png": "qrc:/img/star_off.png"
                                sourceSize: Qt.size(starSize,starSize)
                            }

                        }
                    }
                    Text{
                        text: Utilities.thousandSeparator(achievedScore)
                        Layout.alignment: Qt.AlignCenter

                    }
                }

                Text{
                    text:   chapterButton.text
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignRight

                }
            }


        }

        header: Rectangle{
            height: 50
            anchors.left: parent.left
            anchors.right: parent.right
            color:"transparent"
        }
        footer: Rectangle{
            height: 50
            anchors.left: parent.left
            anchors.right: parent.right
            color:"transparent"
        }
    }


}
