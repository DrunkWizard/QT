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
    QString getToken();
    QString authError;
    QString regError;
private slots:
    void onRegisterFinished();
    void onAuthFinished();
signals:
    void regReqComplete(QString);
    void authReqComplete(QString);
private:
    QNetworkAccessManager _net;
    QString token;

};
#endif // AUTHMANAGER_HPP
