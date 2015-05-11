TEMPLATE = app

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

