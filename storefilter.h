#ifndef StoreFilter_H
#define StoreFilter_H

#include <QObject>
#include <QSortFilterProxyModel>

#include "store.h"

class StoreFilter : public QSortFilterProxyModel
{
    Q_OBJECT

public:
    StoreFilter(QObject *parent = 0);
    ~StoreFilter();

public slots:
    void setFilterType();
    void setFilterType(int type);
    int filterType();

    bool open(const QString storeName, const QString key);
    void close();

    void add(const QVariantMap& v);
    QVariantMap get(const QString id);
    void set(const QString id, const QVariantMap& v);
    void remove(const QString id);

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const;
//    bool lessThan(const QModelIndex &left, const QModelIndex &right) const;

private:
    int mType;    
    Store store;

};

#endif // StoreFilter_H
