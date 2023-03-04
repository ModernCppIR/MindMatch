#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlPropertyMap>
#include <QTimer>

#include "StoryGameSession.h"
#include "src/components/notchedrectangle.h"

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

	StoryGameSession sgs;

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

	QQmlPropertyMap ownerData;
	ownerData.insert("name", QVariant(QString("John Smith")));
	ownerData.insert("phone", QVariant(QString("555-5555")));

	engine.rootContext()->setContextProperty("storyGameSession", &sgs);

	engine.load(url);

	return app.exec();
}
