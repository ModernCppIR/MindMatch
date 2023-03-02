import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

Page {

    Rectangle
    {
        id:backRect
        anchors.fill: parent
        color:"#f0f9fd"
        radius: 20
//                LinearGradient {
//                    anchors.fill: backRect
//                    source: backRect
//                    start: Qt.point(0, backRect.height/2)
//                    end: Qt.point(backRect.width, backRect.height/2)
//                    gradient: Gradient {
//                        GradientStop { position: 0; color: lightblue }
//                        GradientStop { position: 0.5; color: "#5ae9f9" }
//                        GradientStop { position: 1; color: darkblue }
//                    }
//                }
    }

    ListModel{
        id:booksModel
        ListElement{
            bookName:"جمع"
            achievedStars:25
            achievedScore:123569
            operationString:"+"

        }
        ListElement{
            bookName:"تفریق"
            achievedStars:27
            achievedScore:67291
            operationString:"-"

        }
        ListElement{
            bookName:"ضرب"
            achievedStars:5
            achievedScore:93625
            operationString:"x"
        }


    }

//    property var mm :  [
//        {
//            name:"جمع",
//            achievedStars:27,
//            achievedScore:1235069,
//            operationString:"+"

//        },
//        {
//            name:"تفریق",
//            achievedStars:3,
//            achievedScore:67291,
//            operationString:"-"

//        },
//        {
//            name:"ضرب",
//            achievedStars:5,
//            achievedScore:93625,
//            operationString:"x"

//        }
//    ]

    ListView
    {
        id:bookList
        anchors.fill: parent
//        model:booksModel
//        Component.onCompleted: bookList.model = mm
        Component.onCompleted: bookList.model = booksModel

        spacing: 20



        delegate: BookCover{
            width : parent? parent.width - 40 : 0
                anchors.left: parent ? parent.left : undefined
                anchors.leftMargin: 20

//            bookName: name
//            score: achievedScore
//            achievedStars: achievedStars
//            operation: operationString

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
