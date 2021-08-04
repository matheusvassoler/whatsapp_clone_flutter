import 'package:dartz/dartz.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/inbox_message/domain/entities/inbox.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}