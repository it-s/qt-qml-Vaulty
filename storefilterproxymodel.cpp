#include "storefilterproxymodel.h"

StoreFilterProxyModel::StoreFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
    mType = -1;
    setSourceModel(&store);
    setSortRole(Store::TypeRole);
    setFilterCaseSensitivity(Qt::CaseInsensitive);
}

StoreFilterProxyModel::~StoreFilterProxyModel()
{
    store.close();
}

void StoreFilterProxyModel::setFilterType(int type)
{
    mType = type;
}

int StoreFilterProxyModel::filterType()
{
    return mType;
}

void StoreFilterProxyModel::open(const QString storeName)
{
    store.open(storeName);
}

void StoreFilterProxyModel::close()
{
    store.close();
}

void StoreFilterProxyModel::add(const QVariantMap &v)
{
    store.add(v);
}

void StoreFilterProxyModel::remove(const int id)
{
    store.remove(id);
}

bool StoreFilterProxyModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    Q_UNUSED(sourceRow);
    int type = sourceModel()->data(sourceParent, Store::TypeRole).toInt();
    QString title = sourceModel()->data(sourceParent, Store::TitleRole).toString();

    return (mType<0||type==mType)&&(title.contains(filterRegExp()));
}

