#include <QDebug>
#include <QUuid>
#include <QSettings>
#include <QFileInfo>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include "store.h"

Store::Store(QObject *parent) :
    QAbstractListModel(parent)
{
    mDataRoles[ID] = "ID";
    mDataRoles[TypeRole] = "type",
    mDataRoles[StyleRole] = "style",
    mDataRoles[TitleRole] = "title",
    mDataRoles[LoginRole] = "login",
    mDataRoles[NumberRole] = "number",
    mDataRoles[PasswordRole] = "password",
    mDataRoles[PinRole] = "pin",
    mDataRoles[RelateRole] = "relate",
    mDataRoles[DescriptionRole] = "description";
    mStoreChanged = false;
    isOpen = false;
}

Store::~Store()
{
    close();
}

int Store::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() || !isOpen? 0: mData.size();
}

QVariant Store::data(const QModelIndex &index, int role) const
{
    QVariant result;
    if (index.isValid() && isOpen) {
        int row = index.row();
        if (row >= 0 && row < mData.size()) {
            const StoreItem &storeItem = mData[row];
            switch(role) {
            case ID:
                result = storeItem.ID;
                break;
            case TypeRole:
                result = storeItem.type;
                break;
            case StyleRole:
                result = storeItem.style;
                break;
            case TitleRole:
                result = storeItem.title;
                break;
            case LoginRole:
                result = storeItem.login;
                break;
            case NumberRole:
                result = storeItem.number;
                break;
            case PasswordRole:
                result = storeItem.password;
                break;
            case PinRole:
                result = storeItem.pin;
                break;
            case RelateRole:
                result = storeItem.relate;
                break;
            case DescriptionRole:
                result = storeItem.description;
                break;
            }
        }
    }
    return result;
}

bool Store::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!isOpen) return false;
    bool result = false;
    if (index.isValid()) {
        int row = index.row();
        if (row >= 0 && row < mData.size()) {
            StoreItem &storeItem = mData[row];
            switch(role) {
            case TypeRole:
                storeItem.type = value.toInt();
                result = true;
                break;
            case StyleRole:
                storeItem.style = value.toInt();
                result = true;
                break;
            case TitleRole:
                storeItem.title = value.toString();
                result = true;
                break;
            case LoginRole:
                storeItem.login = value.toString();
                result = true;
                break;
            case NumberRole:
                storeItem.number = value.toString();
                result = true;
                break;
            case PasswordRole:
                storeItem.password = value.toString();
                result = true;
                break;
            case PinRole:
                storeItem.pin = value.toString();
                result = true;
                break;
            case RelateRole:
                storeItem.relate = value.toString();
                result = true;
                break;
            case DescriptionRole:
                storeItem.description = value.toString();
                result = true;
                break;
            }
        }
    }
    if (result){
        mStoreChanged = true;
        emit dataChanged(index, index);
    }
    return result;
}

bool Store::insertRow(int row, const QModelIndex &parent)
{
    if (!isOpen) return false;
    bool result = false;
    beginInsertRows(parent, row, row);

    endInsertRows();
    return result;
}

bool Store::removeRow(int row, const QModelIndex &parent)
{
    if (!isOpen) return false;
    bool result = false;
    beginRemoveRows(parent,row,row);
    mData.removeAt(row);
    endRemoveRows();
    return result;
}

bool Store::open(const QString storeName, const quint64 key)
{
    if (isOpen) close();
    crypto.setKey(key);
    QSettings settings;
    mStore.setFileName(QFileInfo(settings.fileName()).absolutePath() + "/" + storeName);
    //qDebug() << mStore.fileName();
    if (mStore.exists()){
        mStore.open(QIODevice::ReadOnly);
        QByteArray fileContents = crypto.decryptToByteArray(mStore.readAll());
        //Test the crypto data for errors
        //THis would tell us if the key provided is the right key
        if (crypto.lastError() != SimpleCrypt::ErrorNoError) return false;

        QJsonDocument json = QJsonDocument::fromJson(fileContents);
        mStore.close();

        QJsonArray data = json.array();

        beginInsertRows(QModelIndex(), mData.count(), mData.count());
        for (int i=0; i< data.count(); i++){
            QJsonObject item = data.at(i).toObject();
            StoreItem storeItem;
            storeItem.ID = item.value("ID").toString();
            storeItem.type = item.value("type").toInt();
            storeItem.style = item.value("style").toInt();
            storeItem.title = item.value("title").toString();
            storeItem.login = item.value("login").toString();
            storeItem.number = item.value("number").toString();
            storeItem.password = item.value("password").toString();
            storeItem.pin = item.value("pin").toString();
            storeItem.relate = item.value("relate").toString();
            storeItem.description = item.value("description").toString();
            mData.append(storeItem);
        }
        endInsertRows();
    } else saveData(); //If store file does not exist, create it
    mStoreChanged = false;    
    return isOpen = true;
}

void Store::close()
{
    if (!isOpen) return;
    if (mStoreChanged) saveData();
    beginRemoveRows(QModelIndex(), 0, mData.count());
        mData.clear();
    endRemoveRows();
    mStoreChanged = false;
    isOpen = false;
}

void Store::add(const QVariantMap &v)
{
    if (!isOpen) return;
    qDebug("Add row");
    StoreItem storeItem;
    beginInsertRows(QModelIndex(), mData.count(), mData.count());
    storeItem = v;
    storeItem.ID = QUuid::createUuid().toString();

    mData.append(storeItem);
    endInsertRows();
    mStoreChanged = true;
}

QVariantMap Store::get(const QString id)
{
    return (QVariantMap) mData[findElementIndexById(id)];
}

void Store::set(const QString id, const QVariantMap &v)
{
    StoreItem &storeItem = mData[findElementIndexById(id)];
    storeItem = v;
    mStoreChanged = true;
}

void Store::remove(const QString id)
{
    if (!isOpen) return;
    qDebug("Remove row");
    int index = findElementIndexById(id);
    beginRemoveRows(QModelIndex(),index, index);
    mData.removeAt(index);
    endRemoveRows();
    mStoreChanged = true;
}

int Store::findElementIndexById(const QString &id) const
{
    int index = -1;
    for(int i=0; i<mData.count();++i){
        if(mData[i].ID == id){
            index = i;
            break;
        }
    }
    return index;
}

void Store::saveData()
{
    QJsonArray data;
     for (int i=0; i < mData.count(); i++){
         QJsonObject item;
         StoreItem storeItem = mData.at(i);
         item.insert("ID", QJsonValue(storeItem.ID));
         item.insert("type", QJsonValue(storeItem.type));
         item.insert("style", QJsonValue(storeItem.style));
         item.insert("title", QJsonValue(storeItem.title));
         item.insert("login", QJsonValue(storeItem.login));
         item.insert("number", QJsonValue(storeItem.number));
         item.insert("password", QJsonValue(storeItem.password));
         item.insert("pin", QJsonValue(storeItem.pin));
         item.insert("relate", QJsonValue(storeItem.relate));
         item.insert("description", QJsonValue(storeItem.description));
         data.append(item);
     }
     QJsonDocument json = QJsonDocument(data);
     QByteArray fileContents = crypto.encryptToByteArray(json.toJson());

     if ( mStore.open(QIODevice::WriteOnly) )
     {
         mStore.write(fileContents);
         mStore.close();
     }
}
