#ifndef BOOKITEM_H
#define BOOKITEM_H

#include <QString>
#include <QStringList>
#include <QVector>

#include "ChapterItem.h"

struct BookItem
{
	QString name;
	int totalStars;
	int achievedStars;
	int score;
	QStringList operationList;

	QVector<ChapterItem> chapters;
};

#endif // BOOKITEM_H
