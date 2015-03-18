#include <QDateTime>
#include "secureitem.h"

SecureItem::SecureItem()
{
    mOpen = false;
    itemCreated();
}

SecureItem::SecureItem(QMap<QString, QVariant> &item)
{
    mOpen = false;
    set(item);
}

SecureItem::~SecureItem()
{

}

void SecureItem::open()
{
    mOpen = true;
    itemAccessed();
}

bool SecureItem::isOpen() const
{
    return mOpen;
}

void SecureItem::close()
{
    mOpen = false;
}

qint64 SecureItem::added() const
{
    return mAdded;
}

qint64 SecureItem::modified() const
{
    return mModified || mAdded;
}

qint64 SecureItem::accessed() const
{
    return mAccessed || mAdded;
}

int SecureItem::category() const
{
    return mCategory;
}

void SecureItem::setCategory(int category)
{
    mCategory = category;
    itemModified();
}
int SecureItem::style() const
{
    return mStyle;
}

void SecureItem::setStyle(int style)
{
    mStyle = style;
    itemModified();
}
QString SecureItem::title() const
{
    return mTitle;
}

void SecureItem::setTitle(const QString &title)
{
    mTitle = title;
    itemModified();
}
QString SecureItem::service() const
{
    return mService;
}

void SecureItem::setService(const QString &service)
{
    mService = service;
    itemModified();
}
QString SecureItem::userName() const
{
    return mUserName;
}

void SecureItem::setUserName(const QString &userName)
{
    mUserName = userName;
    itemModified();
}
int SecureItem::number() const
{
    return mNumber;
}

void SecureItem::setNumber(int number)
{
    mNumber = number;
    itemModified();
}
QString SecureItem::password() const
{
    return mPassword;
}

void SecureItem::setPassword(const QString &password)
{
    mPassword = password;
    itemModified();
}
int SecureItem::pin() const
{
    return mPIN;
}

void SecureItem::setPIN(int pIN)
{
    mPIN = pIN;
    itemModified();
}
QUrl SecureItem::relate() const
{
    return mRelate;
}

void SecureItem::setRelate(const QUrl &relate)
{
    mRelate = relate;
    itemModified();
}
QString SecureItem::remarks() const
{
    return mRemarks;
}

void SecureItem::setRemarks(const QString &remarks)
{
    mRemarks = remarks;
    itemModified();
}

QString SecureItem::getTagsCSV() const
{
    return mTagsCSV;
}

void SecureItem::setTagsCSV(const QString &value)
{
    mTagsCSV = value;
    itemModified();
}

QStringList SecureItem::getTags() const
{
    return mTagsCSV.split(",");
}

void SecureItem::setTags(const QStringList &tags)
{
    setTagsCSV(tags.join(","));
}

QMap<QString, QVariant> SecureItem::get() const
{
    QMap<QString, QVariant> map;
    map.insert("index", mIndex);
    map.insert("added", added());
    map.insert("modified", modified());
    map.insert("accessed", accessed());
    map.insert("category", mCategory);
    map.insert("style", mStyle);
    map.insert("title", mTitle);
    map.insert("service", mService);
    map.insert("open", mOpen);
    if (mOpen) {
        map.insert("userName", mUserName);
        map.insert("number", mNumber);
        map.insert("password", mPassword);
        map.insert("PIN", mPIN);
        map.insert("relate", mRelate);
        map.insert("remarks", mRemarks);
        map.insert("tags", mTagsCSV);
    }

    return map;
}

void SecureItem::set(const QMap<QString, QVariant> &item)
{
    if (item.contains("index"))     mIndex = (int) item["index"].toInt();
    if (item.contains("category"))  mCategory = (int) item["category"].toInt();
    if (item.contains("style"))     mStyle = (int) item["style"].toInt();
    if (item.contains("title"))     mTitle = (QString) item["title"].toString();
    if (item.contains("service"))   mService = (QString) item["service"].toString();
    if (item.contains("userName"))  mUserName = (QString) item["userName"].toString();
    if (item.contains("number"))    mNumber = (int) item["number"].toInt();
    if (item.contains("password"))  mPassword = (QString) item["password"].toString();
    if (item.contains("PIN"))       mPIN = (int) item["PIN"].toInt();
    if (item.contains("relate"))    mRelate = (QUrl) item["relate"].toUrl();
    if (item.contains("remarks"))   mRemarks = (QString)  item["remarks"].toString();
    if (item.contains("tags"))      mTagsCSV = (QString) item["tags"].toString();

    itemModified();
}

void SecureItem::itemCreated()
{
    mAdded = QDateTime().currentDateTimeUtc().toMSecsSinceEpoch();
}

void SecureItem::itemModified()
{
    mModified = QDateTime().currentDateTimeUtc().toMSecsSinceEpoch();
}

void SecureItem::itemAccessed()
{
    mAccessed = QDateTime().currentDateTimeUtc().toMSecsSinceEpoch();
}
int SecureItem::index() const
{
    return mIndex;
}

void SecureItem::setIndex(int index)
{
    mIndex = index;
}















