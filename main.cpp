#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlPropertyMap>
#include <QTimer>

#include "src/StoryMode/BookItem.h"
#include "src/StoryMode/BookModel.h"
#include "src/StoryMode/StoryGameSession.h"
#include "src/components/notchedrectangle.h"

QVector<StringQuestion> createDummyQuestions()
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

QVector<ChapterItem> createDummyChapters()
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

QVector<BookItem> createDummyBooks()
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

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
	QGuiApplication app(argc, argv);

	if (-1 == QFontDatabase::addApplicationFont(":/fonts/ttf/Vazirmatn-VariableFont_wght.ttf"))
	{
		qCritical() << "couldn't add application font";
	}

	QFont nokiaFont;
	nokiaFont.setFamily("Vazirmatn");
	app.setFont(nokiaFont);

	// NOTE create models
	StoryGameSession sgs;
	auto books = createDummyBooks();

	BookModel booksModel(books);

	QQmlApplicationEngine engine;
	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(
		&engine, &QQmlApplicationEngine::objectCreated, &app,
		[url](QObject *obj, const QUrl &objUrl)
		{
			if (!obj && url == objUrl)
				QCoreApplication::exit(-1);
		},
		Qt::QueuedConnection);

	qmlRegisterSingletonType(QUrl("qrc:/Constant.qml"), "Constant", 1, 0, "Constant");

	qmlRegisterType<NotchedRectangle>("Notched", 1, 0, "NotchedRectangle");

	engine.rootContext()->setContextProperty("storyGameSession", &sgs);
	engine.rootContext()->setContextProperty("booksModel", &booksModel);

	engine.load(url);

	return app.exec();
}
