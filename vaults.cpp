#include <QDebug>
#include <QUuid>
#include <QSettings>
#include "vaults.h"

Vaults::Vaults(QObject *parent) :
    QAbstractListModel(parent)
{
    mDataRoles[ID] = "ID";
    mDataRoles[TitleRole] = "title";
    mDataRoles[FileNameRole] = "file";
    mDataRoles[DescriptionRole] = "description";

    QSettings mSettings;
    int size = mSettings.beginReadArray("vaults");
    for (int i = 0; i < size; ++i) {
        mSettings.setArrayIndex(i);
        Vault vault;
        vault.ID = mSettings.value("ID").toString();
        vault.file = mSettings.value("file").toString();
        vault.title = mSettings.value("title").toString();
        vault.description = mSettings.value("description").toString();
        mData.append(vault);
    }

    mSettings.endArray();
    mDataChanged = false;
}

Vaults::~Vaults()
{    
    if (mDataChanged) synch();
}


void Vaults::synch()
{
    QSettings mSettings;
    mSettings.beginWriteArray("vaults", mData.count());
    for (int i = 0; i < mData.size(); ++i) {
        mSettings.setArrayIndex(i);
        mSettings.setValue("ID", mData.at(i).ID);
        mSettings.setValue("file", mData.at(i).file);
        mSettings.setValue("title", mData.at(i).title);
        mSettings.setValue("description", mData.at(i).description);
    }
    mSettings.endArray();
    mDataChanged = false;
}

int Vaults::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    else
        return mData.size();
}

QVariant Vaults::data(const QModelIndex &index, int role) const
{

    QVariant result;

    //qDebug() << Q_FUNC_INFO << index << role;

    if (index.isValid()) {
        int row = index.row();
        if (row >= 0 && row < mData.size()) {
            const Vault &vault = mData[row];
            switch(role) {
            case ID:
                result = vault.ID;
                break;
            case TitleRole:
                result = vault.title;
                break;
            case DescriptionRole:
                result = vault.description;
                break;
            case FileNameRole:
                result = vault.file;
                break;
            }
        }
    }

    return result;
}

bool Vaults::setData(const QModelIndex &index, const QVariant &value, int role)
{
    bool result = false;
    if (index.isValid()) {
        int row = index.row();
        if (row >= 0 && row < mData.size()) {
            Vault &vault = mData[row];
            switch(role) {
            case TitleRole:
                vault.title = value.toString();
                result = true;
                break;
            case DescriptionRole:
                vault.description = value.toString();
                result = true;
                break;
            }
        }
    }
    if (result){
        emit dataChanged(index, index);
        mDataChanged = result;
    }
    return result;
}

QVariantMap Vaults::get(const QString& id)
{
    return (QVariantMap) mData[findElementIndexById(id)];
}

void Vaults::set(const QString &id, const QVariantMap &v)
{
    Vault &vault = mData[findElementIndexById(id)];
    vault = v;
//    mDataChanged = true;
    synch();
}

void Vaults::add(const QVariantMap &v)
{
    qDebug("Add row");
    Vault vault;
    beginInsertRows(QModelIndex(), mData.count(), mData.count());
    vault = v;
    vault.ID = QUuid::createUuid().toString();
    vault.file = "store" + vault.ID;
    mData.append(vault);
    endInsertRows();
//    mDataChanged = true;
    synch();
}

void Vaults::remove(const int id)
{
    qDebug("Remove row");
    beginRemoveRows(QModelIndex(),id, id);
    mData.removeAt(id);
    //TODO make sure store is also deleted
//    bool QFile::remove(const QString &fileName);
    endRemoveRows();
//    mDataChanged = true;
    synch();
}

int Vaults::findElementIndexById(const QString id) const
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

