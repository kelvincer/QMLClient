import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts
import QtQuick.Controls.Universal

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

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
            }
        }

        TextArea {

            Layout.fillWidth: true
            Layout.fillHeight: true
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
