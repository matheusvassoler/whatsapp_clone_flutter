import 'package:flutter/material.dart';
import 'package:whatsapp/screens/chat_room.dart';

class ContactList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        actions: [
          IconButton(
              onPressed: () => {},
              icon: Icon(Icons.search)
          ),
          IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 15.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260")
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                      "Contato $index",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                      ),
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChatRoom())
            );
          },
        );
      }),
    );
  }
}
