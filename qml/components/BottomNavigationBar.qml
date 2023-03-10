import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import QtQuick.Layouts 1.15

import Notched 1.0
import Constant 1.0

import QtGraphicalEffects 1.15


Item {
    id:root
    property int currentIndex : 2

    property real buttonRadius : 40
    property real cornerRadius : 40
    property real buttonMargin: 3
    property real buttonY: -15
    NotchedRectangle {
        id: rect
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        property bool shown: true
        height: shown ? parent.height  : 0
        Behavior on height {
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: 500
            }
        }
        notchCenter: Qt.point(fab.x + fab.width / 2, fab.y + fab.height / 2)
        notchRadius: (fab.width / 2 + buttonMargin) * fab.scale
        cornerRadius: root.cornerRadius * fab.scale
		color: Constant.darkblue

        RoundButton {
            id: fab
            x: centerX - width / 2
            y: buttonY - height / 2 + rect.height - root.height / 2
            z:5
            width: buttonRadius * 2
            height: width
            palette.shadow: "#222"

            property double centerX: parent.width / 2
            Behavior on centerX {
                SequentialAnimation {
                    PropertyAnimation {
                        target: fab
                        property: "scale"
                        to: 0
                        easing.type: Easing.OutQuad
                        duration: 150
                    }
                    PropertyAction {}
                    PropertyAnimation {
                        target: fab
                        property: "scale"
                        to: 1
                        easing.type: Easing.OutQuad
                        duration: 150
                    }
                }
            }
            background: Rectangle {
                id: currentButtonActive
                    implicitWidth: fab.implicitWidth
                    implicitHeight: fab.implicitHeight
                    opacity: enabled ? 1 : 0.3
                    border.color: "transparent"
                    border.width: 1
                    radius: fab.radius
                    RadialGradient  {
                        anchors.fill: currentButtonActive
                        source: currentButtonActive
                         angle: 45
                         horizontalOffset:-currentButtonActive.width/2
                         verticalOffset: -currentButtonActive.height/2
                        gradient: Constant.goldGradient
                    }
                }

        }
        // NOTE effect performance
        //        DropShadow {
        //            anchors.fill: fab
        //            horizontalOffset: 0
        //            verticalOffset: 3
        //            radius: 8.0
        //            samples: 17
        //            color: "#80000000"
        //            source: fab
        //        }
    }

    RowLayout{
        anchors.fill: parent
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        Repeater{

            id:repeater
            Component.onCompleted: fab.centerX = repeater.itemAt(currentIndex).x + repeater.itemAt(currentIndex).width / 2

            model:[ "\uf007" , "\uf0e0" , "\uf015" , "\uf075" , "\uf080"]
            delegate:     Button{

                id:button

                property real iconSize: 40
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                contentItem: Text
                {
                    text: modelData
                    font.family: fontLoader.name
                    font.pixelSize: iconSize
                    font.styleName: "Solid"
                    property real verticalOffcet: currentIndex === index ? -17 :0
                    anchors.verticalCenter:parent.verticalCenter
                    anchors.verticalCenterOffset: verticalOffcet
                    width: iconSize
                    height: iconSize
                    anchors.centerIn: parent
                    color: Constant.lightTextColor
                    antialiasing:true

                    Behavior on verticalOffcet {
                        SequentialAnimation {
                            PropertyAnimation {
                                easing.type: Easing.OutQuad
                                duration: 500
                            }
                        }
                    }

					layer.enabled: true
					layer.effect: DropShadow {
						transparentBorder: true
						horizontalOffset: 0
						verticalOffset: 0
						color: currentIndex === index ? Constant.gold : Constant.shadowColor
						samples: 8
						radius: 8
						spread: 0.0
					}
                }
                background: Rectangle{
                    color:"transparent"
                }

                onClicked: {
                    if(currentIndex !== index)
                    {
                        fab.centerX = x + width / 2
                        currentIndex = index
                    }

                }
            }
        }
    }

}
