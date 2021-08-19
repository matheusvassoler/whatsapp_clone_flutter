import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/core/usecases/usecase.dart';
import 'package:whatsapp/features/authentication/domain/entities/contact.dart';
import 'package:whatsapp/features/authentication/domain/repositories/auth_repository.dart';

class StoreContact implements UseCase<void, Params> {
  final AuthRepository _authRepository;

  StoreContact(this._authRepository);

  @override
  Future<Either<Failure, void>> call(params) async {
    final contact = Contact(
      phoneNumber: params.ddi+params.phoneNumber,
      name: params.name,
      picture: params.picture,
      deviceId: params.deviceId
    );
    return await _authRepository.storeContact(contact);
  }
}

class Params {
  final String ddi;
  final String phoneNumber;
  final String name;
  final String picture;
  final String deviceId;

  Params({
    @required this.ddi,
    @required this.phoneNumber,
    @required this.name,
    @required this.picture,
    @required this.deviceId
  });
}

