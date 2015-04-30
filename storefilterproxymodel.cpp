#include "storefilterproxymodel.h"

StoreFilterProxyModel::StoreFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
}

bool StoreFilterProxyModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{

}

bool StoreFilterProxyModel::lessThan(const QModelIndex &left, const QModelIndex &right) const
{
    QVariant leftData = sourceModel()->data(left);
    QVariant rightData = sourceModel()->data(right);

    if (leftData.type() == QVariant::Int) {
        return leftData < rightData;
    } else {
        QString leftString = leftData.toString();
        QString rightString = rightData.toString();
        return QString::localeAwareCompare(leftString, rightString) < 0;
    }
}


