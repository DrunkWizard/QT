#include "authmanager.hpp"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QJsonObject>
#include <QJsonDocument>
AuthManager::AuthManager(QObject *parent) : QObject(parent)
{
    setAuthInProgress(false);
    setRegInProgress(false);
}

void AuthManager::authentificate(const QString &login,
                                 const QString &password)
{
    setAuthInProgress(true);
    QUrl url("http://127.0.0.1:52216/auth");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/json");
    QJsonObject body;
    body["login"] = login;
    body["password"] = password;
    QByteArray bodyData = QJsonDocument(body).toJson();
    QNetworkReply *reply = _net.post(request, bodyData);
    connect(reply, &QNetworkReply::finished,
            [this, reply](){
        QString authError;
        if(reply->error() != QNetworkReply::NoError){
            authError = reply->errorString();
        }
        QJsonObject obj = QJsonDocument::fromJson(reply->readAll()).object();
        QString token = obj.value("token").toString();
        emit authReqComplete(authError,token);
        setAuthInProgress(false);
        reply -> deleteLater();
    });
}

void AuthManager::registering(const QString &login,
                                const QString &password)
{
    setRegInProgress(true);
    QUrl url("http://127.0.0.1:52216/register");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/json");
    QJsonObject body;
    body["login"] = login;
    body["password"] = password;
    QByteArray bodyData = QJsonDocument(body).toJson();
    QNetworkReply *reply = _net.post(request, bodyData);
    connect(reply, &QNetworkReply::finished,
            [this, reply](){
        QString regError;
        if(reply->error() != QNetworkReply::NoError){
            regError = reply->errorString();
        }
        emit regReqComplete(regError);
        setRegInProgress(false);
        reply -> deleteLater();
    });

}

bool AuthManager::authInProgress()
{
    return m_authInProgress;
}

bool AuthManager::regInProgress()
{
    return m_regInProgress;
}

void AuthManager::setAuthInProgress(bool value)
{
    if(value == m_authInProgress)
        return;
    m_authInProgress = value;
    emit authInProgressChanged(value);
}

void AuthManager::setRegInProgress(bool value)
{
    if(value == m_regInProgress)
        return;
    m_regInProgress = value;
    emit regInProgressChanged(value);
}
