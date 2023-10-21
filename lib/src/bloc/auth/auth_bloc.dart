import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthStatus authStatus = AuthStatus.checking;

  AuthBloc() : super(AuthInitial()) {
    on<AuthInitialEvent>((event, emit) => emit(AuthInitialState()));
  }
}
