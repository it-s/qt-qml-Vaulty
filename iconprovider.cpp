#include <QStringList>
#include <QVariantMap>

#include <QDebug>

#include "iconprovider.h"

IconProvider::IconProvider(const qreal ratio)
    : QQuickImageProvider(QQuickImageProvider::Pixmap)
{
    mAwesome = new QtAwesome();
    mAwesome->initFontAwesome();

    mColorMap["light"] = QColor("#E3EAF7");
    mColorMap["dark"] = QColor("#414770");
    mColorMap["theme"] = QColor("#5e275f");
    mColorMap["default"] = mColorMap["dark"];

    mDefaultSize = QSize(24, 24);
    mRatio = ratio;
}

QPixmap IconProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    IconOptions options = getOptions(id);
    QVariantMap fontOptions;
    fontOptions.insert( "color" , options.color );
    if (size)
        *size = options.size;
    return mAwesome->icon(options.name,
                          fontOptions).pixmap(QSize(requestedSize.width() > 0 ? requestedSize.width() : options.size.width(),
                                                    requestedSize.height() > 0 ? requestedSize.height() : options.size.height()));
}

QSize IconProvider::qStringToQSize(const QString &s)
{
    if(s.contains("x")){
        QStringList sizeList = s.split("x");
        return QSize(sizeList[0].toInt(),sizeList[1].toInt()) * mRatio;
    }else
        return mDefaultSize * mRatio;
}

QColor IconProvider::qStringToQColor(const QString &s)
{
    if(mColorMap.contains(s)){
        return mColorMap[s];
    }else
        return QColor(s);
}

IconOptions IconProvider::getOptions(const QString &s)
{
    IconOptions options;
//    qDebug() << s;
    QStringList optionList = s.split("/");
//    qDebug() << optionList;
    if (optionList.count() == 3){
//        qDebug("Three options detected");
        options.color = qStringToQColor(optionList[0]);
        options.size  = qStringToQSize(optionList[1]);
        options.name = optionList[2];
    }
    else if (optionList.count() == 2 && optionList[0].contains("x")){
//        qDebug("Two options detected with sizes");
        options.color = mColorMap["default"];
        options.size  = qStringToQSize(optionList[0]);
        options.name = optionList[1];
    }
    else if (optionList.count() == 2){
//        qDebug("Two options detected with style");
        options.color = qStringToQColor(optionList[0]);
        options.size  = qStringToQSize();
        options.name = optionList[1];
    }
    else if (optionList.count() == 1 ){
//        qDebug("One option detected");
        options.color = mColorMap["default"];
        options.size  = qStringToQSize();
        options.name = s;
    }
    return options;
}


