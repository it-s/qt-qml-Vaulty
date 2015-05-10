#include "iconprovider.h"

IconProvider::IconProvider()
    : QQuickImageProvider(QQuickImageProvider::Pixmap)
{

}

QPixmap IconProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{

}


