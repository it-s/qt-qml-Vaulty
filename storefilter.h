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
    Q_INVOKABLE void setFilterType();
    Q_INVOKABLE void setFilterType(int type);
    Q_INVOKABLE int filterType();

    Q_INVOKABLE bool open(const QVariantMap& vault, const QString key);
    Q_INVOKABLE void close();

    Q_INVOKABLE QVariantMap header();
    Q_INVOKABLE void add(const QVariantMap& v);
    Q_INVOKABLE QVariantMap get(const QString id);
    Q_INVOKABLE void set(const QString id, const QVariantMap& v);
    Q_INVOKABLE void remove(const QString id);

    Q_INVOKABLE QString encode(const QString &v){return store.encode(v);}
    Q_INVOKABLE QString decode(const QString &v){return store.decode(v);}

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const;
//    bool lessThan(const QModelIndex &left, const QModelIndex &right) const;

private:
    int mType;    
    Store store;

};

#endif // StoreFilter_H
