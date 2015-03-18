#include <QIODevice>
#include <QStandardPaths>
#include <QFile>
#include <QByteArray>
#include <QJsonDocument>

#include "datamanager.h"

QString DataManager::configFileName()
{
    return QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/config.json";
}

QJsonObject DataManager::loadConfig()
{
    return mLoad(DataManager::Json, configFileName() );
}

bool DataManager::saveConfig(QJsonObject &data)
{
    return mSave(DataManager::Json, configFileName(), data);
}

QJsonObject DataManager::loadJSON(QString &store)
{
    return mLoad(DataManager::Json, QStandardPaths::writableLocation(QStandardPaths::DataLocation) + "/" + store);
}

bool DataManager::saveJSON(QString &store, QJsonObject &data)
{
    return mSave(DataManager::Json, QStandardPaths::writableLocation(QStandardPaths::DataLocation) + "/" + store, data);
}

QJsonObject DataManager::mLoad(FileFormat format, QString store)
{
    QFile file(store);
    qDebug("Loading from:");
    qDebug(store.toUtf8());
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open save file.");
        return QJsonObject();
    }
    QByteArray data = file.readAll();
    QJsonDocument JSON(QJsonDocument::fromJson(data));
    return JSON.object();
}

bool DataManager::mSave(FileFormat format, QString store, QJsonObject &data)
{
    QFile file(store);
    qDebug("Saving to:");
    qDebug(store.toUtf8());
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonDocument JSON(data);
    file.write(JSON.toJson());
    return true;
}


