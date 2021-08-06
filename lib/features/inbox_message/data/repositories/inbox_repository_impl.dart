import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/core/error/exceptions.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/core/network/network_info.dart';
import 'package:whatsapp/features/inbox_message/data/datasources/inbox_local_data_source.dart';
import 'package:whatsapp/features/inbox_message/data/datasources/inbox_remote_data_source.dart';
import 'package:whatsapp/features/inbox_message/domain/entities/inbox.dart';
import 'package:whatsapp/features/inbox_message/domain/repositories/inbox_repository.dart';

typedef Future<List<Inbox>> _Inboxes();

class InboxRepositoryImpl implements InboxRepository {
  final InboxRemoteDataSource remoteDataSource;
  final InboxLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  InboxRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failure, List<Inbox>>> getInboxes(String inboxOwnerNumber) async {
    return await _getInboxes(() {
      return remoteDataSource.getInboxes(inboxOwnerNumber);
    });
  }

  Future<Either<Failure, List<Inbox>>> _getInboxes(_Inboxes getInboxes) async {
    if(await networkInfo.isConnected) {
      try {
        final remoteInboxes = await getInboxes();
        localDataSource.cacheInboxes(remoteInboxes);
        return Right(remoteInboxes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localInboxes = await localDataSource.getLastInboxes();
        return Right(localInboxes);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}