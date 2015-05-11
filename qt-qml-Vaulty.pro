TEMPLATE = app

QT += qml quick

HEADERS += *.h
SOURCES += *.cpp
RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
<<<<<<< HEAD
include(Units/Units.pri)

HEADERS += *.h
=======
include(QtAwesome/QtAwesome.pri)
>>>>>>> refs/remotes/origin/ImageProvider

