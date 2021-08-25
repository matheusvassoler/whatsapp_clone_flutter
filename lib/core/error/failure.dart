import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}
class AuthenticationFailure extends Failure {}
class InvalidPhoneFailure extends Failure {}
class SignOutFailure extends Failure {}
class DatasourceFailure extends Failure {}
class InternalFailure extends Failure {}