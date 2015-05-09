#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>

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
    engine.rootContext()->setContextProperty("vaults", &vaults);
    engine.rootContext()->setContextProperty("store", &store);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
