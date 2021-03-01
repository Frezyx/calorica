import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:calory_calc/blocs/auth/bloc.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoading());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoadAuthorization) {
      yield* _mapLoadAuthorizationToState(event);
    }
  }

  Stream<AuthState> _mapLoadAuthorizationToState(
      LoadAuthorization event) async* {
    try {
      final user = await DBUserProvider.db.getUser();
      if (user != null) {
        yield Authorized(user);
      } else {
        yield Unauthorized();
      }
    } on Exception catch (e) {
      yield Unauthorized();
    }
  }
}
