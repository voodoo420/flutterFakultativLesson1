import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class NumberCheckAuthState extends AuthState {}

class SmsCheckAuthState extends AuthState {}

class SuccessAuthState extends AuthState {
//  final FirebaseUser user;
//
//  const SuccessAuthState(this.user);
//
//  @override
//  List<Object> get props => [user];
//
//  @override
//  String toString() => 'AuthenticationSuccess { userInstance: $user }';
}

class FailureAuthState extends AuthState {}
