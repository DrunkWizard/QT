import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 290
    height: 500
    title: qsTr("Login")
    color: "black"
    property int pageCheck: 0 // 0 - Sign in page; 1 - Sign Up page

    TextField{
        id: login
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: titleText.bottom
        anchors.topMargin: 10
        placeholderText: "Login"
        font.pixelSize: 20
    }

    TextField{
        id: password
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: login.bottom
        anchors.topMargin: 10
        placeholderText: "Password"
        echoMode: "Password"
        font.pixelSize: 20
    }

    TextField{
        id: repeatPassword
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: password.bottom
        anchors.topMargin: 10
        placeholderText: "repeat password"
        echoMode: "Password"
        font.pixelSize: 20
        visible: {
            if(pageCheck == 0)
                return false
            else
                return true
        }
    }

    TextField{
        id: nickname
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: repeatPassword.bottom
        anchors.topMargin: 10
        placeholderText: "nickname"
        font.pixelSize: 20
        visible: {
            if(pageCheck == 0)
                return false
            else
                return true
        }
    }

    Text {
        id: titleText
        text: {
            if(pageCheck == 0)
                return "Sign In"
            else
                return "Sign Up"
        }

        color: "white"
        font.pixelSize: 40
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 10

    }

    Button {
        id: loginButton
        text: {
            if(pageCheck == 0)
                return "Sign In"
            else
                return "Sign Up"
        }
        enabled: (pageCheck == 0 && password.length > 5 && login.length > 5)
                 ||(pageCheck == 1 && password.length > 5 && login.length > 5
                    && repeatPassword.length > 5 && nickname.length > 5)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        anchors.top: {
            if(repeatPassword.visible == true)
                return nickname.bottom
            else
                return password.bottom
        }
        onClicked: {
            if ((password.text != repeatPassword.text) && pageCheck == 1)
                passwordDontMatch.visible = true
            else
                loadingCycle.visible = true
        }
    }

    BusyIndicator{
        id: loadingCycle
        palette.dark: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: loginButton.bottom
        anchors.topMargin: 10
        visible: false
    }

    Text{
        id: passwordDontMatch
        text: "Password value aren't same!"
        color: "red"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: loginButton.bottom
        anchors.topMargin: 20
        font.pixelSize: 15
        visible: false
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        spacing: 10

        Text {
            id: signIn
            color: "white"
            text: "Sign In"
            font.pixelSize: 20
            anchors.bottom: parent.bottom
            font.underline: {
                if (pageCheck == 0)
                    true
                else
                    false
            }

            MouseArea{
                id: signInMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if(pageCheck == 1){
                        pageCheck = 0
                        password.text = ''
                        nickname.text = ''
                        repeatPassword.text = ''
                        login.text = ''
                        passwordDontMatch.visible = false
                        loadingCycle.visible = false
                    }
                }
            }
        }

        Text {
            id: slash
            color: "white"
            text: "/"
            font.pixelSize: 20
            anchors.bottom: parent.bottom
        }

        Text {
            id: signUp
            color: "white"
            text: "Sign Up"
            font.pixelSize: 20
            anchors.bottom: parent.bottom
            font.underline: {
                if (pageCheck == 1)
                    true
                else
                    false
            }

            MouseArea{
                id: signUpMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if(pageCheck == 0){
                        pageCheck = 1
                        password.text = ''
                        nickname.text = ''
                        repeatPassword.text = ''
                        login.text = ''
                        passwordDontMatch.visible = false
                        loadingCycle.visible = false
                    }
                }
            }
        }
    }
}
