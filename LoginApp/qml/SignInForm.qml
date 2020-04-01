import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.12

Item {
    id: signInForm
    height: parent.height
    width: parent.width

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
        onClicked: signInIndicator.visible = true
    }

    BusyIndicator{
        id: signInIndicator
        palette.dark: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: signInButton.bottom
        anchors.topMargin: 10
        visible: false
    }

}
