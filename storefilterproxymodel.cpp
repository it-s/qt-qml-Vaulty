#include <QDebug>
#include "storefilterproxymodel.h"

StoreFilterProxyModel::StoreFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
    mType = -1;
    setSourceModel(&store);
    setSortRole(Store::TypeRole);
    setFilterCaseSensitivity(Qt::CaseInsensitive);
    sort(0);
}

StoreFilterProxyModel::~StoreFilterProxyModel()
{
    store.close();
}

void StoreFilterProxyModel::setFilterType()
{
    setFilterType(-1);
}

void StoreFilterProxyModel::setFilterType(int type)
{
    mType = type;
    invalidate();
}

int StoreFilterProxyModel::filterType()
{
    return mType;
}

void StoreFilterProxyModel::open(const QString storeName)
{
    store.open(storeName);
    invalidate();
}

void StoreFilterProxyModel::close()
{
    store.close();
    mType = -1;
    invalidate();
}

void StoreFilterProxyModel::add(const QVariantMap &v)
{
    store.add(v);
    invalidate();
}

void StoreFilterProxyModel::remove(const int id)
{
    store.remove(id);
    invalidate();
}

bool StoreFilterProxyModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);
    int type = sourceModel()->data(index, Store::TypeRole).toInt();
    QString title = sourceModel()->data(index, Store::TitleRole).toString();

    return (mType<0||type==mType)&&(title.contains(filterRegExp()));
}

