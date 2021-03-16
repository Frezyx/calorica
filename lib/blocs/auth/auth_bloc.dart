import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:calory_calc/blocs/auth/bloc.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/common/utils/userDietSelector.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoading());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoadAuthorization) {
      yield* _mapLoadAuthorizationToState(event);
    } else if (event is Authorize) {
      yield* _mapAuthorizeToState(event);
    }
  }

  Stream<AuthState> _mapAuthorizeToState(Authorize event) async* {
    try {
      await DBUserProvider.db.addUser(event.user);
      yield Authorized(event.user);
      await DietSelector.slectUserDiet();
    } on Exception catch (e) {
      yield Unauthorized();
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
    } on Exception catch (_) {
      yield Unauthorized();
    }
  }
}
