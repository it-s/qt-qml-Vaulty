#ifndef VAULTS_H
#define VAULTS_H

#include <QString>
#include <QObject>
#include <QAbstractListModel>
#include <QList>
#include <QVariant>
#include <QHash>
#include <QByteArray>

struct Vault {
    int ID;
    QString
        name,
        description,
        file;
    operator QVariant() const
    {
        return QVariant::fromValue(*this);
    }
};
Q_DECLARE_METATYPE(Vault);

class Vaults : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        ID = Qt::UserRole + 1,
        NameRole,
        DescriptionRole
    };

    explicit Vaults(QObject *parent = 0);
    ~Vaults();
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const {return mDataRoles;}
    bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);

public slots:
    QVariantMap get(const int ID);
    void add(const QVariantMap& v);
    void remove(const int id);

private:
    QList<Vault> mData;
    QHash<int, QByteArray> mDataRoles;
};

#endif // VAULTS_H
