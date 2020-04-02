#include <QCoreApplication>
#include "AuthManager.hpp"
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    AuthManager auth;
auth.registering("my_loging",
                 "my_passwords");
auth.authentificate("my_loging",
                    "my_passwords");
    return a.exec();
}
