#include "iconprovider.h"

IconProvider::IconProvider()
    : QQuickImageProvider(QQuickImageProvider::Pixmap)
{
    mAwesome = new QtAwesome();
    mAwesome->initFontAwesome();

    mColorMap["light"] = QColor(255,255,255);
    mColorMap["dark"] = QColor(0,0,0);
    mColorMap["default"] = mColorMap["dark"];

    mDefaultSize = QSize(24, 24);
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

IconOptions& IconProvider::getOptions(const QString &s)
{
    IconOptions options;
    QStringList optionList = s.split("/");
    if (optionList.count() == 3){
        QStringList sizeList = optionList[1].split("x");
        options.color = mColorMap[optionList[0]];
        options.size  = QSize(sizeList[0].toInt(),sizeList[1].toInt());
        options.name = optionList[2];
    }
    else if (optionList.count() == 2 && optionList[0].contains("x")){
        QStringList sizeList = optionList[0].split("x");
        options.color = mColorMap["default"];
        options.size  = QSize(sizeList[0].toInt(),sizeList[1].toInt());
        options.name = optionList[1];
    }
    else if (optionList.count() == 2)
    {
        options.color = mColorMap[optionList[0]];
        options.size  = mDefaultSize;
        options.name = optionList[1];
    }
    else if (optionList.count() == 1 ){
        options.color = mColorMap["default"];
        options.size  = mDefaultSize;
        options.name = s;
    }
    return options;
}


