import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15

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

	function showBanner(fileSource)
	{
		bannerLoader.sourceComponent = fileSource;
		bannerpopup.open();
	}

	//    flags: Qt.FramelessWindowHint
	title:"آقای ریاضی"
	visible: true
	width: 420
	height: 900

	color: Constant.whiteColor

	FontLoader
	{
		id: fontLoader
		source: "qrc:/fonts/otfs/Font Awesome 6 Free-Solid-900.otf"
	}

	header: ToolBar
	{
		id: mainMenuBar
//		visible: menuVisible

		Button
		{
			anchors.fill: parent
			text:"منوی بالا"
			font.bold:true

			contentItem: Text
			{
				anchors.centerIn: parent
				text: parent.text
				color: Constant.whiteColor
				font.bold: true
				font.pixelSize: parent.font.pixelSize
				font.letterSpacing: parent.font.letterSpacing

				horizontalAlignment: Qt.AlignHCenter
				verticalAlignment: Qt.AlignVCenter
			}

			background: Rectangle
			{
				id: headerBackgroundRect
				anchors.fill : parent
				RadialGradient
				{
					anchors.fill:headerBackgroundRect
					source: headerBackgroundRect
					angle: 45
					verticalRadius: 300
					horizontalRadius: 300
					horizontalOffset:-headerBackgroundRect.width/2
					verticalOffset: -headerBackgroundRect.height/2
					gradient: Constant.blueGradient
				}

				layer.enabled: true
				layer.effect: DropShadow
				{
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
	}

	footer: BottomNavigationBar
	{
		id: navigationBar
		visible: menuVisible

		height: mainWindow.height / 10

		onCurrentIndexChanged:
		{
			//            stackView.replace(getPage(currentIndex))
			//            stackView.push("qml/pages/BookChapters.qml")
			//            stackView.push("qml/pages/QuestionPage.qml")
		}
	}

	StackView
	{
		id: stackView
		anchors.fill: parent
		initialItem: StartCover
		{

		}

		pushEnter: Transition
		{
			PropertyAnimation
			{
				property: "opacity"
				from: 0
				to: 1
				duration: 50
			}

		}

		pushExit: Transition
		{
			PropertyAnimation
			{
				property: "opacity"
				from: 1
				to: 0
				duration: 150
			}
		}

		popEnter: Transition
		{
			PropertyAnimation
			{
				property: "opacity"
				from: 0
				to: 1
				duration: 50
			}

		}

		popExit: Transition
		{
			PropertyAnimation
			{
				property: "opacity"
				from: 1
				to: 0
				duration: 150
			}
		}
	}

	Component
	{
		id: bookListComponent

		BookList
		{

		}
	}

	Component
	{
		id: chaptersListComponent

		BookChapters
		{

		}
	}

	Component
	{
		id: countdownComponent

		CountdownPage
		{

			onDone:
			{
				stackView.replace(questionPageComponent)
				storyGameSession.restartSession()
				storyGameSession.start()
			}
		}
	}

	Component
	{
		id: questionPageComponent

		QuestionPage
		{

		}
	}

	Component
	{
		id: storySuccessPageComponent

		StorySuccessPage
		{

		}
	}

	Component
	{
		id: storyFailurePageComponent

		StoryFailurePage
		{

		}
	}

	Component
	{
		id: leaderboardComponent

		Leaderboard
		{

		}
	}

	Component
	{
		id: settingPageComponent

		SettingPage
		{

		}
	}

	Component
	{
		id: celebrateAllTheStarsAchievedComponent

		CelebrateAllTheStarsAchieved
		{

		}
	}

	// show banner
	Connections
	{
		target : gameManager

		function onShowBanner(fileSource)
		{
			showBanner(fileSource);
		}

	}


	Popup
	{
		id: bannerpopup

		anchors.centerIn: parent
		width: parent.width - 20
		height: parent.height - 20
		modal: true
		closePolicy: Popup.NoAutoClose

		Loader
		{
			id: bannerLoader
			anchors.fill: parent
		}

		background: Rectangle
		{
		color: "transparent"
		}

	}


}
