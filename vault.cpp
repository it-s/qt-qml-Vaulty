#include "vault.h"

Vault::Vault()
{

}

Vault::~Vault()
{

}
qint64 Vault::added() const
{
    return mAdded;
}

qint64 Vault::modified() const
{
    return mModified;
}

qint64 Vault::accessed() const
{
    return mAccessed;
}

bool Vault::isOpen() const
{
    return mOpen;
}

QString Vault::name() const
{
    return mName;
}

void Vault::setName(const QString &name)
{
    mName = name;
}








