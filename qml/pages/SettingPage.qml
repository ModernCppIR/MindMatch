import QtQuick 2.15
import QtGraphicalEffects 1.15

import Constant 1.0

Item
{
	id:root

	Rectangle
	{
		id:backRect

		anchors.fill: parent

		LinearGradient
		{
			anchors.fill: backRect
			source: backRect
			start: Qt.point(0, backRect.height/2)
			end: Qt.point(backRect.width, backRect.height/2)
			gradient: Constant.blueGradient
		}
	}
}
