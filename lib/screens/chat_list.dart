import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/bloc/chatlist/chat_list_cubit.dart';
import 'package:whatsapp/screens/chat_room.dart';

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListCubit, ChatListState>(
      builder: (context, state) {
        if (state is ChatLoaded) {
          return ListView.builder(itemCount: state.chatList.length, itemBuilder: (context, index) {
            var parseDate = DateTime.parse(state.chatList[index].dateOfLastMessage + 'Z');
            var dateOfLastMessage = DateFormat.yMd().format(parseDate.toLocal());
            var formattedDate;
            if(dateOfLastMessage.compareTo(DateFormat.yMd().format(DateTime.now())) == 0) {
              formattedDate = DateFormat("HH:mm").format(parseDate.toLocal());
            } else {
              formattedDate = DateFormat("dd/MM/yyyy").format(parseDate.toLocal());
            }
            return Column(
              children: [
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(top: 13.0, left: 10.0, right: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                              width: 50,
                              height: 50,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new NetworkImage(state.chatList[index].picture)
                                  )
                              )),
                        ),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.chatList[index].receiptName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Text(
                                        formattedDate,
                                        //newFormat.format(parseDate.toLocal()),
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.0, bottom: 12.0),
                                    child: Text(
                                      state.chatList[index].lastMessage,
                                      style: TextStyle(color: Colors.black45, fontSize: 16.0),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Divider(height: 1,)
                                ],
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChatRoomContainer(state.chatList[index].receiptName, state.chatList[index].picture, state.chatList[index].receiptNumber))
                      );
                    }
                ),
              ],
            );
          });
        } else {
          return Container();
        }
      }
    );
  }
}