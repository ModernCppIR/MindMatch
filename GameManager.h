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

	Q_PROPERTY(QString currentBookName READ currentBookName WRITE setCurrentBookName NOTIFY
				   currentBookNameChanged)

	Q_PROPERTY(
		int currentChapter READ currentChapter WRITE setCurrentChapter NOTIFY currentChapterChanged)

public:
	explicit GameManager(QObject *parent = nullptr);

	QVector<BookItem> books() const;

	BookModel &booksModel();

	ChapterModel &chapterModel();

	StoryGameSession &storyGameSession();

	int currentChapter() const;
	void setCurrentChapter(int newCurrentChapter);

	QString currentBookName() const;
	void setCurrentBookName(const QString &newCurrentBookName);

signals:

	void currentBookNameChanged();

	void currentChapterChanged();

	void finishedAllBooks();

private:
	QVector<BookItem> createDummyBooks();

	QVector<StringQuestion> createDummyQuestions();

	QVector<ChapterItem> createDummyChapters();

public slots:

	void selectBook(const QString &bookName);
	void selectChapter(const int &index);
	void goToNextChapter();
	void gotoNextBook();

private:
	QVector<BookItem> m_books;
	BookModel m_booksModel;

	ChapterModel m_chapterModel;

	StoryGameSession m_storyGameSession;

	int m_currentChapter;
	QString m_currentBookName;

	const int m_bookTotalChapters;
};

#endif // GAMEMANAGER_H
