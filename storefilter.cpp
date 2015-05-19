#include <QDebug>
#include "storefilter.h"

StoreFilter::StoreFilter(QObject *parent)
    : QSortFilterProxyModel(parent)
{
    mType = -1;
    setSourceModel(&store);
    setSortRole(Store::TypeRole);
    setFilterCaseSensitivity(Qt::CaseInsensitive);
    sort(0);
}

StoreFilter::~StoreFilter()
{
    store.close();
}

void StoreFilter::setFilterType()
{
    setFilterType(-1);
}

void StoreFilter::setFilterType(int type)
{
    mType = type;
    invalidate();
}

int StoreFilter::filterType()
{
    return mType;
}

bool StoreFilter::open(const QString storeName, const QString key)
{
    //convert password hash to quint64
    quint64 n = key.toULongLong(NULL, 16);
    qDebug() << n;
    bool result = store.open(storeName, n);
    invalidate();
    return result;
}

void StoreFilter::close()
{
    store.close();
    mType = -1;
    invalidate();
}

void StoreFilter::add(const QVariantMap &v)
{
    store.add(v);
    invalidate();
}

QVariantMap StoreFilter::get(const QString id)
{
    return store.get(id);
}

void StoreFilter::set(const QString id, const QVariantMap &v)
{
    store.set(id, v);
    invalidate();
}

void StoreFilter::remove(const QString id)
{
    store.remove(id);
    invalidate();
}

bool StoreFilter::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);
    int type = sourceModel()->data(index, Store::TypeRole).toInt();
    QString title = sourceModel()->data(index, Store::TitleRole).toString();

    return (mType<0||type==mType)&&(title.contains(filterRegExp()));
}

//bool StoreFilter::lessThan(const QModelIndex &left, const QModelIndex &right) const
//{
//    const int leftt = sourceModel()->data(left, Store::TypeRole).toInt(),
//            rightt = sourceModel()->data(right, Store::TypeRole).toInt();
//    const QString &leftT = sourceModel()->data(left, Store::TitleRole).toString().at(0),
//            &rightT = sourceModel()->data(right, Store::TitleRole).toString().at(0);
//    return leftt < rightt || QString::localeAwareCompare(leftT, rightT);
//}

