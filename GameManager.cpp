#include "GameManager.h"

GameManager::GameManager(QObject *parent)
	: QObject{parent}
{
	m_books = createDummyBooks();

	m_booksModel.setBooks(m_books);
}

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

	for (int i = 0; i < 16; ++i)
	{
		StringQuestion q;

		q.title = "A + B = ?";

		for (int i = 0; i < 4; ++i)
		{
			StringAnswer a;
			a.context = "";
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

		ci.name = "فصل" + QString::number(i + 1);
		ci.score = (i + 1) * 27003;
		ci.stars = ((i + 1) % 3);

		ci.questions = createDummyQuestions();

		ci.totalTime = ci.questions.size() * 5 * 1000;

		ret.push_back(ci);
	}

	return ret;
}

BookModel &GameManager::booksModel()
{
	return m_booksModel;
}

QVector<BookItem> GameManager::books() const
{
	return m_books;
}
