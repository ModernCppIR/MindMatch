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

    ListView
    {
        id:bookList
        anchors.fill: parent
        Component.onCompleted: bookList.model = booksModel

        spacing: 20



        delegate: BookCover{
            width : parent? parent.width - 40 : 0
            anchors.left: parent ? parent.left : undefined
            anchors.leftMargin: 20

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
