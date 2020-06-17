import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/main.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  String verificationId;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event,) async* {
    if (event is AuthNumberEntered) {
      yield* _mapAuthSAuthNumberEnteredToState(event.number);
    }
  }

  Stream<AuthState> _mapAuthSAuthNumberEnteredToState(String number) async* {
    await verifyNumber(number);
  }

  Future<void> verifyNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult){
      auth.signInWithCredential(authResult);
    };
    final PhoneVerificationFailed failed = (AuthException authException){
      print(authException.message);
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResend]){
      this.verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verificationId){
      this.verificationId = verificationId;
    };

    await auth.verifyPhoneNumber(phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: failed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }
}
