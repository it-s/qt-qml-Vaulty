#ifndef STOREFILTERPROXYMODEL_H
#define STOREFILTERPROXYMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>

#include "store.h"

class StoreFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT

public:
    StoreFilterProxyModel(QObject *parent = 0);
    ~StoreFilterProxyModel();

public slots:
    void setFilterType(int type);
    int filterType();

    void open(const QString storeName);
    void close();

    void add(const QVariantMap& v);
    void remove(const int id);

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const;
//    bool lessThan(const QModelIndex &left, const QModelIndex &right) const;

private:
    int mType;    
    Store store;

};

#endif // STOREFILTERPROXYMODEL_H
