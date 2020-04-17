import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import AuthManager 1.0

Item{
    id: signUpForm
    height: parent.height
    width: parent.width

    AuthManager{
        id: authManager
        onRegReqComplete: {
            regEndMessage.visible = true
            regEndMessage.text = (error == '')? "Регистрация успешно завершена" : "Ошибка регистрации: "
            regEndMessage.informativeText = error
        }
    }

    MessageDialog {
        id: regEndMessage
        title: "Окончание запроса"
        standardButtons: MessageDialog.Ok
        }

    Text{
        id: signUpTitle
        text: "Sign Up"
        color: "white"
        font.pixelSize: 40
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 10

    }
    TextField{
        id: signUplogin
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: signUpTitle.bottom
        anchors.topMargin: 10
        placeholderText: "login"
        font.pixelSize: 20
    }

    TextField{
        id: signUppassword
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: signUplogin.bottom
        anchors.topMargin: 10
        placeholderText: "password"
        echoMode: "Password"
        font.pixelSize: 20
    }

    TextField{
        id: repeatPassword
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: signUppassword.bottom
        anchors.topMargin: 10
        placeholderText: "repeat password"
        echoMode: "Password"
        font.pixelSize: 20
    }

    TextField{
        id: nickname
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: repeatPassword.bottom
        anchors.topMargin: 10
        placeholderText: "nickname"
        font.pixelSize: 20
    }

    Text{
        id: passwordDontMatch
        text: "Password value aren't same!"
        color: "red"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: signUpButton.bottom
        anchors.topMargin: 20
        font.pixelSize: 15
        visible: false
    }

    Button {
        id: signUpButton
        text: "Sign Up"
        enabled:signUppassword.length > 5 && repeatPassword.length > 5
                && nickname.length > 5 && signUplogin.length > 5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        anchors.top: nickname.bottom
        onClicked: {
            if ((repeatPassword.text !== signUppassword.text) && pageCheck == 1){
                passwordDontMatch.visible = true
            }
            else{
                authManager.registering(signUplogin.text, signUppassword.text)
                passwordDontMatch.visible = false
            }
        }
    }

    BusyIndicator{
        id: signUpIndicator
        palette.dark: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: signUpButton.bottom
        anchors.topMargin: 10
        running: authManager.regInProgress
    }

}
