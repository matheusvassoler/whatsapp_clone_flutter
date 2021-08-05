import 'package:whatsapp/features/inbox_message/data/models/inbox_model.dart';

abstract class InboxLocalDataSource {
  Future<List<InboxModel>> getLastInboxes();
  Future<void> cacheInboxes(List<InboxModel> inboxesToCache);
}