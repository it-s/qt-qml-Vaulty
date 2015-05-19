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
    QString
        ID,
        file,
        title,
        description;

    operator QVariantMap() const
    {
        QVariantMap m;
        m["ID"]=this->ID;
        m["file"]=this->file;
        m["title"]=this->title;
        m["description"]=this->description;
        return m;
    }
    Vault& operator=(const QVariantMap& v)
    {
        if (v.contains("ID")) this->ID = v.value("ID").toString();
        if (v.contains("file")) this->file = v.value("file").toString();
        if (v.contains("title")) this->title = v.value("title").toString();
        if (v.contains("description")) this->description = v.value("description").toString();
        return *this;
    }
};
Q_DECLARE_METATYPE(Vault);

class Vaults : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        ID = Qt::UserRole + 1,
        TitleRole,
        DescriptionRole,
        FileNameRole
    };

    void synch();

    explicit Vaults(QObject *parent = 0);
    ~Vaults();

protected:
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const {return mDataRoles;}
    bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);

public slots:
    Q_INVOKABLE void add(const QVariantMap& v);
    Q_INVOKABLE QVariantMap get(const QString& id);
    Q_INVOKABLE void set(const QString& id, const QVariantMap& v);
    Q_INVOKABLE void remove(const QString& id);

private:
    bool mDataChanged;
    QList<Vault> mData;
    QHash<int, QByteArray> mDataRoles;

    int findElementIndexById(const QString id) const;
};

#endif // VAULTS_H
