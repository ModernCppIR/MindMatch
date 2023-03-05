import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
import QtGraphicalEffects 1.12

import './qml/components'
import './qml/pages'
import './qml/pages/Story'

ApplicationWindow
{
	id:mainWindow
	//    flags: Qt.FramelessWindowHint
	title:"مسابقه ذهن"
	visible: true
	height: 900
	width: 420
	color: Constant.whiteColor

	FontLoader {
		id: fontLoader
		source: "qrc:/fonts/otfs/Font Awesome 6 Free-Solid-900.otf"
	}

	header: ToolBar {

		id: mainMenuBar

		Button{
			anchors.fill: parent
			text:"منوی بالا"
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
					gradient: Constant.blueGradient
				}
			}
		}
	}

	footer: BottomNavigationBar{
		id: navigationBar
		height: mainWindow.height / 10

		onCurrentIndexChanged: {
			//            stackView.replace(getPage(currentIndex))
			//            stackView.push("qml/pages/BookChapters.qml")
			//            stackView.push("qml/pages/QuestionPage.qml")
		}
	}

		StackView {
			id: stackView
			anchors.fill: parent
			initialItem: BookList{


			}
	//				initialItem: CountdownPage {

	//					onDone:
	//					{
	//						console.log("ountdown done");
	//						stackView.push("qrc:/qml/pages/QuestionPage.qml")
	//					}
	//				}
		}
}
