#ifndef VAULT_H
#define VAULT_H

#include <QString>
#include <QList>
#include <QMap>
#include <QVariant>
#include <QStringList>

#include "secureitem.h"

class Vault
{
public:
    Vault();
    ~Vault();

    void open();
    void close();

    void add(const QMap<QString, QVariant> &item);
    void update(const int index, const QMap<QString, QVariant> &item);
    void remove(const int index);

    qint64 added() const;

    qint64 modified() const;

    qint64 accessed() const;

    bool isOpen() const;

    QString name() const;
    void setName(const QString &name);

private:

    qint64 mAdded;
    qint64 mModified;
    qint64 mAccessed;
    bool mOpen;
    QString mName;
    QString mData;

    QList <SecureItem> mValut;

};

#endif // VAULT_H
