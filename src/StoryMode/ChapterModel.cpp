#include "ChapterModel.h"

ChapterModel::ChapterModel(QObject *parent)
	: QAbstractListModel{parent}
	, m_roleVector{Name, Stars, Score, TotalTime}
{
}

int ChapterModel::rowCount(const QModelIndex &parent) const
{
	return m_chapters.size();
}

QVariant ChapterModel::data(const QModelIndex &index, int role) const
{
	QVariant returnValue;
	switch (role)
	{
	case Name:
		returnValue = m_chapters[index.row()].name;
		break;
	case Stars:

		returnValue = m_chapters[index.row()].stars;
		break;
	case Score:

		returnValue = m_chapters[index.row()].score;
		break;
	case TotalTime:

		returnValue = m_chapters[index.row()].name;
		break;
	default:
		break;
	}

	return returnValue;
}

QHash<int, QByteArray> ChapterModel::roleNames() const
{
	QHash<int, QByteArray> ret;

	ret[Name] = "name";
	ret[Stars] = "stars";
	ret[Score] = "score";
	ret[TotalTime] = "totaltime";

	return ret;
}

void ChapterModel::setChapters(const QVector<ChapterItem> &newChapters)
{
	m_chapters = newChapters;
	emit dataChanged(createIndex(0, 0), createIndex(newChapters.size(), 0), m_roleVector);
}
