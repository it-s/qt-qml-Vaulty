#ifndef DATAMANAGER_H
#define DATAMANAGER_H
#include <QJsonObject>

class DataManager
{
public:

    enum FileFormat {
        Json, Binary
    };

    static QString configFileName();

    static QJsonObject loadConfig();
    static bool saveConfig(QJsonObject &data);

    static QJsonObject loadJSON(QString &store);
    static bool saveJSON(QString &store, QJsonObject &data);

//    static QJsonObject loadData(QString &store);
//    static bool saveData(QString &store, QJsonObject &data);
private:

    static QJsonObject mLoad(FileFormat format, QString store);
    static bool mSave(FileFormat format, QString store, QJsonObject &data);

};

#endif // DATAMANAGER_H
