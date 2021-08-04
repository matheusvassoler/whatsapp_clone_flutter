import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/inbox_message/domain/entities/inbox.dart';

abstract class InboxRepository {
  Future<Either<Failure, List<Inbox>>> getInboxes(String inboxOwnerNumber);
}