#ifndef CHAPTERMODEL_H
#define CHAPTERMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <QVector>

#include "ChapterItem.h"

class ChapterModel : public QAbstractListModel
{
	Q_OBJECT
public:
	explicit ChapterModel(QObject *parent = nullptr);

	enum BookRolesEnum
	{
		Name = Qt::UserRole + 1,
		Stars,
		Scores,
		TotalTime
	};

	// QAbstractItemModel interface
public:
	int rowCount(const QModelIndex &parent) const override;
	QVariant data(const QModelIndex &index, int role) const override;
	QHash<int, QByteArray> roleNames() const override;

private:
	QVector<ChapterItem> m_chapters;
};

#endif // CHAPTERMODEL_H
