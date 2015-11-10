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
ios {
    include(quickios/quickios.pri)
}
# include(QtAwesome/QtAwesome.pri)

HEADERS += *.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml

ios {
    QMAKE_INFO_PLIST = ios/Info.plist
    assets_catalogs.files = $$files($$PWD/ios/*.xcassets)
    launchimage.path = $$DESTDIR_TARGET
    launchimage.files = $$files($$PWD/ios/Launchimage/*)
    QMAKE_BUNDLE_DATA += assets_catalogs
    QMAKE_BUNDLE_DATA += launchimage
}
