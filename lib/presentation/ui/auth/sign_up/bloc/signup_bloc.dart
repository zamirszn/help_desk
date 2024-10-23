import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk/app/functions.dart';
import 'package:helpdesk/core/constants/constant.dart';
import 'package:helpdesk/data/models/signup_params_model.dart';
import 'package:helpdesk/data/models/user_model.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<FullNameChanged>(_onFullNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  void _onFullNameChanged(FullNameChanged event, Emitter<SignUpState> emit) {
    final isFullNameValid = validateFullName(event.fullName);
    final currentState = state;

    if (currentState is SignUpInitial || currentState is SignUpFormUpdate) {
      emit(SignUpFormUpdate(
        isFullNameValid: isFullNameValid,
        isEmailValid: (currentState is SignUpFormUpdate)
            ? currentState.isEmailValid
            : true,
        isPasswordValid: (currentState is SignUpFormUpdate)
            ? currentState.isPasswordValid
            : true,
      ));
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    final isEmailValid = validateEmail(event.email);
    final currentState = state;

    if (currentState is SignUpInitial || currentState is SignUpFormUpdate) {
      emit(SignUpFormUpdate(
        isFullNameValid: (currentState is SignUpFormUpdate)
            ? currentState.isFullNameValid
            : true,
        isEmailValid: isEmailValid,
        isPasswordValid: (currentState is SignUpFormUpdate)
            ? currentState.isPasswordValid
            : true,
      ));
    }
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    final isPasswordValid = validatePassword(event.password);
    final currentState = state;

    if (currentState is SignUpInitial || currentState is SignUpFormUpdate) {
      emit(SignUpFormUpdate(
        isFullNameValid: (currentState is SignUpFormUpdate)
            ? currentState.isFullNameValid
            : true,
        isEmailValid: (currentState is SignUpFormUpdate)
            ? currentState.isEmailValid
            : true,
        isPasswordValid: isPasswordValid,
      ));
    }
  }

  void _onSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());

    // Either response = await sl<SignupUseCase>().call(params: event.params);

    // response.fold((error) {
    //   emit(SignUpFailure(error));
    // }, (data) {
    //   emit(SignUpSuccess());

    // });
    // do fake auth here
    if (event.params.email == "mubaraklawal52@gmail.com") {
      // admin
      userModel = UserModel(
          email: event.params.email,
          fullName: event.params.fullName,
          userRole: Constant.admin);
    } else if (event.params.email == "support@gmail.com") {
      // support
      userModel = UserModel(
          email: event.params.email,
          fullName: event.params.fullName,
          userRole: Constant.support);
    } else {
      // normal user
      userModel = UserModel(
          email: event.params.email,
          fullName: event.params.fullName,
          userRole: Constant.user);
    }
    emit(SignUpSuccess());
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<SignUpState> emit) {
    emit(SignUpTogglePassword(isPasswordVisible: event.isPasswordVisible));
  }
}
