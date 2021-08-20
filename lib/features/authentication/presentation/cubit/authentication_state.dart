part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends AuthenticationState {}

class Loading extends AuthenticationState {}

class SmsCodeSent extends AuthenticationState {}

class Error extends AuthenticationState {
  final Failure failure;

  Error({@required this.failure});

  @override
  List<Object> get props => [failure];
}
