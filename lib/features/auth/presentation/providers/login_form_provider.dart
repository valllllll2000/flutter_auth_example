import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';

import '../../../shared/infrastructure/inputs/inputs.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final Future<void> Function(String email, String password) loginUserCallback =
      ref.watch(authProvider.notifier).loginUser;
  return LoginFormNotifier(loginUserCallback: loginUserCallback);
});

class LoginFormState {
  final bool isPosting;
  final bool isPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState(
      {this.isPosting = false,
      this.isPosted = false,
      this.isValid = false,
      this.email = const Email.pure(),
      this.password = const Password.pure()});

  LoginFormState copyWith(
          {bool? isPosting,
          bool? isPosted,
          bool? isValid,
          Email? email,
          Password? password}) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isPosted: isPosted ?? this.isPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  String toString() {
    return '''
    LoginFormState:
         isPosting: $isPosting 
         isPosted: $isPosted 
         isValid: $isValid
         email: $email
         password: $password
    ''';
  }
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;

  LoginFormNotifier({required this.loginUserCallback})
      : super(LoginFormState());

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        isValid: Formz.validate([newEmail, state.password]), email: newEmail);
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        isValid: Formz.validate([newPassword, state.email]),
        password: newPassword);
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    print(state);
    await loginUserCallback(state.email.value, state.password.value);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
        isPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]));
  }
}
