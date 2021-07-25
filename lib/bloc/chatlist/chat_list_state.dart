part of 'chat_list_cubit.dart';

@immutable
abstract class ChatListState {}

class ChatListInitial extends ChatListState {}

class ChatLoaded extends ChatListState {
  final List<Inbox> chatList;

  ChatLoaded(this.chatList);
}
