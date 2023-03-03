import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0

import Constant 1.0

Item {
    id:root

    property int remainingStars : 3
    property int starSize : root.width/12

    Component.onCompleted:  {

        navigationBar.visible = false
        mainMenuBar.visible = false
    }

    Rectangle{
        anchors.fill: parent
        color: Constant.lightBackground
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
                Button {
                    text: qsTr("<")
                    implicitHeight: 50
                    implicitWidth:implicitHeight
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
                Button{
                    implicitHeight: 50
                    implicitWidth:implicitHeight
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
                        Layout.leftMargin: 5
                        source: remainingStars > index ? "qrc:/img/star.png": "qrc:/img/star_off.png"
                        sourceSize: Qt.size(starSize,starSize)
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
            ProgressBar {
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
                text:"answer: " + index

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
