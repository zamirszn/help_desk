import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/app/functions.dart';
import 'package:helpdesk/core/constants/constant.dart';
import 'package:helpdesk/data/models/login_params_model.dart';
import 'package:helpdesk/data/models/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    emit(LoginTogglePassword(isPasswordVisible: event.isPasswordVisible));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    // Either response = await sl<LogInUseCase>().call(params: event.params);
    // response.fold((error) {
    //   emit(LoginFailure(error));
    // }, (data) {
    //   emit(LoginSuccess());
    // });

    if (event.params.email == "mubaraklawal52@gmail.com") {
      // admin
      userModel = UserModel(
          email: event.params.email, fullName: null, userRole: Constant.admin);
    } else if (event.params.email == "support@gmail.com") {
      // support
      userModel = UserModel(
          email: event.params.email,
          fullName: null,
          userRole: Constant.support);
    } else {
      // normal user
      userModel = UserModel(
          email: event.params.email, fullName: null, userRole: Constant.user);
    }

    emit(LoginSuccess());
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<LoginState> emit) {
    final isUsernameValid = validateUsername(event.username);
    final currentState = state;

    if (currentState is LoginInitial || currentState is LoginFormUpdate) {
      emit(LoginFormUpdate(
        isUsernameValid: isUsernameValid,
        isPasswordValid: (currentState is LoginFormUpdate)
            ? currentState.isPasswordValid
            : true,
        isPasswordVisible: (currentState is LoginFormUpdate)
            ? currentState.isPasswordVisible
            : false,
      ));
    }
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final isPasswordValid = validatePassword(event.password);
    final currentState = state;

    if (currentState is LoginInitial || currentState is LoginFormUpdate) {
      emit(LoginFormUpdate(
        isUsernameValid: (currentState is LoginFormUpdate)
            ? currentState.isUsernameValid
            : true,
        isPasswordValid: isPasswordValid,
        isPasswordVisible: (currentState is LoginFormUpdate)
            ? currentState.isPasswordVisible
            : false,
      ));
    }
  }
}
