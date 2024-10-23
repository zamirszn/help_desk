part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class UsernameChanged extends LoginEvent {
  final String username;
  UsernameChanged(this.username);
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {
  final LoginParamsModel params;

  LoginSubmitted({required this.params});
}

class TogglePasswordVisibility extends LoginEvent {
  final bool isPasswordVisible;

  TogglePasswordVisibility({required this.isPasswordVisible});
}
