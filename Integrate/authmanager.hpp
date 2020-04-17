#ifndef AUTHMANAGER_HPP
#define AUTHMANAGER_HPP

#include <QObject>
#include <QNetworkAccessManager>
#include <QString>

class AuthManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool authInProgress READ authInProgress WRITE setAuthInProgress NOTIFY authInProgressChanged)
    Q_PROPERTY(bool regInProgress READ regInProgress WRITE setRegInProgress NOTIFY regInProgressChanged)
public:
    explicit AuthManager(QObject *parent = nullptr);
    Q_INVOKABLE void authentificate(const QString &login,
                        const QString &password);
    Q_INVOKABLE void registering(const QString &login,
                   const QString &password);
    bool authInProgress();
    bool regInProgress();
    void setAuthInProgress(bool value);
    void setRegInProgress(bool value);

signals:
    void regReqComplete(QString error);
    void authReqComplete(QString error, QString token);
    void authInProgressChanged(bool value);
    void regInProgressChanged(bool value);
private:
    QNetworkAccessManager _net;
    bool m_authInProgress;
    bool m_regInProgress;

};
#endif // AUTHMANAGER_HPP
