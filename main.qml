import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import Qt.labs.lottieqt 1.0

import './qml/components'

ApplicationWindow
{
    id:mainWindow
    //    flags: Qt.FramelessWindowHint

    visible: true
    height: 900
    width: 420
    color: "white"

    FontLoader {
        id: fontLoader
        source: "qrc:/fonts/otfs/Font Awesome 6 Free-Solid-900.otf"

    }


    header: ToolBar {

        Button{
            anchors.fill: parent
            text:"Menu"
            font.bold:true

            onClicked: drawer.open()

            background:Rectangle
            {
                id: headerBackgroundRect
                anchors.fill : parent
                RadialGradient  {
                    anchors.fill:headerBackgroundRect
                    source: headerBackgroundRect
                    angle: 45
                    verticalRadius: 300
                    horizontalRadius: 300
                    horizontalOffset:-headerBackgroundRect.width/2
                    verticalOffset: -headerBackgroundRect.height/2
                    gradient: Gradient {
                        GradientStop { position: 0; color: Constant.lightblue}
                        GradientStop { position: 1; color: Constant.darkblue }
                    }
                }
            }
        }

    }

    footer: BottomNavigationBar{
        id: navigationBar
        height: mainWindow.height / 10

        onCurrentIndexChanged: {
            //            stackView.replace(getPage(currentIndex))
            stackView.push("qml/pages/BookChapters.qml")
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: BookList {}
    }





}
