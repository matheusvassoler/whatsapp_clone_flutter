import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/model/inbox.dart';
import 'package:whatsapp/repository/inbox_repository.dart';

part 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  final InboxRepository _inboxRepository;

  ChatListCubit(this._inboxRepository) : super(ChatListInitial());

  Future<void> getChatList() async {
    final chatList = await _inboxRepository.fetchInbox("19111111111");
    emit(ChatLoaded(chatList));
  }
}
