import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:whatsapp/bloc/message/message_cubit.dart';
import 'package:whatsapp/model/message.dart';
import 'package:whatsapp/repository/message_repository.dart';

class ChatRoomContainer extends StatelessWidget {
  final String _receiptContactName;
  final String _profileImage;
  final String _receiptNumber;

  ChatRoomContainer(this._receiptContactName, this._profileImage, this._receiptNumber);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MessageCubit(MessageRepository()),
        child: ChatRoomView(_receiptContactName, _profileImage, _receiptNumber),
    );
  }
}

class ChatRoomView extends StatefulWidget {
  final String _receiptContactName;
  final String _profileImage;
  final String _receiptNumber;

  ChatRoomView(this._receiptContactName, this._profileImage, this._receiptNumber);

  @override
  _ChatRoomViewState createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  final TextEditingController _txtMessageController = TextEditingController();
  StompClient stompClient;
  List<Message> messages = [];
  MessageCubit messageCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MessageCubit messageCubit = context.read<MessageCubit>();
  }

  @override
  void initState() {
    super.initState();
    stompClient = StompClient(
        config: StompConfig(
            url: 'ws://192.168.15.93:8080/socket',
            onConnect: (frame) {
              print("Success connection");
              stompClient.subscribe(destination: '/chat-room/1', callback: onMessageReceivedList);
              stompClient.subscribe(destination: '/chat-room/1/message', callback: onMessageReceived);
              stompClient.send(destination: "/chat-app/chat/1/addUser", headers: {"sender": "19111111111", "receipt": "19222222222"});
            },
            onWebSocketError: (dynamic error) => print(error.toString()),
            onWebSocketDone: () {
              print("Connection finished");
            }
        )
    );
    stompClient.activate();

    // stompClient.send(destination: "/chat-app/chat/1/addUser", headers: {"sender": "19111111111", "receipt": "19222222222"});
  }

  onMessageReceivedList(payload) {
    var teste = jsonDecode(payload.body);
    messages = (teste as List).map((item) => Message.fromJson(item)).toList();
    print(messages);
    print('hjhjjhjjhj');
    setState(() {

    });
  }

  onMessageReceived(payload) {
    var message = jsonDecode(payload.body);
    print(message);
    print('efdddf');
    setState(() {
      messages.insert(0, Message.fromJson(message));
    });
  }

  @override
  Widget build(BuildContext context) {
    //MessageCubit messageCubit = context.read<MessageCubit>();
    //messageCubit.getMessages(widget._receiptNumber);
    //messageCubit.teste(messages);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(widget._profileImage),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(widget._receiptContactName)
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/chat_room_background.png'),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ChatMessage(messages, index, widget._receiptNumber);
                        },
                        reverse: true,
                        itemCount: messages.length,
                      )
            ),
            _buildTextComposer(context, messageCubit, widget._receiptNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer(BuildContext context, MessageCubit messageCubit, String receiptNumber) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0 ),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _txtMessageController,
                      decoration:
                      InputDecoration.collapsed(hintText: 'Enviar mensagem'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Container(
              child: CircleAvatar(
                child: IconButton(
                    icon: Icon(Icons.send),
                    color: Colors.white,
                    onPressed: () => {
                      _handleSendMessageButton(messageCubit, _txtMessageController.text, "19111111111", widget._receiptNumber)
                    },
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSendMessageButton(MessageCubit messageCubit, String content, String senderNumber, String receiptNumber) {
      _txtMessageController.clear();
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data["content"] = content;
      data["senderNumber"] = senderNumber;
      data["receiptNumber"] = receiptNumber;
      final String messageJson = jsonEncode(data);
      //messageCubit.sendMessage(content, senderNumber, receiptNumber);
    stompClient.send(destination: '/chat-app/chat/1/sendMessage', headers: {}, body: messageJson);
    }

  @override
  void dispose() {
    super.dispose();
    stompClient.deactivate();
  }
}

class ChatMessage extends StatelessWidget {
  final List<Message> messages;
  final int index;
  final String receiptNumber;

  ChatMessage(this.messages, this.index, this.receiptNumber);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    var parseDate = DateTime.parse(messages[index].sendDate + 'Z');
    var formattedDate = DateFormat("HH:mm").format(parseDate.toLocal());
    var dateString = getLabelDateForGroupMessages(parseDate);

    return Column(
      children: [
        Container(
            child: dateString,
            margin: EdgeInsets.symmetric(vertical: dateString != null ? 15 : 0),
            decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFFdeeffe)
              ),
        ),
        Align(
          //Comparar telefone do sender com o telefone do receipt. Exemplo: messages[index].sender.phone == messages[index].receipt.phone
          alignment: (messages[index].sender.phone == receiptNumber ? Alignment.topLeft : Alignment.topRight),
          child: Container(
            margin: messages[index].sender.phone == receiptNumber ? EdgeInsets.only(top: 0, bottom: 0, right: 80.0, left: 20.0) : EdgeInsets.only(top: 0, bottom: 0, left: 80.0, right: 20.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Stack(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, right: 50),
                      child: Text(messages[index].content, style: TextStyle(fontSize: 15),),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Text(formattedDate, style: TextStyle(fontSize: 12, color: Colors.grey))
                    )
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              color: (messages[index].sender.phone == receiptNumber ? Colors.white : Color(0xFFDCF8C6)),
              elevation: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  getLabelDateForGroupMessages(DateTime date) {
    var actualMessageDate = DateFormat.yMd().format(date.toLocal());
    var dateString;

    if (messages.asMap().containsKey(index+1)) {
      var nextParseDate;
      nextParseDate = DateTime.parse(messages[index+1].sendDate + 'Z');
      var nextMessageDate = DateFormat.yMd().format(nextParseDate.toLocal());

      if(actualMessageDate.compareTo(nextMessageDate) != 0) {
        dateString = _checkIfMessageWasSentToday(actualMessageDate, dateString, date);
      } else {
        dateString = null;
      }
    } else {
      if (messages.length == 1) {
        var parseDate = DateTime.parse(messages[index].sendDate + 'Z');
        var actualMessageDate = DateFormat.yMd().format(parseDate.toLocal());

        dateString = _checkIfMessageWasSentToday(actualMessageDate, dateString, parseDate);
      } else {
        if (messages.length-1 == index) {
          var parseDate = DateTime.parse(messages[index-1].sendDate + 'Z');
          var actualMessageDate = DateFormat.yMd().format(parseDate.toLocal());

          var nextParseDate;
          nextParseDate = DateTime.parse(messages[index].sendDate + 'Z');
          var nextMessageDate = DateFormat.yMd().format(nextParseDate.toLocal());

          if(actualMessageDate.compareTo(nextMessageDate) != 0) {
            dateString = _checkIfMessageWasSentToday(nextMessageDate, dateString, nextParseDate);
          } else {
            dateString = _checkIfMessageWasSentToday(nextMessageDate, dateString, nextParseDate);
          }
        }
      }
    }
    return dateString;
  }

  _checkIfMessageWasSentToday(String actualMessageDate, Padding dateString, DateTime parseDate) {
    if(_isMessageSentToday(actualMessageDate)) {
      dateString = _todayDateLabelContainer();
    } else {
      dateString = _dateLabelContainer(parseDate);
    }
    return dateString;
  }

  bool _isMessageSentToday(String actualMessageDate) => actualMessageDate.compareTo(DateFormat.yMd().format(DateTime.now())) == 0;

  Padding _todayDateLabelContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Text("Hoje"),
    );
  }

  Padding _dateLabelContainer(DateTime date) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Text(DateFormat.E("pt_BR").format(date.toLocal()) + "., " + DateFormat.d("pt_BR").format(date.toLocal()) + " " + DateFormat.MMM("pt_BR").format(date.toLocal()))
    );
  }
}