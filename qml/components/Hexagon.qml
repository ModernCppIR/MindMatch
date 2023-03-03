import QtQuick 2.0
import QtQuick.Shapes 1.15

Item {
    property double edgeSize: 10
    property double h: Math.sqrt(Math.pow(edgeSize,2) - Math.pow(edgeSize/2 , 2))
    property color fColor:""

    width : 2*edgeSize
    height : 2*h

    Shape{
        ShapePath {
            fillColor:fColor
               strokeWidth: 1
               strokeColor: "#222"
//               fillGradient: LinearGradient {
//                   x1: 20; y1: 20
//                   x2: 180; y2: 130
//                   GradientStop { position: 0; color: "blue" }
//                   GradientStop { position: 0.2; color: "green" }
//                   GradientStop { position: 0.4; color: "red" }
//                   GradientStop { position: 0.6; color: "yellow" }
//                   GradientStop { position: 1; color: "cyan" }
//               }
               strokeStyle: ShapePath.SolidLine
//               dashPattern: [ 1, 4 ]
               startX: edgeSize / 2; startY: 0
//               PathLine { x: edgeSize / 2     ; y: 0 }
               PathLine { x: 1.5 * edgeSize ; y: 0 }
               PathLine { x: 2   * edgeSize ; y: h }
               PathLine { x: 1.5   * edgeSize ; y: 2*h }
               PathLine { x: edgeSize / 2 ; y: 2*h }
               PathLine { x: 0 ; y: h }
//               PathLine { x: edgeSize / 2  ; y: 0 }
           }
    }
}
