#include "BookModel.h"

BookModel::BookModel(QVector<BookItem> &books, QObject *parent)
	: QAbstractListModel{parent}
	, m_books{books}
{
}

int BookModel::rowCount(const QModelIndex &parent) const
{
	return m_books.size();
}

QVariant BookModel::data(const QModelIndex &index, int role) const
{
	QVariant retValue;

	switch (role)
	{
	case Name:
		retValue = m_books[index.row()].name;
		break;
	case BookStars:
		retValue = m_books[index.row()].stars;

		break;
	case BookScore:
		retValue = m_books[index.row()].score;

		break;
	case OperationList:
		retValue = m_books[index.row()].operationList;

		break;
	default:
		break;
	}

	return retValue;
}

QHash<int, QByteArray> BookModel::roleNames() const
{
	QHash<int, QByteArray> myRoleNames;
	myRoleNames[Name] = "name";
	myRoleNames[BookStars] = "stars";
	myRoleNames[BookScore] = "score";
	myRoleNames[OperationList] = "operationList";

	return myRoleNames;
}
