import 'package:flutter/material.dart';
import 'package:whatsapp/bloc/contactlist/contact_list_cubit.dart';
import 'package:whatsapp/repository/contact_repository.dart';
import 'package:whatsapp/screens/chat_room.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactListCubit(ContactRepository()),
      child: ContactListView(),
    );
  }
}

class ContactListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactListCubit chatListCubit = context.read<ContactListCubit>();
    chatListCubit.getContactList();
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
      body: BlocBuilder<ContactListCubit, ContactListState>(
        builder: (context, state) {
          if (state is ContactListLoaded) {
            return ListView.builder(itemCount: state.contactList.length, itemBuilder: (context, index) {
              return InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 12.0, left: 15.0),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(state.contactList[index].picture)
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          state.contactList[index].name,
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
                      MaterialPageRoute(builder: (context) => ChatRoomContainer(state.contactList[index].name, state.contactList[index].picture, state.contactList[index].phone))
                  );
                },
              );
            });
          } else {
            return Text("Carregando");
          }
        },
      ),
    );
  }
}
