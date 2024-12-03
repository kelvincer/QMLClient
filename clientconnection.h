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

    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    QML_ELEMENT
    Q_PROPERTY(QString messages READ messages WRITE setMessages NOTIFY messagesChanged)

public:
    explicit ClientConnection(QObject *parent = nullptr);

    QString userName();
    QString messages();
    void setUserName(const QString &userName);
    void setMessages(const QString &messages);
    void printMessage(QString message);

public slots:
    void on_connectButton_clicked();
    void on_sendButton_clicked();

    void socketConnected();
    void socketDisconnected();
    void socketReadyRead();

signals:

    void userNameChanged();
    void messagesChanged();

private:
    QString m_userName;
    QString m_messages;
    bool connectedToHost = false;
    QTcpSocket* socket;
};

#endif // CLIENTCONNECTION_H
