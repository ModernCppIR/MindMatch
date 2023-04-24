#include "GameManager.h"

#include "DatabaseManager.h"
#include <QDebug>

GameManager::GameManager(QObject *parent)
	: QObject{parent}
	, m_bookTotalChapters{9}
{

	if (!m_dbManager->open())
	{
		// TODO add a message dialog in ui to inform user and exit
		qDebug() << "can not open databse so nothing to be done ";
		exit(1);
	}

	//	m_dbManager->init();
	//	m_dbManager->generateQuestions();

	m_books = createDummyBooks();

	m_totalStoryModeStars = m_books.size() * 9 * 3;

	m_booksModel.setBooks(m_books);
}

GameManager::~GameManager() = default;

QVector<BookItem> GameManager::createDummyBooks()
{
	QVector<BookItem> ret;

	BookItem plusBook;
	plusBook.name = "جمع";
	plusBook.operationList = QStringList{QString{"\uf067"}};
	plusBook.achievedStars = 25;
	plusBook.chapters = createDummyChapters();

	plusBook.score = 123569;
	plusBook.totalStars = 27;

	ret.push_back(plusBook);

	BookItem minusBook;
	minusBook.name = "تفریق";
	minusBook.operationList = QStringList{QString{"\uf068"}};
	minusBook.achievedStars = 27;
	minusBook.totalStars = 27;
	minusBook.score = 67291;
	minusBook.chapters = createDummyChapters();

	ret.push_back(minusBook);

	BookItem multiplyBook;
	multiplyBook.name = "ضرب";
	multiplyBook.operationList = QStringList{QString{"\uf00d"}};
	multiplyBook.achievedStars = 5;
	multiplyBook.totalStars = 27;
	multiplyBook.score = 93625;
	multiplyBook.chapters = createDummyChapters();

	ret.push_back(multiplyBook);

	BookItem devideBook;
	devideBook.name = "تقسیم";
	devideBook.operationList = QStringList{QString{"\uf529"}};
	devideBook.achievedStars = 0;
	devideBook.totalStars = 27;
	devideBook.score = 0;
	devideBook.chapters = createDummyChapters();

	ret.push_back(devideBook);

	return ret;
}

QVector<StringQuestion> GameManager::createDummyQuestions()
{
	QVector<StringQuestion> retValue;

	for (int i = 0; i < 3; ++i)
	{
		StringQuestion q;

		q.title = "2 + 3 = ?";

		for (int i = 0; i < 4; ++i)
		{
			StringAnswer a;
			a.context = QString::number(i + 5);
			a.isCorrect = i == 0;
			q.answers[i] = a;
		}

		retValue.push_back(q);
	}
	return retValue;
}

QVector<ChapterItem> GameManager::createDummyChapters()
{
	QVector<ChapterItem> ret;

	for (int i = 0; i < 9; ++i)
	{
		ChapterItem ci;

		ci.name = "فصل " + QString::number(i + 1);
		ci.score = (i + 1) * 27003;
		ci.stars = ((i + 1) % 3);

		ci.questions = createDummyQuestions();

		ci.totalTime = ci.questions.size() * 5 * 1000;

		ret.push_back(ci);
	}

	return ret;
}

void GameManager::selectBook(const QString &bookName)
{
	auto bookIt = std::find_if(m_books.cbegin(), m_books.cend(),
							   [bookName](const BookItem &book) { return book.name == bookName; });

	if (bookIt != m_books.cend())
	{
		setCurrentBookName(bookName);
		m_chapterModel.setChapters(bookIt->chapters);
	}
	else
	{
		// NOTE use error handler to show error message in android ui
		throw std::runtime_error("book dose not exists!");
	}
}

void GameManager::selectChapter(const int &index)
{
	auto bookIt = std::find_if(m_books.cbegin(), m_books.cend(),
							   [this](const BookItem &book)
							   { return book.name == currentBookName(); });

	if (bookIt != m_books.cend())
	{
		QString operatorStr = bookIt->operationList.join("");
		qDebug() << operatorStr;
		int hardnessLevel = index + 1;
		auto chapter = m_dbManager->getChapter(operatorStr, hardnessLevel);
		auto questions = chapter.questions;
		m_storyGameSession.setQuestions(questions);
		m_storyGameSession.setSessionName(bookIt->chapters[index].name);

		setCurrentChapter(index);
	}
	else
	{
		// NOTE use error handler to show error message in android ui
		throw std::runtime_error("book dose not exists!");
	}
}

void GameManager::goToNextChapter()
{
	if (m_bookTotalChapters > currentChapter() + 1)
	{
		selectChapter(currentChapter() + 1);
	}
	else
	{
		gotoNextBook();
	}
}

void GameManager::gotoNextBook()
{
	selectBook(currentBookName());

	auto bookIt = std::find_if(m_books.cbegin(), m_books.cend(),
							   [this](const BookItem &book)
							   { return book.name == m_currentBookName; });

	if (bookIt != m_books.cend())
	{
		bookIt++;
		if (bookIt != m_books.cend())
		{
			setCurrentBookName(bookIt->name);
			m_chapterModel.setChapters(bookIt->chapters);
			selectChapter(0);
		}
		else
		{
			emit finishedAllBooks();
			qDebug() << "books are done!";
		}
	}
	else
	{
		// NOTE use error handler to show error message in android ui
		throw std::runtime_error("book dose not exists!");
	}
}

bool GameManager::checkIfAllTheStarsAchieved()
{
	return totalStoryModeStars() == allAchievedStoryModeStars();
}

int GameManager::currentChapter() const
{
	return m_currentChapter;
}

void GameManager::setCurrentChapter(int newCurrentChapter)
{
	m_currentChapter = newCurrentChapter;

	if (m_currentChapter == newCurrentChapter)
		return;
	m_currentChapter = newCurrentChapter;
	emit currentChapterChanged();
}

StoryGameSession &GameManager::storyGameSession()
{
	return m_storyGameSession;
}

ChapterModel &GameManager::chapterModel()
{
	return m_chapterModel;
}

BookModel &GameManager::booksModel()
{
	return m_booksModel;
}

QVector<BookItem> GameManager::books() const
{
	return m_books;
}

QString GameManager::currentBookName() const
{
	return m_currentBookName;
}

void GameManager::setCurrentBookName(const QString &newCurrentBookName)
{
	if (m_currentBookName == newCurrentBookName)
		return;
	m_currentBookName = newCurrentBookName;
	emit currentBookNameChanged();
}

bool GameManager::currentBookIsLast() const
{
	return m_currentBookIsLast;
}

void GameManager::setCurrentBookIsLast(bool newCurrentBookIsLast)
{
	if (m_currentBookIsLast == newCurrentBookIsLast)
		return;
	m_currentBookIsLast = newCurrentBookIsLast;
	emit currentBookIsLastChanged();
}

int GameManager::allAchievedStoryModeStars() const
{
	return m_allAchievedStoryModeStars;
}

void GameManager::setAllAchievedStoryModeStars(int newAllAchievedStoryModeStars)
{
	if (m_allAchievedStoryModeStars == newAllAchievedStoryModeStars)
		return;
	m_allAchievedStoryModeStars = newAllAchievedStoryModeStars;
	emit allAchievedStoryModeStarsChanged();
}

int GameManager::totalStoryModeStars() const
{
	return m_totalStoryModeStars;
}

void GameManager::setTotalStoryModeStars(int newTotalStoryModeStars)
{
	if (m_totalStoryModeStars == newTotalStoryModeStars)
		return;
	m_totalStoryModeStars = newTotalStoryModeStars;
	emit totalStoryModeStarsChanged();
}
