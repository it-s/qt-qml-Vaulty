#ifndef STOREFILTERPROXYMODEL_H
#define STOREFILTERPROXYMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>

class StoreFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT

public:
    StoreFilterProxyModel(QObject *parent = 0);

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const;
    bool lessThan(const QModelIndex &left, const QModelIndex &right) const;


};

#endif // STOREFILTERPROXYMODEL_H
