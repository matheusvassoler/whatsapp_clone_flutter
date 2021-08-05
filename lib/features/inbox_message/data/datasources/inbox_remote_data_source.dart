import 'package:whatsapp/features/inbox_message/data/models/inbox_model.dart';

abstract class InboxRemoteDataSource {
  Future<List<InboxModel>> getInboxes(String inboxOwnerNumber);
}