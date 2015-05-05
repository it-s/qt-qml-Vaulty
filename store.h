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
Q_DECLARE_METATYPE(StoreItem);

class Store : public QAbstractListModel
{
    Q_OBJECT
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
    bool insertRow(int row, const QModelIndex & parent = QModelIndex());
    bool removeRow(int row, const QModelIndex & parent = QModelIndex());

public slots:
    void open(const QString storeName, const quint64 key = 0);
    void close();

    void add(const QVariantMap& v);
    QVariantMap get(const QString id);
    void set(const QString id, const QVariantMap& v);
    void remove(const QString id);

private:
    bool isOpen;
    QFile mStore;
    QList<StoreItem> mData;
    QHash<int, QByteArray> mDataRoles;
    bool mStoreChanged;
    SimpleCrypt crypto;

    bool storeExists(const QString fileName);
    void createNew(const QString fileName);
    int findElementIndexById(const QString& id) const;
    void setDataKey(const quint64 key);
    quint64 getDataKey() const;

};

#endif // STORE_H
