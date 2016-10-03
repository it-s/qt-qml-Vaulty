#ifndef DATAPATH_H
#define DATAPATH_H

#include <QObject>
#include <QDir>
#include <QRegExp>
#include <QStringList>

class dataPath : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString path READ dataPath WRITE setPath NOTIFY pathChanged)
    Q_PROPERTY(QStringList files READ files WRITE setFiles NOTIFY filesChanged)

    QString m_path;
    QStringList m_files;

public:
    explicit dataPath(QObject *parent = 0);

QStringList files() const;

signals:

void pathChanged(QString path);
void filesChanged(QStringList files);

public slots:
void setPath(QString path);

void setFiles(QStringList files);

private:
void scanPath();

};

#endif // DATAPATH_H
