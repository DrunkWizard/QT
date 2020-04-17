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

    Loader{
        id: pageLoader
        anchors.fill: parent;
        source: (pageCheck == 0)
                ? "qrc:/qml/SignInForm.qml"
                : "qrc:/qml/SignUpForm.qml"
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        spacing: 10

        ClickableText{
            id: signIn
            text: "Sign In"
            font.underline: pageCheck == 0
            onClicked: {
                pageCheck = 0;
            }
        }

        Text {
            id: slash
            color: "white"
            text: "/"
            font.pixelSize: 20
            anchors.bottom: parent.bottom
        }

        ClickableText{
            id: signUp
            text: "Sign Up"
            font.underline: pageCheck == 1
            onClicked: {
                pageCheck = 1;
            }
        }
    }
}
