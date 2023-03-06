#ifndef GAMEMANAGER_H
#define GAMEMANAGER_H

#include <QObject>

#include "src/StoryMode/BookItem.h"
#include "src/StoryMode/BookModel.h"
#include "src/StoryMode/ChapterModel.h"

class GameManager : public QObject
{
	Q_OBJECT
public:
	explicit GameManager(QObject *parent = nullptr);

	QVector<BookItem> books() const;

	BookModel &booksModel();

signals:

private:
	QVector<BookItem> createDummyBooks();

	QVector<StringQuestion> createDummyQuestions();

	QVector<ChapterItem> createDummyChapters();

private:
	QVector<BookItem> m_books;

	BookModel m_booksModel;
	ChapterModel m_chapterModel;
};

#endif // GAMEMANAGER_H
