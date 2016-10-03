#include <QSettings>
#include "datapath.h"

dataPath::dataPath(QObject *parent) : QObject(parent)
{
    QSettings settings;
    m_path = settings.value("dataPath", QFileInfo(settings.fileName()).absolutePath()).toString();
}

QStringList dataPath::files() const
{
    return m_files;
}

void dataPath::setPath(QString path)
{
    if (m_path == path)
        return;

    QSettings settings;

    if (path.isEmpty()) {
        settings.remove("dataPath");
        m_path = QFileInfo(settings.fileName()).absolutePath();
    } else {
        settings.setValue("dataPath", path);
        m_path = path;
    }
    scanPath();
    emit pathChanged(path);
}

void dataPath::setFiles(QStringList files)
{
    if (m_files == files)
        return;

    m_files = files;
    emit filesChanged(files);
}

void dataPath::scanPath()
{
    QDir data(m_path);
    QRegExp test("store{.+}");
    QStringList files = data.entryList();
    for( int i = 0; i < files.count(); i++){
        if(test.exactMatch(files[i])){
            files.removeAt(i);
        }
    }
    m_files = files;
    filesChanged(m_files);
}
