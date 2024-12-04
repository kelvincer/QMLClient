#include "clientconnection.h"

ClientConnection::ClientConnection(QObject *parent)
    : QObject{parent}
{}

QString ClientConnection::userName()
{
    return m_userName;
}

QString ClientConnection::messages()
{
    return m_messages;
}

void ClientConnection::setUserName(const QString &userName)
{
    if (userName == m_userName)
        return;

    m_userName = userName;
    emit userNameChanged();
}

void ClientConnection::setMessages(const QString &messages)
{
    m_messages = messages;
    emit messagesChanged();
}

void ClientConnection::on_connectButton_clicked()
{
    if (!connectedToHost)
    {
        socket = new QTcpSocket();

        connect(socket, &QTcpSocket::connected, this, &ClientConnection::socketConnected);
        connect(socket, &QTcpSocket::disconnected, this, &ClientConnection::socketDisconnected);
        connect(socket, &QTcpSocket::readyRead, this, &ClientConnection::socketReadyRead);

        socket->connectToHost("127.0.0.1", 8001);
    }
    else
    {
        socket->write("<font color=\"Orange\">" + m_userName.toUtf8() + " has left the chat room.</font><br>");

        socket->disconnectFromHost();
    }
}

void ClientConnection::on_sendButton_clicked()
{
    //QString name = ui->nameInput->text();
    //QString message = ui->messageInput->text();
    //socket->write("<font color=\"Blue\">" + m_userName.toUtf8() + "</font>: " + message.toUtf8());

    //ui->messageInput->clear();
}

void ClientConnection::socketConnected()
{
    qDebug() << "Connected to server.";

    printMessage("<font color=\"Green\">Connected to server.</font><br>");

    socket->write("<font color=\"Purple\">" + m_userName.toUtf8() + " has joined the chat room.</font><br>");

    connectedToHost = true;

    emit isConnectedChanged();
}

void ClientConnection::socketDisconnected()
{
    qDebug() << "Disconnected from server.";

    printMessage("<font color=\"Red\">Disconnected from server.</font><br>");

    connectedToHost = false;

    emit isConnectedChanged();
}

void ClientConnection::socketReadyRead()
{
    printMessage(socket->readAll());
}

void ClientConnection::printMessage(QString message)
{
    //ui->chatDisplay->append(message);
    m_messages.append(message);
    emit messagesChanged();
}

bool ClientConnection::isConnectedToHost()
{
    return connectedToHost;
}

