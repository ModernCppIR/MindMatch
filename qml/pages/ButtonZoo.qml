import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

import "../components"
import "../.."

Item {


        Rectangle
        {
            id:backRect
            anchors.fill: parent
            //        color:"#000"
            radius: 20
            LinearGradient {
                anchors.fill: backRect
                source: backRect
                start: Qt.point(0, backRect.height/2)
                end: Qt.point(backRect.width, backRect.height/2)
                gradient: Constant.blueGradient
            }
        }



        Column{
            anchors.fill: parent
            spacing:10
            topPadding: 20

            GeneralButton{
                text: "Click Me!"

                height:70
                anchors.left: parent.left
                anchors.right:parent.right
                anchors.leftMargin: 50
                anchors.rightMargin: 50

            }
            GeneralButton{
                text: "Click Me!"
                firstBackgroundColor: Constant.whiteColor
                secondBackgroundColor: Constant.whiteColor
                fontColor: "#92afc5"

                height:70
                anchors.left: parent.left
                anchors.right:parent.right
                anchors.leftMargin: 50
                anchors.rightMargin: 50

            }
            GeneralButton{
                text: ""
    //            firstBackgroundColor: Constant.whiteColor
    //            secondBackgroundColor: Constant.whiteColor
    //            fontColor: "#92afc5"

                height:350
                anchors.left: parent.left
                anchors.right:parent.right
                anchors.leftMargin: 50
                anchors.rightMargin: 50

            }


            Rectangle{

                height:90
                anchors.left: parent.left
                anchors.right:parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                GeneralButton{
                    text: "Click Me!"

                    firstBackgroundColor:  Constant.lightblue
                    secondBackgroundColor: Constant.darkblue
                    fontColor: Constant.whiteColor

                    height:70
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right:parent.right
                    anchors.topMargin: 10
                    anchors.leftMargin: 40
                    anchors.rightMargin: 40

                }
            }



        }
}
