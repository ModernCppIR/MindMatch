import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

import Constant 1.0

import "../components"

Item {
    id:root

    property int remainingStars : 3
    property int starSize : root.width/12

    property bool isMusicOff: false

    property string questionStr : "Question"
    property var answersArray  : ["Answer 1", "Answer 2", "Answer 3", "Answer 4"]

    Component.onCompleted:  {

        navigationBar.visible = false
        mainMenuBar.visible = false
    }

    Rectangle{
        anchors.fill: parent
        color: Constant.lightBackgroundColor
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
            color: Qt.darker("#aa608da2")
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
                    text: qsTr("<")
                    font.pixelSize: 30
                    Layout.leftMargin: 5
                    Layout.topMargin: 5

                    onClicked: console.log("cliecked")

                    contentItem: Text
                    {
                        text: "\uf0d9"
                        font.family: fontLoader.name
                        font.pixelSize: 20
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
                        isMusicOff = !isMusicOff;
                    }

                    contentItem: Text
                    {
                        text: isMusicOff? "\uf6a9": "\uf028"
                        font.family: fontLoader.name
                        font.pixelSize: 20
                        font.styleName: "Solid"
                        anchors.verticalCenter:parent.verticalCenter
                        width: 45
                        height: 45
                        anchors.centerIn: parent
                        color: isMusicOff ? Constant.bluegrayTextColor : Constant.whiteColor
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
                            gradient: isMusicOff ? Constant.lightBackgroundGradient : Constant.blueGradient
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
                        source: remainingStars > index ? "qrc:/img/star.png": "qrc:/img/star_off.png"
                        sourceSize: Qt.size(starSize*scale ,starSize*scale)
                    }
                }
                Item{
                    Layout.fillWidth: true

                }
            }
            Label{
                text:"6/19"

                Layout.fillWidth: true

                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
            }
            BlueProgressBar {
                value: 0.5
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10

            }

            Label{
                text:"2 + 3 = ?"

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

        Repeater{
            model:4
            Label{
                text: answersArray[index]

                Layout.margins: 5
                Layout.fillWidth:  true
                Layout.fillHeight: true

                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter


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
                }
            }

        }
    }




}
