#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>

#include "Units.h"

#include "vaults.h"
#include "storefilter.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Likalo.com");
    app.setOrganizationDomain("Likalo.com");
    app.setApplicationName("Vaulty");

#if defined(Q_OS_WIN)
    QSettings settings;
    settings.setDefaultFormat(QSettings::IniFormat);
#endif

    Vaults vaults;
    StoreFilter store;

    QQmlApplicationEngine engine;
#if (defined(Q_OS_ANDROID) || defined(Q_OS_IOS) || defined(Q_OS_WINPHONE))
    engine.rootContext()->setContextProperty("U", new Units(qApp->screens().first()->size(), QSize(320,480)));
#else
    engine.rootContext()->setContextProperty("U", new Units());
#endif
    engine.rootContext()->setContextProperty("vaults", &vaults);
    engine.rootContext()->setContextProperty("store", &store);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
