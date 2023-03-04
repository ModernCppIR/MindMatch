import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

import "../../components"
import Constant 1.0



Rectangle {

    Component.onCompleted: {
        navigationBar.visible = true
        mainMenuBar.visible = true
    }

    color:"transparent"
    id:root

    ColumnLayout
    {
        anchors.fill: parent

        Card{
            Layout.fillHeight: true
            Layout.leftMargin: 35
            Layout.rightMargin: 35
            Layout.topMargin: 35
            Layout.bottomMargin: 50
            Layout.fillWidth: true

            ColumnLayout{
                anchors.fill: parent
                Label{
                    text:qsTr("متاسفانه باختی")
                    font.pixelSize: Constant.h4FontSize
                    font.bold: true
                    color:Constant.darkTextColor

                    Layout.topMargin: 20
                    Layout.fillWidth: true

                    verticalAlignment:Qt.AlignVCenter
                    horizontalAlignment:Qt.AlignHCenter
                }

                Item{
                    Layout.fillHeight: true

                }
            }


        }

        Item{
            Layout.fillHeight: true


        }

        GeneralButton{
            text: qsTr("تلاش مجدد")

            implicitHeight:70
            Layout.leftMargin: 50
            Layout.rightMargin: 50
            Layout.fillWidth: true


        }
        GeneralButton{
            text: qsTr("آموزش بازی")
            firstBackgroundColor: Constant.whiteColor
            secondBackgroundColor: Constant.whiteColor
            fontColor: Constant.bluegray

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
        }
    }

    //LinearGradient  {
    //    anchors.fill: root
    //    source: root
    ////     angle: 45
    ////     verticalRadius: 300
    ////     horizontalRadius: 300
    ////     horizontalOffset:-root.width/2
    ////     verticalOffset: -root.height/2
    //    gradient: Gradient {
    //        GradientStop { position: 0; color: Constant.redColor }
    //        GradientStop { position: 1; color: Qt.lighter(Constant.redColor) }
    //    }
    //}

}
