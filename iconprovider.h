#ifndef ICONPROVIDER_H
#define ICONPROVIDER_H

#include <QQuickImageProvider>
#include <QHash>
#include <QtAwesome.h>

struct IconOptions {
    QSize   size;
    QColor  color;
    QString name;
};

class IconProvider : public QQuickImageProvider
{
public:
    IconProvider(const qreal ratio = 1);

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);

public slots:



private:
    QHash<QString, QColor> mColorMap;
    QSize mDefaultSize;
    QtAwesome* mAwesome;
    qreal mRatio;

    QSize qStringToQSize(const QString &s = "");
    QColor qStringToQColor(const QString &s = "");
    IconOptions getOptions(const QString &s);

};

#endif // ICONPROVIDER_H
