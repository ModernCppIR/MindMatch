import QtQuick 2.15

import Constant 1.0

Item
{
	id:root

	signal done()

	Component.onCompleted:
	{
		mainWindow.hideMenus();
	}

	AnimatedImage
	{
		id: animation;
		anchors.centerIn: parent

		source: "qrc:/gif/countdown.gif"

		onCurrentFrameChanged: {
			if(currentFrame == 52 )
			{
				animation.paused = true;
				animation.currentFrame = 0;
				done();
			}
		}
	}
}
