import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.2
import QtGraphicalEffects 1.12

import 'qml/components'
import 'qml/pages'
import 'qml/pages/Story'

ApplicationWindow
{
	id:mainWindow

	property bool menuVisible: false


	function showMenus()
	{
		menuVisible = true;
	}

	function hideMenus()
	{
		menuVisible = false;
	}

	//    flags: Qt.FramelessWindowHint
	title:"مسابقه ذهن"
	visible: true
	width: 420
	height: 900

	color: Constant.whiteColor

	FontLoader {
		id: fontLoader
		source: "qrc:/fonts/otfs/Font Awesome 6 Free-Solid-900.otf"
	}

	header: ToolBar {

		id: mainMenuBar

		visible: menuVisible

		Button{
			anchors.fill: parent
			text:"منوی بالا"
			font.bold:true

			contentItem: Text {
				anchors.centerIn: parent
				text: parent.text
				color: Constant.whiteColor
				font.bold: true
				font.pixelSize: parent.font.pixelSize
				font.letterSpacing: parent.font.letterSpacing

				horizontalAlignment: Qt.AlignHCenter
				verticalAlignment: Qt.AlignVCenter
			}

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
		visible: menuVisible

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
		initialItem: StartCover{

		}


		pushEnter: Transition {
			PropertyAnimation {
						   property: "opacity"
						   from: 0
						   to: 1
						   duration: 50
					   }

		}

		pushExit: Transition {
			PropertyAnimation {
				property: "opacity"
				from: 1
				to: 0
				duration: 150
			}
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
