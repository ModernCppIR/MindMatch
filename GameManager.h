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

	Q_PROPERTY(bool currentBookIsLast READ currentBookIsLast WRITE setCurrentBookIsLast NOTIFY
				   currentBookIsLastChanged)

	Q_PROPERTY(int allAchievedStoryModeStars READ allAchievedStoryModeStars WRITE
				   setAllAchievedStoryModeStars NOTIFY allAchievedStoryModeStarsChanged)
	Q_PROPERTY(int totalStoryModeStars READ totalStoryModeStars WRITE setTotalStoryModeStars NOTIFY
				   totalStoryModeStarsChanged)

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

	bool currentBookIsLast() const;
	void setCurrentBookIsLast(bool newCurrentBookIsLast);

	int allAchievedStoryModeStars() const;
	void setAllAchievedStoryModeStars(int newAllAchievedStoryModeStars);

	int totalStoryModeStars() const;
	void setTotalStoryModeStars(int newTotalStoryModeStars);

signals:

	void currentBookNameChanged();

	void currentChapterChanged();

	void finishedAllBooks();

	void currentBookIsLastChanged();

	void allAchievedStoryModeStarsChanged();

	void totalStoryModeStarsChanged();

	void showBanner(const QString &fileSource);

private:
	QVector<BookItem> createDummyBooks();

	QVector<StringQuestion> createDummyQuestions();

	QVector<ChapterItem> createDummyChapters();

public slots:

	void selectBook(const QString &bookName);
	void selectChapter(const int &index);
	void goToNextChapter();
	void gotoNextBook();

	bool checkIfAllTheStarsAchieved();

private:
	QVector<BookItem> m_books;
	BookModel m_booksModel;

	ChapterModel m_chapterModel;

	StoryGameSession m_storyGameSession;

	int m_currentChapter;
	QString m_currentBookName;

	const int m_bookTotalChapters;
	bool m_currentBookIsLast = false;
	int m_allAchievedStoryModeStars = 0;
	;
	int m_totalStoryModeStars = 0;
};

#endif // GAMEMANAGER_H
