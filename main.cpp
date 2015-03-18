#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QJsonDocument>

#include "datamanager.h"

int main(int argc, char *argv[])
{
    QString json = "{'test':true}";
    QJsonDocument conf = QJsonDocument::fromJson(json.toUtf8());
    QJsonObject obj = conf.object();
    QString file = "data.json";
    DataManager::saveJSON(file, obj);

//    QGuiApplication app(argc, argv);

//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    return app.exec();
}
