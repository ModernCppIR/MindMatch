import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import Qt.labs.lottieqt 1.0

import Constant 1.0

Label{
    id:root
//    anchors.fill: parent
    signal done()

    property int countNumber: 4
    property int interval: 1000
    property int currentNumer: countNumber
    property int numberSize: 1000

//    font.pixelSize: numberSize

//    text: currentNumer

    Component.onCompleted:  {

        navigationBar.visible = false
        mainMenuBar.visible = false
    }

    LottieAnimation {
        anchors.centerIn:parent
        loops: 1 //LottieAnimation.Infinite
        quality: LottieAnimation.HighQuality
        source: "qrc:/lottie/countdown.json"
        onStatusChanged: {
            if (status === LottieAnimation.Ready) {
                // any acvities needed before
                // playing starts go here
//                frameRate = 25;
                gotoAndPlay(0);
            }
        }
        onFinished: {
            done()
        }
    }



//    Behavior on currentNumer {
//        ParallelAnimation{
//            PropertyAnimation {
//                target: root
//                property: "numberSize"
//                from:50
//                to: 500
//                easing.type: Easing.InElastic
//                duration: 500
//            }
//            PropertyAnimation {
//                target: root
//                property: "opacity"
//                from:0.3
//                to: 1
//                easing.type: Easing.OutQuad
//                duration: 500
//            }
//        }
//    }

    verticalAlignment:Qt.AlignVCenter
    horizontalAlignment:Qt.AlignHCenter

    background: Rectangle{
        id:countdownBackRect
        anchors.fill: parent
        color:Constant.whiteColor
//        RadialGradient  {
//            anchors.fill:countdownBackRect
//            source: countdownBackRect
//            angle: 45
//            verticalRadius: 300
//            horizontalRadius: 300
//            horizontalOffset:-countdownBackRect.width/2
//            verticalOffset: -countdownBackRect.height/2
//            gradient: Constant.lightBackgroundGradient
//        }
    }


//    function start()
//    {
//        countDown()
//        timer.start()
//    }

//    function countDown()
//    {
//        if(currentNumer == 1)
//        {
//            timer.stop()
//            done();
//            return;
//        }
//        currentNumer -=1;

//    }

//    Timer
//    {
//        id:timer
//        interval: root.interval
//        repeat: true
//        onTriggered: {

//            countDown();
//        }
//    }

}
