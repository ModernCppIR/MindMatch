#ifndef CHAPTERITEM_H
#define CHAPTERITEM_H

#include <QString>
#include <QVector>

#include "StringQuestion.h"

struct ChapterItem
{
	QString name;
	int score;
	int stars;
	int totalTime;

	QVector<StringQuestion> questions;
};

#endif // CHAPTERITEM_H
