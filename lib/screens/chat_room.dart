import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final List<ChatMessage> _messages = [
    ChatMessage(Message("Oi", true)),
    ChatMessage(Message("Bom dia", true))
  ];
  final TextEditingController _txtMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(           // <-- avatar here instead
              child: Text("A"),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text("Contato")
          ],
        ),
//        leading: IconButton(
//          icon: Icon(Icons.arrow_back_ios),
//          onPressed: () {},
//        ),
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
                      return _messages[index];
                    },
                  reverse: true,
                  itemCount: _messages.length,
                )
            ),
            _buildTextComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
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
                  onPressed: () => {_handleSendMessageButton(Message(_txtMessageController.text, false))},
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSendMessageButton(Message message) {
    _txtMessageController.clear();
    setState(() {
      _messages.add(ChatMessage(message));
    });
  }
}

class ChatMessage extends StatelessWidget {
  final Message message;

  ChatMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Align(
        alignment: (!message.isRecipient ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          margin: !message.isRecipient ? EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0, left: 20.0) : EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0, right: 20.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(message.text, style: TextStyle(fontSize: 15),),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: (!message.isRecipient ? Colors.white : Color(0xFFDCF8C6))
              ),
          ),
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final bool isRecipient;

  Message(this.text, this.isRecipient);
}
