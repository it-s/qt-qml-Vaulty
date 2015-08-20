#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QQmlContext>
#include <QSettings>
#include <QDebug>

#include "Units.h"

#include "vaults.h"
#include "storefilter.h"
#include "iconprovider.h"
#include "clipboard.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Likalo.com");
    app.setOrganizationDomain("Likalo.com");
    app.setApplicationName("Vaulty");

    QFontDatabase fontdb;
    qDebug() << fontdb.addApplicationFont(":/Common/icons.ttf");



#if defined(Q_OS_WIN)
    QSettings settings;
    settings.setDefaultFormat(QSettings::IniFormat);
#endif

    QQmlApplicationEngine engine;
#if (defined(Q_OS_ANDROID) || defined(Q_OS_IOS) || defined(Q_OS_WINPHONE))
    Units units(qApp->screens().first()->size(), QSize(320,480));
#else
    Units units;
#endif

    Clipboard *clipboard = new Clipboard(QGuiApplication::clipboard());

    engine.rootContext()->setContextProperty(QLatin1String("U"), &units);
    engine.rootContext()->setContextProperty(QLatin1String("clipboard"), clipboard);
    engine.rootContext()->setContextProperty(QLatin1String("vaults"), new Vaults);
    engine.rootContext()->setContextProperty(QLatin1String("store"), new StoreFilter);
//    engine.addImageProvider(QLatin1String("icons"), new IconProvider(units.ratio()));
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
