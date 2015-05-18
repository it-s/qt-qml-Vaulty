#include "clipboard.h"

Clipboard::Clipboard(QClipboard *clipboard, QObject *parent) : QObject(parent)
{
    mClipboard = clipboard;
}

void Clipboard::copy(QString t)
{
    mClipboard->setText(t);
}

