import QtQuick 2.15
import QtQuick.Shapes 1.15

import Constant 1.0

Item {
    id:root

    property double edgeSize: 10
    property double h: Math.sqrt(Math.pow(edgeSize,2) - Math.pow(edgeSize/2 , 2))
    property color fColor:"transparent"
    property color tColor:"transparent"

    width : 2*h
    height : 2*edgeSize

    Shape{
        id:shapeRoot
        ShapePath {
            fillColor:fColor != tColor ? fColor:"#222"
            strokeWidth: 1
            strokeColor: tColor
            strokeStyle: ShapePath.SolidLine
            joinStyle: ShapePath.RoundJoin
            startX: h   ; startY: 0
            PathLine { x: 2*h ; y: edgeSize/2 }
            PathLine { x: 2*h ; y: edgeSize  *1.5 }
            PathLine { x: h ; y: edgeSize  * 2 }
            PathLine { x: 0 ; y: edgeSize  * 1.5 }
            PathLine { x: 0 ; y: edgeSize  * 0.5 }

            fillGradient:         LinearGradient  {
                x1: 0; y1: 0
                x2: width; y2: height
                GradientStop { position: 0; color: fColor != tColor ? fColor : Constant.gold }
                GradientStop { position: 1; color: fColor != tColor ? fColor : Constant.orange }
            }
        }
    }
}
