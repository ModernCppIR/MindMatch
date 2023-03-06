#ifndef BOOKMODEL_H
#define BOOKMODEL_H

#include <QAbstractListModel>
#include <QObject>

#include "BookItem.h"

class BookModel : public QAbstractListModel
{
	Q_OBJECT
public:
	explicit BookModel(QObject *parent = nullptr);

	enum BookRolesEnum
	{
		Name = Qt::UserRole + 1,
		AchievedStars,
		TotalStars,
		BookScore,
		OperationList,
	};

	// QAbstractItemModel interface
public:
	int rowCount(const QModelIndex &parent) const override;
	QVariant data(const QModelIndex &index, int role) const override;
	QHash<int, QByteArray> roleNames() const override;

	void setBooks(const QVector<BookItem> &newBooks);

private:
	QVector<BookItem> m_books;
};

#endif // BOOKMODEL_H
