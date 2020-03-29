#ifndef AUTHMANAGER_HPP
#define AUTHMANAGER_HPP

#include <QObject>
#include <QNetworkAccessManager>
#include <QString>

class AuthManager : public QObject
{
    Q_OBJECT
public:
    explicit AuthManager(QObject *parent = nullptr);
    void authentificate(const QString &login,
                        const QString &password);
    void registering(const QString &login,
                   const QString &password);
signals:
    void regReqComplete(QString);
    void authReqComplete(QString, QString);
private:
    QNetworkAccessManager _net;

};
#endif // AUTHMANAGER_HPP
