import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/core/usecases/usecase.dart';
import 'package:whatsapp/features/inbox_message/domain/entities/inbox.dart';
import 'package:whatsapp/features/inbox_message/domain/repositories/inbox_repository.dart';

class GetInboxes implements UseCase<List<Inbox>, Params> {
  final InboxRepository repository;

  GetInboxes(this.repository);

  @override
  Future<Either<Failure, List<Inbox>>> call(
    Params params
  ) async {
    return await repository.getInboxes(params.inboxOwnerNumber);
  }
}

class Params {
  final String inboxOwnerNumber;

  Params({@required this.inboxOwnerNumber});
}