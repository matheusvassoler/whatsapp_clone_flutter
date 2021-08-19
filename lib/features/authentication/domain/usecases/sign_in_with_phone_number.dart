import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/core/usecases/usecase.dart';
import 'package:whatsapp/features/authentication/domain/repositories/auth_repository.dart';

class SignInWithPhoneNumber implements UseCase<void, Params> {
  final AuthRepository _authRepository;

  SignInWithPhoneNumber(this._authRepository);

  @override
  Future<Either<Failure, void>> call(params) async {
    final signResult = await _authRepository.signInWithPhoneNumber(params.smsCode);
    return signResult.fold(
      (failure) {
        return Left(failure);
      },
      (success) async {
        return await _authRepository.signOut();
      }
    );
  }
}

class Params {
  final String smsCode;

  Params({@required this.smsCode});
}