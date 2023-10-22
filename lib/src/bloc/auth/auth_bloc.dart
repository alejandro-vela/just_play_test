import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/firebase_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthStatus authStatus = AuthStatus.checking;
  User? user = FirebaseAuth.instance.currentUser;

  AuthBloc() : super(AuthInitial()) {
    on<AuthInitialEvent>((event, emit) => emit(AuthInitialState()));
    on<AuthValidateEvent>(_validate);
    on<AuthLoginEvent>(_logIn);
  }

  void _validate(AuthValidateEvent event, Emitter<AuthState> emit) async {
    if (user != null) {
      emit(AuthAuthenticatedState());
    } else {
      emit(AuthNoAuthenticatedState());
    }
  }

  void _logIn(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitialState());
    try {
      final AuthFirebaseCustom authFirebaseCustom = AuthFirebaseCustom();

      final User? result = await authFirebaseCustom.signInWithGoogle();

      if (result != null) {
        user = result;
        // Get function to get the token of the user
        //result.getIdToken().then((value) => print(value));
        emit(AuthAuthenticatedState());
      } else {
        emit(AuthFinishWithError(
          error: 'Upps! Algo salió mal',
        ));
      }
    } catch (e) {
      emit(AuthFinishWithError(
        error: 'Upps! Algo salió mal',
      ));
    }
  }
}
