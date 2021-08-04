import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/model/message.dart';
import 'package:whatsapp/repository/message_repository.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessageRepository _messageRepository;

  MessageCubit(this._messageRepository) : super(MessageInitial());

  Future<void> getMessages(String receiptNumber) async {
    final messages = await _messageRepository.fetchMessagesBetweenTwoContacts("19111111111", receiptNumber);
    emit(MessageLoaded(messages));
  }

  Future<void> sendMessage(String content, String senderNumber, String receiptNumber) async {
    await _messageRepository.sendMessage(content, senderNumber, receiptNumber);
    getMessages(receiptNumber);
  }

  Future<void> teste(List<Message> messages) async {
    emit(MessageLoaded(messages));
  }
}
