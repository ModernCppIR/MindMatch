import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0
import Constant 1.0

Item {

    id:root
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


    property bool completed: achievedStars == totalStars

    height:500
    property color secondBackgroundColor: "#ffffff"
    property color firstBackgroundColor: "#ffffff"
    //    anchors.left: parent ? parent.left : undefined
    //    anchors.right: parent ?  parent.right : undefined
    //    anchors.leftMargin: 50
    //    anchors.rightMargin: 50

    Rectangle{
        id:button_back
        anchors.fill: parent
        color:"#fffbf3"
        radius: 20

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 0
            color: "#608da2"
            samples: 7
            radius: 8
            spread: 0.0
        }


        RadialGradient  {
            anchors.fill: completed? button_back: undefined
            source:completed? button_back: undefined
            angle: 45
            verticalRadius: 300
            horizontalRadius: 300
            horizontalOffset:-root.width/2
            verticalOffset: -root.height/2
            gradient: Gradient {
                GradientStop { position: 0; color: Constant.gold }
                GradientStop { position: 1; color: Constant.orange }
            }
        }

    }

    ColumnLayout{
        anchors.fill: parent

        Text{
            text: bookName
            font.pixelSize: 60
            font.bold: true
            color:"#454545"

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
                    color: "#fff"
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
                function thousandSeparator(input){
                    return input.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
                }

                text:thousandSeparator(achievedScore)
                color:"#454545"
                font.pixelSize: 45

                Layout.leftMargin:10
                Layout.alignment: Qt.AlignVCenter

                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
            }
            Item{
                Layout.fillWidth: true
            }
            RotatedHexagon{
                edgeSize: logoSize
                Layout.rightMargin:10
                fColor:"#e0f0fc"
                Image{
                    id:scoreImage
                    source: "qrc:/img/diamond.png"
                    sourceSize: Qt.size(parent.width*0.8,parent.width*0.8)
                    anchors.centerIn:parent
                }
            }


        }
        RowLayout{

            Layout.bottomMargin: 10

            Text{

                text: achievedStars +"/"+totalStars
                color:"#454545"

                Layout.leftMargin:10
                Layout.alignment: Qt.AlignVCenter

                font.pixelSize: 75

                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
            }
            Item{
                Layout.fillWidth: true
            }
            //            Image{
            //                source: "qrc:/img/star.png"
            //                Layout.rightMargin:10
            //            }
            RotatedHexagon{
                edgeSize: logoSize
                Component.onCompleted: logoSize
                Layout.rightMargin:10
                fColor:"#e0f0fc"
                Image{
                    source: "qrc:/img/star.png"
                    sourceSize: Qt.size(parent.width*0.8,parent.width*0.8)
                    anchors.centerIn:parent
                    antialiasing: true
                    smooth: true
                }
            }
        }


    }
}
