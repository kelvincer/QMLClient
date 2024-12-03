import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts
import QtQuick.Controls.Universal
import QML_Client 1.0

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ClientConnection {
        id: clientConnection
    }

    ColumnLayout {
        id: infoColumn

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: 16
        }

        RowLayout {

            id: userRow
            height: 40
            width: infoColumn.width

            Text {
                id: nameLabel
                text: qsTr("Name:")
                font.pointSize: 20
            }

            TextField {
                id: textField
                Layout.fillWidth: true
                onTextChanged: clientConnection.userName = text

                background: Rectangle {
                    //implicitWidth: 200
                    implicitHeight: 30
                    anchors.fill: parent
                    height: 120
                    color: "white"
                    border.color: textField.activeFocus ? "red" : "lime"
                    border.width: 2
                    radius: 5
                }
            }

            Button {

                text: "Connect"
                Layout.alignment: Qt.AlignRight

                onClicked: {
                    clientConnection.on_connectButton_clicked()
                }
            }
        }

        TextArea {

            Layout.fillWidth: true
            Layout.fillHeight: true
            //wrapMode: TextArea.WrapAnywhere
            text: clientConnection.messages
            textFormat: TextEdit.RichText
        }

        RowLayout {
            TextField {
                Layout.fillWidth: true
            }

            Button {
                text: "Send"
                Layout.alignment: Qt.AlignRight
            }
        }
    }
}
