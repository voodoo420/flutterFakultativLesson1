import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/main.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String verificationId;

  @override
  AuthState get initialState => NumberCheckAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStarted) {
      yield* _mapAuthStartedToState();
    }
    if (event is AuthNumberEntered) {
      yield* _mapAuthNumberEnteredToState(event.number);
    }
    if (event is AuthSmsCodeEntered) {
      yield* _mapAuthSmsCodeEnteredToSate(event.code);
    }
  }

  Stream<AuthState> _mapAuthStartedToState() async* {
    yield NumberCheckAuthState();
  }

  Stream<AuthState> _mapAuthNumberEnteredToState(String number) async* {
    await _verifyNumber(number);
    yield SmsCheckAuthState();
  }

  Stream<AuthState> _mapAuthSmsCodeEnteredToSate(String code) async* {
    await verifySms(code);
    yield SuccessAuthState();
  }

  Future<void> _verifyNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      auth.signInWithCredential(authResult);
    };
    final PhoneVerificationFailed failed = (AuthException authException) {
      print(authException.message);
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResend]) {
      this.verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
    };

    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: failed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);

    auth.currentUser().then((value) => print(value.uid));
  }

  Future<void> verifySms(String code) async {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    await auth
        .signInWithCredential(authCredential)
        .then((value) => user = value.user);
    auth.currentUser().then((value) => print(value.photoUrl));
  }
}
