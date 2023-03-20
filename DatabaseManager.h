#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>

#include "src/StoryMode/ChapterItem.h"

class DatabaseManager : public QObject
{
	Q_OBJECT
public:
	explicit DatabaseManager(QObject *parent = nullptr);

	bool open();

	bool init();

	QVector<ChapterItem> getChapter(const QString &operators, int hardnessLevel);

	void generateQuestions();

signals:
};

#endif // DATABASEMANAGER_H
