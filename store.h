#ifndef STORE_H
#define STORE_H

#include <QString>
#include <QFile>
#include <QList>
#include <QHash>
#include <QByteArray>

#include <QObject>
#include <QAbstractListModel>

struct StoreItem {
    int ID,
        type,
        style;
    QString
        title,
        login,
        number,
        password,
        pin,
        relate,
        description;
    operator QVariant() const
    {
        return QVariant::fromValue(*this);
    }
    operator QVariantMap() const
    {
        QVariantMap m;
        m.value("ID",this->ID);
        m.value("type",this->type);
        m.value("style",this->style);
        m.value("title",this->title);
        m.value("login",this->login);
        m.value("number",this->number);
        m.value("password",this->password);
        m.value("pin",this->pin);
        m.value("relate",this->relate);
        m.value("description",this->description);
        return m;
    }
    StoreItem& operator=(const QVariantMap& v)
    {
        this->ID = v.value("ID").toInt();
        this->type = v.value("type").toInt();
        this->style = v.value("style").toInt();
        this->title = v.value("title").toString();
        this->login = v.value("login").toString();
        this->number = v.value("number").toString();
        this->password = v.value("password").toString();
        this->pin = v.value("pin").toString();
        this->relate = v.value("relate").toString();
        this->description = v.value("description").toString();
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
    void open(const QString storeName);
    void close();

    void add(const QVariantMap& v);
    QVariantMap get(const int index);
    void set(const int index, const QVariantMap& v);
    void remove(const int id);

private:
    bool isOpen;
    QFile mStore;
    QList<StoreItem> mData;
    QHash<int, QByteArray> mDataRoles;
    bool mStoreChanged;

    bool storeExists(const QString fileName);
    void createNew(const QString fileName);
    QByteArray encode(QString raw);
    QString decode(QByteArray data);

};

#endif // STORE_H
