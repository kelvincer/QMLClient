#ifndef CLIENTCONNECTION_H
#define CLIENTCONNECTION_H

#include <QObject>
#include <QQmlEngine>
#include <QString>
#include <QDebug>
#include <QTcpSocket>

class ClientConnection : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    Q_PROPERTY(QString messages READ messages WRITE setMessages NOTIFY messagesChanged)
    Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY messageChanged)
    Q_PROPERTY(bool isConnected READ isConnectedToHost NOTIFY isConnectedChanged)

    QString m_userName;
    QString m_messages;
    QString m_message;
    bool connectedToHost = false;
    QTcpSocket* socket;

    QString userName();
    QString messages();
    QString message();
    void setUserName(const QString &userName);
    void setMessages(const QString &messages);
    void setMessage(const QString &message);
    void printMessage(QString message);

public:
    explicit ClientConnection(QObject *parent = nullptr);

public slots:
    void on_connectButton_clicked();
    void on_sendButton_clicked();

    void socketConnected();
    void socketDisconnected();
    void socketReadyRead();
    bool isConnectedToHost();

signals:

    void userNameChanged();
    void messagesChanged();
    void isConnectedChanged();
    void messageChanged();

};

#endif // CLIENTCONNECTION_H
