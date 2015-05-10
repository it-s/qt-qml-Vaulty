#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>

#include "vaults.h"
#include "storefilter.h"
#include "iconprovider.h"

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
    engine.rootContext()->setContextProperty(QLatin1String("vaults"), &vaults);
    engine.rootContext()->setContextProperty(QLatin1String("store"), &store);
    engine.addImageProvider(QLatin1String("icons"), new IconProvider);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
