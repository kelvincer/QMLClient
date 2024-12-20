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
    title: qsTr("Client Window")
    color: "mediumseagreen"

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
                font.pointSize: 15
                color: "white"
                font.weight: Font.Medium
            }

            TextField {
                id: textFieldName
                Layout.fillWidth: true
                onTextChanged: clientConnection.userName = text
                placeholderText: qsTr("Input your name")
                readOnly: clientConnection.isConnected

                background: Rectangle {
                    implicitHeight: 30
                    anchors.fill: parent
                    height: 120
                    color: "white"
                    border.color: textFieldName.activeFocus ? "greenyellow" : "lightslategrey"
                    border.width: 3
                    radius: 5
                }
            }

            Button {
                id: connectButton
                text: clientConnection.isConnected ? "Disconnect" : "Connect"
                Layout.alignment: Qt.AlignRight
                palette.buttonText: "white"
                enabled: {
                    if(textFieldName.text === "") {
                        false
                    } else {
                        true
                    }
                }

                onClicked: {
                    clientConnection.on_connectButton_clicked()
                    forceActiveFocus()
                }

                contentItem: Text {
                    text: connectButton.text
                    font.weight: Font.Medium
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
            }
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            TextArea {
                id: textArea
                wrapMode: TextArea.Wrap
                text: clientConnection.messages
                textFormat: Text.RichText
                readOnly: true
                selectionColor: "green"

                background: Rectangle {
                    color: "white"
                    border.color: "springgreen"
                    border.width: 3
                    radius: 5
                }
            }
        }

        RowLayout {
            TextField {
                id: messageTextField
                Layout.fillWidth: true
                //text: clientConnection.message
                placeholderText: qsTr("Input your message")
                onTextChanged: clientConnection.message = text;

                background: Rectangle {
                    implicitHeight: 30
                    color: "white"
                    border.color: messageTextField.activeFocus ? "greenyellow" : "lightslategrey"
                    border.width: 3
                    radius: 5
                }
            }

            Button {
                id: sendButton
                text: "Send"
                Layout.alignment: Qt.AlignRight

                contentItem: Text {
                    text: sendButton.text
                    font.weight: Font.Medium
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                onClicked: {
                    clientConnection.on_sendButton_clicked()
                    messageTextField.clear();
                    forceActiveFocus()
                }

                enabled: {
                    if(messageTextField.text === "" || textFieldName.text === "" || !clientConnection.isConnected) {
                        false
                    } else {
                        true
                    }
                }
            }
        }
    }
}
