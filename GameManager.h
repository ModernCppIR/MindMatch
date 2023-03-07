#ifndef GAMEMANAGER_H
#define GAMEMANAGER_H

#include <QObject>

#include "src/StoryMode/BookItem.h"
#include "src/StoryMode/BookModel.h"
#include "src/StoryMode/ChapterModel.h"
#include "src/StoryMode/StoryGameSession.h"

class GameManager : public QObject
{
	Q_OBJECT
public:
	explicit GameManager(QObject *parent = nullptr);

	QVector<BookItem> books() const;

	BookModel &booksModel();

	ChapterModel &chapterModel();

	StoryGameSession &storyGameSession();

signals:

private:
	QVector<BookItem> createDummyBooks();

	QVector<StringQuestion> createDummyQuestions();

	QVector<ChapterItem> createDummyChapters();

public slots:

	void selectBook(const QString &bookName);
	void selectChapter(const int &index);

private:
	QVector<BookItem> m_books;
	BookModel m_booksModel;
	QString currentBookName;

	ChapterModel m_chapterModel;

	StoryGameSession m_storyGameSession;
};

#endif // GAMEMANAGER_H
