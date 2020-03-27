#include "authmanager.hpp"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QJsonObject>
#include <QJsonDocument>
AuthManager::AuthManager(QObject *parent) : QObject(parent)
{

}

void AuthManager::authentificate(const QString &login,
                                 const QString &password)
{
    QUrl url("http://127.0.0.1:59256/auth");
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
        if(reply->error()!= QNetworkReply::NoError){
            this->authError = reply->errorString();
        }
        else {
            QJsonObject obj = QJsonDocument::fromJson(reply->readAll()).object();
            QString token = obj.value("token").toString();
            this->token = token;
        }
        this->onAuthFinished();
        reply -> deleteLater();
    });
}

void AuthManager::onAuthFinished()
{
    qDebug() << "Auth error: " << this->authError;
    qDebug() << "token: " << this->getToken();
    emit authReqComplete(this->authError);
}

QString AuthManager::getToken() {
    return this->token;
}

void AuthManager::registering(const QString &login, const QString &password)
{

    QUrl url("http://127.0.0.1:59256/register");
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
        if(reply->error()!= QNetworkReply::NoError){
            this->regError = reply->errorString();
        }
        else {
            this->onRegisterFinished();
            reply->deleteLater();
        }
    });

}
void AuthManager::onRegisterFinished()
{
    qDebug() << "Register error: " << this->regError;
    emit regReqComplete(this->regError);
}
