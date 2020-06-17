import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthNumberEntered extends AuthEvent {
  final String number;

  const AuthNumberEntered({@required this.number});

  @override
  List<Object> get props => [number];

  @override
  String toString() => 'AuthNumberEntered { phoneNumber :$number }';
}

class AuthSmsCodeEntered extends AuthEvent {
  final String code;

  const AuthSmsCodeEntered({@required this.code});

  @override
  List<Object> get props => [code];

  @override
  String toString() => 'AuthSmsCodeEntered { smsCode :$code }';
}

class AuthSuccess extends AuthEvent {}
class AuthFailed extends AuthEvent {}
