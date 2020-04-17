import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.12
import AuthManager 1.0
import QtQuick.Dialogs 1.2

Item {
    id: signInForm
    height: parent.height
    width: parent.width

    AuthManager{
        id: authManager
        onAuthReqComplete: {
            autEndMessage.visible = true
            autEndMessage.text = (error == '') ? "Авторизация успешно завершена" : "Ошибка авторизации: "
            autEndMessage.informativeText = (error == '') ? "Токен: " + token : error
        }
    }

    MessageDialog{
        id: autEndMessage
        title: "Окончание запроса"
        standardButtons: MessageDialog.Ok
    }

    Text{
        id: signInTitle
        text: "Sign In"
        color: "white"
        font.pixelSize: 40
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 10

    }

    TextField{
        id: signInlogin
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: signInTitle.bottom
        anchors.topMargin: 10
        placeholderText: "Login"
        font.pixelSize: 20
    }

    TextField{
        id: signInpassword
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: signInlogin.bottom
        anchors.topMargin: 10
        placeholderText: "Password"
        echoMode: "Password"
        font.pixelSize: 20
    }

    Button {
        id: signInButton
        text: "Sign In"
        enabled:signInlogin.length > 5 && signInpassword.length > 5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        anchors.top: signInpassword.bottom
        onClicked:{
            authManager.authentificate(signInlogin.text, signInpassword.text)
        }
    }

    BusyIndicator{
        id: signInIndicator
        palette.dark: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: signInButton.bottom
        anchors.topMargin: 10
        running: authManager.authInProgress
    }

}
