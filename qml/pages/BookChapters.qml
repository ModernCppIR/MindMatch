import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

Page {

    Rectangle
    {
        id:backRect
        anchors.fill: parent
        color:"#FFF"
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


    }

    ListView
    {
        id:bookList
        anchors.fill: parent
        Component.onCompleted: bookList.model = booksModel

        spacing: 20



        delegate: RoundButton{

            id: chapterButton
height:70
            text:chapterName
            //Text.horizontalAlignment: Qt.AlignRight
            width : parent? parent.width - 40 : 0
            anchors.left: parent ? parent.left : undefined
            anchors.leftMargin: 20
            radius: 10
            palette.button:"#FFF"
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
                ColumnLayout{
                    RowLayout{
                        Image{
                            source: "qrc:/img/star.png"
                            sourceSize: Qt.size(starSize,starSize)
                        }
                        Image{
                            source: "qrc:/img/star.png"
                            sourceSize: Qt.size(starSize,starSize)
                        }
                        Image{
                            source: "qrc:/img/star.png"
                            sourceSize: Qt.size(starSize,starSize)
                        }
                    }
                    Text{
                        text:"79,563"
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
