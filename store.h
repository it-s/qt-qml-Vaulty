#ifndef STORE_H
#define STORE_H

#include <QString>
#include <QFile>
#include <QList>
#include <QHash>
#include <QByteArray>

#include <QObject>
#include <QAbstractListModel>

#include "simplecrypt.h"

struct StoreItem {
    int type,
        style;
    QString
        ID,
        title,
        login,
        number,
        password,
        pin,
        relate,
        description;
//    operator QVariant() const
//    {
//        return QVariant::fromValue(*this);
//    }
    operator QVariantMap() const
    {
        QVariantMap m;
        m["ID"]=this->ID;
        m["type"]=this->type;
        m["style"]=this->style;
        m["title"]=this->title;
        m["login"]=this->login;
        m["number"]=this->number;
        m["password"]=this->password;
        m["pin"]=this->pin;
        m["relate"]=this->relate;
        m["description"]=this->description;
        return m;
    }
    StoreItem& operator=(const QVariantMap& v)
    {
        if (v.contains("ID")) this->ID = v.value("ID").toString();
        if (v.contains("type")) this->type = v.value("type").toInt();
        if (v.contains("style")) this->style = v.value("style").toInt();
        if (v.contains("title")) this->title = v.value("title").toString();
        if (v.contains("login")) this->login = v.value("login").toString();
        if (v.contains("number")) this->number = v.value("number").toString();
        if (v.contains("password")) this->password = v.value("password").toString();
        if (v.contains("pin")) this->pin = v.value("pin").toString();
        if (v.contains("relate")) this->relate = v.value("relate").toString();
        if (v.contains("description")) this->description = v.value("description").toString();
        return *this;
    }
};

struct StoreHeader {
    int storeVersion;
    QString title,
            description;
    operator QVariantMap() const
    {
        QVariantMap m;
        m["storeVersion"]=this->storeVersion;
        m["title"]=this->title;
        m["description"]=this->description;
        return m;
    }
    StoreHeader& operator=(const QVariantMap& v)
    {
        if (v.contains("storeVersion")) this->storeVersion = v.value("storeVersion").toInt();
        if (v.contains("title")) this->title = v.value("title").toString();
        if (v.contains("description")) this->description = v.value("description").toString();
        return *this;
    }
};

Q_DECLARE_METATYPE(StoreItem);

class Store : public QAbstractListModel
{
    Q_OBJECT

    static const int VERSION = 1;

public:
    enum Roles {
        ID = Qt::UserRole + 1,
        TypeRole,
        StyleRole,
        TitleRole,
        LoginRole,
        NumberRole,
        PasswordRole,
        PinRole,
        RelateRole,
        DescriptionRole
    };

    Store(QObject *parent = 0);
    ~Store();

protected:
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const {return mDataRoles;}

    bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);

public slots:
    Q_INVOKABLE bool exists(const QVariantMap& vault);
    Q_INVOKABLE bool open(const QVariantMap& vault, const quint64 key = 0);
    Q_INVOKABLE void close();

    Q_INVOKABLE QVariantMap header();
    Q_INVOKABLE void add(const QVariantMap& v);
    Q_INVOKABLE QVariantMap get(const QString& id);
    Q_INVOKABLE void set(const QString& id, const QVariantMap& v);
    Q_INVOKABLE void remove(const QString& id);

    Q_INVOKABLE QString encode(const QString &v);
    Q_INVOKABLE QString decode(const QString &v);

private:
    bool isOpen;
    QFile mStore;
    StoreHeader mHeader;
    QList<StoreItem> mData;
    QHash<int, QByteArray> mDataRoles;
    bool mStoreChanged;
    SimpleCrypt crypto;

    int findElementIndexById(const QString id) const;
    void sync();
};

#endif // STORE_H
