#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "src/components/notchedrectangle.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
	QGuiApplication app(argc, argv);

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

	engine.load(url);

	return app.exec();
}
