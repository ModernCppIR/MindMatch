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


//        RadialGradient  {
//            anchors.fill:backRect
//            source: backRect
//            angle: 45
//            verticalRadius: 300
//            horizontalRadius: 300
//            horizontalOffset:-backRect.width/2
//            verticalOffset: -backRect.height/2
//            gradient: Constant.blueGradient
//        }
    }

//    ListModel{
//        id:booksModel
//        ListElement{
//            bookName:"جمع"
//            achievedStars:25
//            achievedScore:123569
//			operationString: "\uf067"

//        }
//        ListElement{
//            bookName:"تفریق"
//            achievedStars:27
//            achievedScore:67291
//			operationString: "\uf068"

//        }
//        ListElement{
//            bookName:"ضرب"
//            achievedStars:5
//            achievedScore:93625
//			operationString: "\uf00d"
//        }
//		ListElement{
//			bookName:"تقسیم"
//			achievedStars:0
//			achievedScore:0
//			operationString: "\uf529"
//		}


//    }

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
