import 'package:flutter/material.dart';
import 'package:whatsapp/screens/chat_list.dart';

class Home extends StatelessWidget {
  final _tabs = [
    Tab(icon: Icon(Icons.camera_alt)),
    Tab(text: 'CONVERSAS'),
    Tab(text: 'STATUS'),
    Tab(text: 'CHAMADAS'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("WhatsApp"),
            bottom: TabBar(
              tabs: _tabs,
              isScrollable: true,
            ),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
          body: TabBarView(
            children: [
              Text('Camera'),
              ChatList(),
              Text('Status'),
              Text('Chamadas'),
            ],
          ),
        ));
  }
}
