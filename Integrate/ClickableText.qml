import QtQuick 2.13
import QtQuick.Controls 2.12

Text{
    id: clickableText
    font.pixelSize: 20
    anchors.bottom: parent.bottom
    color: "white"

    signal clicked();

    MouseArea{
        id: clickableTextMouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            clickableText.clicked();
        }
    }
}
