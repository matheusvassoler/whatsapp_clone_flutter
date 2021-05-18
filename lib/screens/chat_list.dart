import 'package:flutter/material.dart';
import 'package:whatsapp/screens/chat_room.dart';

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Container(
        child: GestureDetector(
          child: ListTile(
            title: Text('Contato $index'),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ChatRoom())
            );
          }
        ),
      );
    });
  }
}
