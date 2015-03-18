TEMPLATE = app

QT += qml quick

SOURCES += main.cpp \
    secureitem.cpp \
    vault.cpp \
    store.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    secureitem.h \
    vault.h \
    store.h
