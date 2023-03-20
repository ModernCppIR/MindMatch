#include <QFontDatabase>
#include <QGuiApplication>
#include <QLoggingCategory>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlPropertyMap>
#include <QTimer>

#include "DatabaseManager.h"
#include "GameManager.h"
#include "src/components/notchedrectangle.h"

#include <QtPlugin>
#include <QtSql>

int main(int argc, char *argv[])
{
	//	Q_IMPORT_PLUGIN(QSvgIconPlugin);
	//	Q_IMPORT_PLUGIN(QSvgPlugin);

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
	QGuiApplication app(argc, argv);

	app.setOrganizationName("ModernCpp");
	app.setOrganizationDomain("ModernCpp.ir");
	app.setApplicationName("Mr Math");

	if (-1 == QFontDatabase::addApplicationFont(":/fonts/ttf/Vazirmatn-VariableFont_wght.ttf"))
	{
		qCritical() << "couldn't add application font";
	}

	QFont vazirmatnFont;
	vazirmatnFont.setFamily("Vazirmatn");
	app.setFont(vazirmatnFont);

	// NOTE dtabase

	//	QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
	//	qDebug() << db.drivers();
	//	//	db.setDatabaseName(":memory:");
	//	db.setDatabaseName("sss");
	//	if (!db.open())
	//	{
	//		//		QMessageBox::critical(nullptr, QObject::tr("Cannot open database"),
	//		//							  QObject::tr("Unable to establish a database connection.\n"
	//		//										  "This example needs SQLite support. Please read "
	//		//										  "the Qt SQL driver documentation for information how "
	//		//										  "to build it.\n\n"
	//		//										  "Click Cancel to exit."), QMessageBox::Cancel);
	//		//		return false;
	//		qDebug() << "Cannot open database\n"
	//					"Unable to establish a database connection.\n"
	//					"This example needs SQLite support. Please read "
	//					"the Qt SQL driver documentation for information how "
	//					"to build it.\n\n"
	//					"Click Cancel to exit.";
	//	}

	DatabaseManager dbManager;

	if (!dbManager.open())
	{
		// TODO add a message dialog in ui to inform user and exit
		qDebug() << "can not open databse so nothing to be done ";
		exit(1);
	}

	dbManager.init();
	dbManager.generateQuestions();

	//	dbManager.getChapter("+", 1);

	// NOTE create models
	GameManager gm;

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

	engine.rootContext()->setContextProperty("storyGameSession", &gm.storyGameSession());
	engine.rootContext()->setContextProperty("booksModel", &gm.booksModel());
	engine.rootContext()->setContextProperty("chaptersModel", &gm.chapterModel());
	engine.rootContext()->setContextProperty("gameManager", &gm);

	//#ifdef QT_NO_DEBUG
	//	QLoggingCategory::setFilterRules("*.debug=false\n"
	//									 "*.info=false\n"
	//									 "*.warning=true\n"
	//									 "*.critical=true");
	//	fprintf(stderr, "Disabling QML logging in release build.\n");
	//#else
	//	fprintf(stderr, "QML logging enabled.\n");
	//#endif

	engine.load(url);

	return app.exec();
}
