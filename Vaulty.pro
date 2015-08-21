TEMPLATE = app
VERSION = 1.0.2

QT += qml quick

HEADERS += *.h
SOURCES += *.cpp
RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
include(Units/Units.pri)
include(QtAwesome/QtAwesome.pri)

HEADERS += *.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml

DISTFILES += \
    ios/Images.xcassets/AppIcon.appiconset/icon120-1.png \
    ios/Images.xcassets/AppIcon.appiconset/icon120.png \
    ios/Images.xcassets/AppIcon.appiconset/icon180.png \
    ios/Images.xcassets/AppIcon.appiconset/icon58.png \
    ios/Images.xcassets/AppIcon.appiconset/icon80.png \
    ios/Images.xcassets/AppIcon.appiconset/icon87.png \
    ios/Images.xcassets/LaunchImage.launchimage/splash1242x2208.png \
    ios/Images.xcassets/LaunchImage.launchimage/splash640x1136.png \
    ios/Images.xcassets/LaunchImage.launchimage/splash640x960.png \
    ios/Images.xcassets/LaunchImage.launchimage/splash750x1334.png \
    ios/Info.plist \
    ios/Images.xcassets/LaunchImage.launchimage/Contents.json \
    ios/Images.xcassets/AppIcon.appiconset/Contents.json

ios {
    QMAKE_INFO_PLIST = ios/Info.plist
    assets_catalogs.files = $$files($$PWD/ios/*.xcassets)
    QMAKE_BUNDLE_DATA += assets_catalogs
}
