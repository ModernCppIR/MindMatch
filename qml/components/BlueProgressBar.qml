import QtQuick 2.15
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.15

import Constant 1.0

ProgressBar {

    id: control
    value: 0.5
    padding: 2

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 10
        color: Constant.lightBackgroundColor
        radius: 3
    }

    contentItem: Item {
        implicitWidth: 200
        implicitHeight: 6

        Rectangle {
            id: handleRect
            width: control.visualPosition * parent.width
            height: parent.height
            radius: 2
            color: "#17a81a"

            RadialGradient  {
                anchors.fill: handleRect
                source: handleRect
                 angle: 45
                 verticalRadius: 300
                 horizontalRadius: 300
                 horizontalOffset:-handleRect.width/2
                 verticalOffset: -handleRect.height/2
                gradient:Constant.blueGradient
            }
        }
    }

}
