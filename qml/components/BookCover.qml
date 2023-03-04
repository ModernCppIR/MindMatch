import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import Constant 1.0

import "../../js/Utilities.js" as Utilities

Item {

    id:root

    signal clicked
    //    property string bookName
    //    property string operation: "+"
    property color operationColor : "#222"
    required property int achievedScore
    //    property int achievedStars: 27
    required property int achievedStars
    required property string operationString
    required property string bookName
    property int totalStars: 27

    property int logoSize : parent ? parent.width/8 : 0


    height:500
    property color secondBackgroundColor: "#ffffff"
    property color firstBackgroundColor: "#ffffff"
    //    anchors.left: parent ? parent.left : undefined
    //    anchors.right: parent ?  parent.right : undefined
    //    anchors.leftMargin: 50
    //    anchors.rightMargin: 50
    Button{
        anchors.fill: parent

        onClicked:{
            root.clicked()
        }

        background: Rectangle{
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
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 0
                verticalOffset: 0
                color: Qt.darker("#608da2")
                samples: 7
                radius: 8
                spread: 0.0
            }

        }

        ColumnLayout{
            anchors.fill: parent

            Text{
                text: bookName
                font.pixelSize: Constant.h2FontSize
                font.bold: true
                color: Constant.darkTextColor

                Layout.alignment: Qt.AlignCenter
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
            }

            Row{
                RotatedHexagon{
                    edgeSize: logoSize
                    Layout.rightMargin:10

                    Text{

                        text: operationString
                        color: Constant.whiteColor
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: 10
                        font {
                            bold: true
                            pixelSize: 100
                        }
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter
                    }
                }

                Layout.alignment: Qt.AlignHCenter

            }
            Item{
                Layout.fillHeight:true
            }

            RowLayout{

                Text{
                    id:scoreText


                    text: Utilities.thousandSeparator(achievedScore)
                    color: "#454545"
                    font.pixelSize: Constant.h3FontSize

                    Layout.leftMargin:20
                    Layout.alignment: Qt.AlignVCenter

                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                }
                Item{
                    Layout.fillWidth: true
                }
                Image{
                    id:scoreImage
                    Layout.rightMargin:10
                    source: "qrc:/img/diamond.png"
                    sourceSize: Qt.size(logoSize*2*0.8,logoSize*2*0.8)

                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 0
                        color: Qt.darker("#608da2")
                        samples: 7
                        radius: 8
                        spread: 0.0
                    }
                }
            }
            RowLayout{

                Layout.bottomMargin: 10

                Text{

                    text: achievedStars +"/"+totalStars
                    color: Constant.darkTextColor

                    Layout.leftMargin:20
                    Layout.alignment: Qt.AlignVCenter

                    font.pixelSize: Constant.h1FontSize

                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                }
                Item{
                    Layout.fillWidth: true
                }
                Image{
                    Layout.rightMargin:10
                    source: "qrc:/img/star.png"
                    sourceSize: Qt.size(logoSize*2*0.8,logoSize*2*0.8)

                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 0
                        color: Qt.darker("#608da2")
                        samples: 7
                        radius: 8
                        spread: 0.0
                    }
                }
            }
        }
    }
}
