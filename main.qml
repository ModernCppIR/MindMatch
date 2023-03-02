import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import Qt.labs.lottieqt 1.0

ApplicationWindow
{

    flags: Qt.FramelessWindowHint

    visible: true
    height: 900
    width: 420
    color: "white"




    header: ToolBar {

        // ...

    }

    Drawer {

           // ...

       }

       StackView {
           id: stackView
           anchors.fill: parent
           initialItem: BookList {}
       }




//    LottieAnimation {
//        anchors.centerIn:parent
//        loops: LottieAnimation.Infinite
//        quality: LottieAnimation.MediumQuality
//        source: "qrc:/lottie/d327eb1b-a19e-4c7b-badc-3618f122c8af.json"
//        autoPlay: true
//        onStatusChanged: {
//            if (status === LottieAnimation.Ready) {
//                // any acvities needed before
//                // playing starts go here
//                gotoAndPlay(startFrame);
//            }
//        }
//        onFinished: {
//            console.log("Finished playing")
//        }
//    }

//    AnimatedImage{
//        id:scoreImage
//        source: "qrc:/gif/18551-cup-of-tea.gif"
//        anchors.centerIn: parent

//    }

//    BookList{
//        anchors.fill: parent
//    }

//    Rectangle
//    {
//        id:backRect
//        anchors.fill: parent
//        //        color:"#000"
//        radius: 20
//        LinearGradient {
//            anchors.fill: backRect
//            source: backRect
//            start: Qt.point(0, backRect.height/2)
//            end: Qt.point(backRect.width, backRect.height/2)
//            gradient: Gradient {
//                GradientStop { position: 0; color: Constant.lightblue }
//                GradientStop { position: 0.5; color: "#5ae9f9" }
//                GradientStop { position: 1; color:  Constant.darkblue }
//            }
//        }
//    }



//    Column{
//        anchors.fill: parent
//        spacing:10
//        topPadding: 20

//        GeneralButton{
//            text: "Click Me!"

//            height:70
//            anchors.left: parent.left
//            anchors.right:parent.right
//            anchors.leftMargin: 50
//            anchors.rightMargin: 50

//        }
//        GeneralButton{
//            text: "Click Me!"
//            firstBackgroundColor: "#fff"
//            secondBackgroundColor: "#fff"
//            fontColor: "#92afc5"

//            height:70
//            anchors.left: parent.left
//            anchors.right:parent.right
//            anchors.leftMargin: 50
//            anchors.rightMargin: 50

//        }
//        GeneralButton{
//            text: ""
////            firstBackgroundColor: "#fff"
////            secondBackgroundColor: "#fff"
////            fontColor: "#92afc5"

//            height:350
//            anchors.left: parent.left
//            anchors.right:parent.right
//            anchors.leftMargin: 50
//            anchors.rightMargin: 50

//        }


//        Rectangle{

//            height:90
//            anchors.left: parent.left
//            anchors.right:parent.right
//            anchors.leftMargin: 10
//            anchors.rightMargin: 10

//            GeneralButton{
//                text: "Click Me!"

//                firstBackgroundColor:  Constant.lightblue
//                secondBackgroundColor: Constant.darkblue
//                fontColor: "#FFF"

//                height:70
//                anchors.top: parent.top
//                anchors.left: parent.left
//                anchors.right:parent.right
//                anchors.topMargin: 10
//                anchors.leftMargin: 40
//                anchors.rightMargin: 40

//            }
//        }



//    }

}
