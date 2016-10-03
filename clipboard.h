#ifndef CLIPBOARD_H
#define CLIPBOARD_H

#include <QObject>
#include <QClipboard>

class Clipboard : public QObject
{
    Q_OBJECT
public:
    explicit Clipboard(QClipboard *clipboard, QObject *parent = 0);

signals:

public slots:
    Q_INVOKABLE void copy(QString t);

private:
    QClipboard *mClipboard;
};

#endif // CLIPBOARD_H
