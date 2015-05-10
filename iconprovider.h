#ifndef ICONPROVIDER_H
#define ICONPROVIDER_H

#include <QQuickImageProvider>
#include <QtAwesome.h>

struct IconOptions {
    QSize   size;
    QColor  color;
    QString name;
};

class IconProvider : public QQuickImageProvider
{
public:
    IconProvider();

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);

public slots:



private:
    QHash<QString, QColor> mColorMap;
    QSize mDefaultSize;
    QtAwesome* mAwesome;

    IconOptions &getOptions(const QString &s);

};

#endif // ICONPROVIDER_H
