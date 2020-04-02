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
    QUrl url("http://127.0.0.1:54086/auth");
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
        reply -> deleteLater();
    });
}

void AuthManager::registering(const QString &login, const QString &password)
{

    QUrl url("http://127.0.0.1:54086/register");
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
        reply -> deleteLater();
    });

}
