import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

import Constant 1.0

import "../components"

Item {
    id:root

//    property int remainingStars : 3
    property int starSize : root.width/12

    property string questionStr : "2 + 3 = ?"
    property int totoalQuestionsCount : 16
    property int currentQuestionIndex : 6
//    property var answersArray  : ["Answer 1", "Answer 2", "Answer 3", "Answer 4"]
    property bool correctAnswerSelected:false

    Component.onCompleted:  {

        navigationBar.visible = false
        mainMenuBar.visible = false
        storyGameSession.start()
    }

    Rectangle{
        id:questuionPageBackRect
        anchors.fill: parent
        color: Constant.lightBackgroundColor

        //        LinearGradient{
        //            anchors.fill: questuionPageBackRect
        //            source: questuionPageBackRect
        //            gradient: Gradient {
        //                GradientStop { position: 0 ; color: Constant.whiteColor }
        //                GradientStop { position: 1 -  storyGameSession.remainingTime/100 ; color: Constant.whiteColor }
        //                GradientStop { position: 1 -  storyGameSession.remainingTime/100+ 0.01 ; color: storyGameSession.remainingTime/100 < 0.3 ? "red":  Constant.lightblue }
        //                GradientStop { position: 1; color: storyGameSession.remainingTime/100 < 0.3 ? "red" :Constant.lightblue }
        //            }
        //        }
    }



    Label{
        id: questionCard
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.verticalCenter
            margins: 20
        }

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
        background:Rectangle{
            implicitHeight: root.implicitHeight
            implicitWidth:root.implicitWidth
            radius:10
        }


        ColumnLayout
        {
            anchors.fill: parent
            RowLayout
            {
                RoundButton {
                    id: backButton
                    Layout.leftMargin: 5
                    Layout.topMargin: 5

                    onClicked: console.log("cliecked")

                    contentItem: Text
                    {
                        text: "\uf0d9"
                        font.family: fontLoader.name
                        font.pixelSize: Constant.h5FontSize
                        font.styleName: "Solid"
                        anchors.verticalCenter:parent.verticalCenter
                        width: 45
                        height: 45
                        anchors.centerIn: parent
                        color: Constant.darkTextColor
                        antialiasing:true
                        verticalAlignment:Qt.AlignVCenter
                        horizontalAlignment:Qt.AlignHCenter
                    }
                    implicitHeight: 50
                    implicitWidth:implicitHeight

                    background: Rectangle {
                        id: currentButtonActive
                        implicitWidth: backButton.implicitWidth
                        implicitHeight: backButton.implicitHeight
                        opacity: enabled ? 1 : 0.3
                        radius: backButton.radius
                        color: Constant.whiteColor
                    }
                }

                Item{
                    Layout.fillWidth: true
                }
                Label {
                    text: qsTr("فصل اول")
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                }
                Item{
                    Layout.fillWidth: true
                }

                RoundButton{
                    id:voiceButton
                    implicitHeight: 50
                    implicitWidth:implicitHeight
                    palette.shadow: "#222"
                    palette.button: Constant.lightBackgroundColor
                    Layout.rightMargin: 5
                    Layout.topMargin: 5

                    onClicked:
                    {
                        storyGameSession.muted = !storyGameSession.muted;
                    }

                    contentItem: Text
                    {
                        text: storyGameSession.muted? "\uf6a9": "\uf028"
                        font.family: fontLoader.name
                        font.pixelSize: Constant.h5FontSize
                        font.styleName: "Solid"
                        anchors.verticalCenter:parent.verticalCenter
                        width: 45
                        height: 45
                        anchors.centerIn: parent
                        color: storyGameSession.muted ? Constant.bluegrayTextColor : Constant.whiteColor
                        antialiasing:true

                        verticalAlignment:Qt.AlignVCenter
                        horizontalAlignment:Qt.AlignHCenter
                    }

                    background: Rectangle {
                        id: voiceButtonBackRect
                        implicitWidth: voiceButton.implicitWidth
                        implicitHeight: voiceButton.implicitHeight
                        opacity: enabled ? 1 : 0.3
                        radius: voiceButton.radius

                        RadialGradient  {
                            anchors.fill: voiceButtonBackRect
                            source: voiceButtonBackRect
                            angle: 45
                            horizontalOffset:-voiceButtonBackRect.width/2
                            verticalOffset: -voiceButtonBackRect.height/2
                            gradient: storyGameSession.muted ? Constant.lightBackgroundGradient : Constant.blueGradient
                        }
                    }
                }



            }
            RowLayout
            {
                Layout.fillWidth: true
                Item{
                    Layout.fillWidth: true
                }
                Repeater{
                    model:3
                    Image{
                        property double scale : index == 1? 1.3 : 1
                        Layout.leftMargin: 5
                        Layout.bottomMargin: index == 1 ? 10 : 0
                        source: storyGameSession.starCount > index ? "qrc:/img/star.png": "qrc:/img/star_off.png"
                        sourceSize: Qt.size(starSize*scale ,starSize*scale)

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
                Item{
                    Layout.fillWidth: true

                }
            }
            Label{
                text: currentQuestionIndex+"/"+totoalQuestionsCount

                Layout.fillWidth: true

                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
            }
            BlueProgressBar {
                from: 0
                to: 100
                value: storyGameSession.remainingTime
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10

            }

            Label{
                text:questionStr

                Layout.fillHeight: true
                Layout.fillWidth: true

                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
            }
        }
    }

    GridLayout{

        columns:2

        anchors{
            top: parent.verticalCenter
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 20
        }

        Timer{
            id:nextQuestionTimer
            interval:500
            onTriggered: {
                storyGameSession.gotoNextQuestion();
                correctAnswerSelected = false;
            }
        }
        Timer{
            id:failedTimer
            interval:500
            onTriggered: {
                stackView.push("qrc:/qml/pages/Story/StoryFailurePage.qml")
                storyGameSession.leaveMatch();

            }
        }

        Repeater{
            model:storyGameSession

            Button{
                text: context
                property bool doneQuestion : isSelected && isCorrect;

                Layout.margins: 5
                Layout.fillWidth:  true
                Layout.fillHeight: true

                onClicked: {
                    if(!correctAnswerSelected)
                    {
                        storyGameSession.answerSelected(index);
                    }

                }
                onDoneQuestionChanged:
                {
                    console.log("onDoneQuestionChanged: ", doneQuestion)
                    if(doneQuestion == true)
                    {
                        correctAnswerSelected = true;
                        nextQuestionTimer.start();
                    }
                }
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 0
                    verticalOffset: 0
                    color: Qt.darker("#aa608da2")
                    samples: 8
                    radius: 8
                    spread: 0.0
                }

                background:Rectangle{
                    implicitHeight: 70
                    implicitWidth:root.width - 20
                    radius:10
                    color:isSelected? isCorrect ?"green":"red" : "white"
                }
            }

        }
    }


Connections{
    target : storyGameSession
    function onSuccessed()
    {
        console.log("successed")
        stackView.push("qrc:/qml/pages/Story/StorySuccessPage.qml")
    }
    function onFailed()
    {
        console.log("failed")
        failedTimer.start();
    }
}

}
