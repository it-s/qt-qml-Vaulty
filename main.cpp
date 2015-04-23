#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "vaults.h"
#include "store.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Likalo.com");
    app.setOrganizationDomain("Likalo.com");
    app.setApplicationName("Vaulty");

    Vaults vaults;
    Store store;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("vaults", &vaults);
    engine.rootContext()->setContextProperty("store", &store);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
