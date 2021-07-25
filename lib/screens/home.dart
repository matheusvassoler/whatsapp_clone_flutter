import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/bloc/chatlist/chat_list_cubit.dart';
import 'package:whatsapp/repository/inbox_repository.dart';
import 'package:whatsapp/screens/chat_list.dart';
import 'package:whatsapp/screens/contact_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _tabs = [
    Tab(icon: Icon(Icons.camera_alt)),
    Tab(text: 'CONVERSAS'),
    Tab(text: 'STATUS'),
    Tab(text: 'CHAMADAS'),
  ];

  TabController _tabController;
  bool showFab = true;
  bool isCallPage = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(initialIndex: 1, length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
        isCallPage = false;
      } else if(_tabController.index == 3) {
        showFab = true;
        isCallPage = true;
      } else {
        showFab = false;
        isCallPage = false;
      }
      setState(() {});
    });

  }

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
              controller: _tabController,
            ),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Text('Camera'),
              BlocProvider(
                  create: (context) => ChatListCubit(InboxRepository()),
                  child: ChatList(),
              ),
              Text('Status'),
              Text('Chamadas'),
            ],
          ),
          floatingActionButton: showFab ? FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ContactListContainer()
                )
              );
            },
            child: isCallPage? Icon(Icons.add_call, color: Colors.white,) : Icon(Icons.message, color: Colors.white,),
            heroTag: null,
          ) : null,
        ));
  }
}
