#ifndef SECUREITEM_H
#define SECUREITEM_H
#include <QString>
#include <QUrl>
#include <QMap>
#include <QVariant>
#include <QStringList>

class SecureItem
{
public:
    SecureItem();
    SecureItem(QMap<QString,QVariant> &item);
    ~SecureItem();

    void open();
    bool isOpen() const;
    void close();

    qint64 added() const;

    qint64 modified() const;

    qint64 accessed() const;

    int category() const;
    void setCategory(int category);

    int style() const;
    void setStyle(int style);

    QString title() const;
    void setTitle(const QString &title);

    QString service() const;
    void setService(const QString &service);

    QString userName() const;
    void setUserName(const QString &userName);

    int number() const;
    void setNumber(int number);

    QString password() const;
    void setPassword(const QString &password);

    int pin() const;
    void setPIN(int pIN);

    QUrl relate() const;
    void setRelate(const QUrl &relate);

    QString remarks() const;
    void setRemarks(const QString &remarks);

    QString getTagsCSV() const;
    void setTagsCSV(const QString &value);
    QStringList getTags() const;
    void setTags(const QStringList &tags);

    QMap<QString, QVariant> get() const;
    void set(const QMap<QString, QVariant> &item);

    int index() const;
    void setIndex(int index);

private:
    void itemCreated();
    void itemModified();
    void itemAccessed();

    bool mOpen;

    int mIndex;
    qint64 mAdded;
    qint64 mModified;
    qint64 mAccessed;
    int mCategory;
    int mStyle;
    QString mTitle;
    QString mService;
    QString mUserName;
    int mNumber;
    QString mPassword;
    int mPIN;
    QUrl mRelate;
    QString mRemarks;
    QString mTagsCSV;
};

#endif // SECUREITEM_H
