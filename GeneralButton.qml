import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import Constant 1.0

Button {
    id:root

    property color firstBackgroundColor:Constant.gold
    property color secondBackgroundColor:Constant.orange
    property color fontColor: "#fff"
    property double buttonRadius: 20
    property int fontPixelSize: 20

    contentItem: Text {
        id:text
        anchors.centerIn: parent
        text:root.text
        visible: true
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        color:fontColor
        font.bold:true
        font.pixelSize: fontPixelSize
//        LinearGradient  {
//            anchors.fill: text
//            source: text
//            start: Qt.point(text.width/2, 0)
//            end: Qt.point(text.width/2, text.height)
//            gradient: Gradient {
//                GradientStop { position: 0; color: "#fff" }
//                GradientStop { position: 1; color: "#222" }
//            }
//        }
    }

    background: Rectangle{
        id:button_back
        radius: buttonRadius
        RadialGradient  {
            anchors.fill: button_back
            source: button_back
             angle: 45
             verticalRadius: 300
             horizontalRadius: 300
             horizontalOffset:-root.width/2
             verticalOffset: -root.height/2
//                    start: Qt.point(0, 0)
//                    end: Qt.point(button_back.width/2, button_back.height)
            gradient: Gradient {
                GradientStop { position: 0; color: firstBackgroundColor }
//                GradientStop { position: 0.5; color: orange }
                GradientStop { position: 1; color: secondBackgroundColor }
            }
        }
    }
}
