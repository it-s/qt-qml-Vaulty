#ifndef VAULTS_H
#define VAULTS_H

#include <QObject>

class Vaults : public QObject
{
    Q_OBJECT
public:
    explicit Vaults(QObject *parent = 0);
    ~Vaults();

signals:

public slots:
};

#endif // VAULTS_H
