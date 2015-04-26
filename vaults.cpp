#include <QDebug>
#include <QSettings>
#include "vaults.h"

Vaults::Vaults(QObject *parent) :
    QAbstractListModel(parent)
{
    mDataRoles[ID] = "ID";
    mDataRoles[NameRole] = "name";
    mDataRoles[DescriptionRole] = "description";
    mDataRoles[FileNameRole] = "file";

    QSettings mSettings;
    int size = mSettings.beginReadArray("vaults");
    for (int i = 0; i < size; ++i) {
        mSettings.setArrayIndex(i);
        Vault vault;
        vault.ID = mSettings.value("ID").toInt();
        vault.name = mSettings.value("name").toString();
        vault.description = mSettings.value("description").toString();
        vault.file = mSettings.value("file").toString();
        mData.append(vault);
    }

    mSettings.endArray();
}

Vaults::~Vaults()
{    
    QSettings mSettings;
    mSettings.beginWriteArray("vaults", mData.count());
    for (int i = 0; i < mData.size(); ++i) {
        mSettings.setArrayIndex(i);
        mSettings.setValue("ID", mData.at(i).ID);
        mSettings.setValue("name", mData.at(i).name);
        mSettings.setValue("description", mData.at(i).description);
        mSettings.setValue("file", mData.at(i).file);
    }
    mSettings.endArray();
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
            case NameRole:
                result = vault.name;
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
            case NameRole:
                vault.name = value.toString();
                result = true;
                break;
            case DescriptionRole:
                vault.description = value.toString();
                result = true;
                break;
            }
        }
    }
    if (result) emit dataChanged(index, index);
    return result;
}

QVariantMap Vaults::get(const int ID)
{
    Vault vault = mData.at(ID);
    QVariantMap map;
    map.value("name", vault.name);
    map.value("description", vault.description);
    return map;
}

void Vaults::add(const QVariantMap &v)
{
    qDebug("Add row");
    Vault vault;
    beginInsertRows(QModelIndex(), mData.count(), mData.count());
    vault.ID = mData.count();
    vault.name = v.value("name").toString();
    vault.description = v.value("description").toString();
    vault.file = "store" + mData.count();
    mData.append(vault);
    endInsertRows();
}

void Vaults::remove(const int id)
{
    qDebug("Remove row");
    beginRemoveRows(QModelIndex(),id, id);
    mData.removeAt(id);
    endRemoveRows();
}

