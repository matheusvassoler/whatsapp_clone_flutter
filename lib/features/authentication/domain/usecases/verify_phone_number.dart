import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/core/usecases/usecase.dart';
import 'package:whatsapp/features/authentication/domain/repositories/auth_repository.dart';

class VerifyPhoneNumber implements UseCase<void, Params> {
  final AuthRepository _authRepository;

  VerifyPhoneNumber(this._authRepository);

  @override
  Future<Either<Failure, void>> call(params) async {
    final phoneNumber = params.ddi + params.phoneNumber;
    return await _authRepository.verifyPhoneNumber(phoneNumber);
  }
}

class Params {
  final String ddi;
  final String phoneNumber;

  Params({@required this.ddi, @required this.phoneNumber});
}