import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import Constant 1.0

import "../../js/Utilities.js" as Utilities

Item {

    id:root

    signal clicked
    property color operationColor : "#222"
    required property int achievedScore
    required property int achievedStars
    required property string operationString
    required property string bookName
    property int totalStars: 27

    property int logoSize : parent ? parent.width/8 : 0

    height:500

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

            spacing:20

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
							pixelSize: Constant.h2FontSize
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

            IconicLabel{
				backgroundGradient: achievedScore == 0  ? Constant.whiteGradient  : Constant.blueGradient
				textColor: achievedScore == 0 ? Constant.darkTextColor : Constant.lightTextColor
                text: Utilities.thousandSeparator(achievedScore)
                iconSrc: "qrc:/img/diamond.png"
                implicitHeight: 100
                Layout.fillWidth: true
                Layout.leftMargin: 20
                Layout.rightMargin: 20
            }

            IconicLabel{
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
