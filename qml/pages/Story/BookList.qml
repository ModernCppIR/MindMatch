import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
import QtGraphicalEffects 1.15

import Constant 1.0

import "../../components"
Page {
id:root
	Component.onCompleted: mainWindow.showMenus()

    Rectangle
    {
        id:backRect
        anchors.fill: parent
        color: Constant.whiteColor
    }

    ListView
    {
		id:bookList

		anchors.fill: parent
		Component.onCompleted: bookList.model = booksModel

		spacing: 20



		delegate: BookCover
		{
			width : root.width - 40
			height: (root.height/5) * 3

			anchors.left: parent ? parent.left : undefined
			anchors.leftMargin: 20
			logoSize:root.width/8

			onSelected:
			{
				gameManager.selectBook(name);
				stackView.push(chaptersListComponent)
			}

        }

		header: Rectangle{
			height: 50
			anchors.left: parent.left
			anchors.right: parent.right
			color:"transparent"
		}
		footer: Rectangle{
			height: 50
			anchors.left: parent.left
			anchors.right: parent.right
			color:"transparent"
		}
    }


}
