import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is AuthNumberEntered){
      yield* _mapAuthSAuthNumberEnteredToState(event.number);
    }
  }

  Stream<AuthState>_mapAuthSAuthNumberEnteredToState(String number) async* {
    yield
  }
}
