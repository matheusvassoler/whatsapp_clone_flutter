import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:whatsapp/core/error/failure.dart';
import 'package:whatsapp/features/authentication/domain/usecases/verify_phone_number.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final VerifyPhoneNumber _verifyPhoneNumber;

  AuthenticationCubit(this._verifyPhoneNumber) : super(Empty());

  Future<void> sendSmsCode(String ddi, String phoneNumber) async {
    emit(Loading());
    final failureOrSuccess = await _verifyPhoneNumber(Params(ddi: ddi, phoneNumber: phoneNumber));
    failureOrSuccess.fold(
      (failure) => emit(Error(failure: failure)),
      (success) => emit(SmsCodeSent())
    );
  }
}
