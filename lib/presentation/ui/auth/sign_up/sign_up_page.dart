import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:blobs/blobs.dart';
import 'package:flutter/services.dart';
import 'package:helpdesk/data/models/user_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:helpdesk/presentation/ui/auth/sign_up/bloc/signup_bloc.dart';
import 'package:helpdesk/presentation/widgets/loading_widget.dart';
import 'package:helpdesk/core/constants/constant.dart';
import 'package:helpdesk/app/functions.dart';
import 'package:helpdesk/data/models/signup_params_model.dart';
import 'package:helpdesk/presentation/resources/asset_manager.dart';
import 'package:helpdesk/core/config/theme/color_manager.dart';
import 'package:helpdesk/presentation/resources/font_manager.dart';
import 'package:helpdesk/presentation/resources/routes_manager.dart';
import 'package:helpdesk/presentation/resources/string_manager.dart';
import 'package:helpdesk/presentation/resources/styles_manager.dart';
import 'package:helpdesk/presentation/resources/values_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk/presentation/widgets/snackbar.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final emailController = TextEditingController(
      text: kDebugMode ? "mubaraklawal52@gmail.com" : null);
  final fullNameController =
      TextEditingController(text: kDebugMode ? "Mubarak Lawal" : null);
  final passwordController =
      TextEditingController(text: kDebugMode ? "StrongPassword52#" : null);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) => SignUpBloc(),
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              showMessage(context, AppStrings.signUpSuccessful);
              if (userModel != null && userModel!.userRole == Constant.admin) {
                goPush(context, Routes.adminDashBoard);
              } else if (userModel != null &&
                  userModel!.userRole == Constant.support) {
                goPush(context, Routes.supportPage);
              } else {
                goPush(context, Routes.customerPage);
              }
            } else if (state is SignUpFailure) {
              showErrorMessage(context, state.error);
            }
          },
          child: Form(
            key: formKey,
            child: ColoredBox(
              color: Colors.blue,
              child: SizedBox(
                height: deviceHeight(context),
                width: deviceWidth(context),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    space(h: AppSize.s80),
                    Center(
                        child: Text(
                      AppStrings.letsGetStarted,
                      textAlign: TextAlign.center,
                      style: getBoldStyle(
                          color: ColorManager.white,
                          font: FontConstants.ojuju,
                          fontSize: FontSize.s35),
                    )),
                    Center(
                      child: Blob.animatedFromID(
                        id: Constant.blob,
                        duration: const Duration(seconds: 4),
                        size: 300,
                        styles: BlobStyles(
                            fillType: BlobFillType.fill,
                            color: Colors.cyan.shade100),
                        loop: true,
                      ),
                    ),
                    Center(
                        child: Text(
                      AppStrings.pleaseSignUpHere,
                      style: getRegularStyle(
                          color: ColorManager.white,
                          font: FontConstants.poppins,
                          fontSize: FontSize.s16),
                    )),
                    space(h: AppSize.s20),
                    BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(AppSize.s20),
                            topRight: Radius.circular(AppSize.s20)),
                        child: ColoredBox(
                          color: ColorManager.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                space(h: AppSize.s40),
                                Text(
                                  AppStrings.fullName,
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black,
                                      font: FontConstants.ojuju,
                                      fontSize: FontSize.s16),
                                ),
                                space(h: AppSize.s10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TextFormField(
                                      validator: (value) {
                                        return nameValidator(value);
                                      },
                                      onChanged: (value) => context
                                          .read<SignUpBloc>()
                                          .add(FullNameChanged(value)),
                                      controller: fullNameController,
                                      autofillHints: const [AutofillHints.name],
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                            Constant.nameLength),
                                      ],
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Iconsax.user),
                                        border: noOutlineInput,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: AppPadding.p14),
                                        focusedBorder: noOutlineInput,
                                        enabledBorder: noOutlineInput,
                                        errorBorder: noOutlineInput,
                                        disabledBorder: noOutlineInput,
                                        focusedErrorBorder: noOutlineInput,
                                        filled: true,
                                        fillColor: Colors.blue.withOpacity(.1),
                                      )),
                                ),
                                space(h: AppSize.s20),
                                Text(
                                  AppStrings.emailAddress,
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black,
                                      font: FontConstants.ojuju,
                                      fontSize: FontSize.s16),
                                ),
                                space(h: AppSize.s10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TextFormField(
                                      validator: (value) {
                                        return emailNameValidator(value);
                                      },
                                      onChanged: (value) => context
                                          .read<SignUpBloc>()
                                          .add(EmailChanged(value)),
                                      controller: emailController,
                                      autofillHints: const [
                                        AutofillHints.email
                                      ],
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                            Constant.emailNameLength),
                                      ],
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Iconsax.sms),
                                        border: noOutlineInput,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: AppPadding.p14),
                                        focusedBorder: noOutlineInput,
                                        enabledBorder: noOutlineInput,
                                        errorBorder: noOutlineInput,
                                        disabledBorder: noOutlineInput,
                                        focusedErrorBorder: noOutlineInput,
                                        filled: true,
                                        fillColor: Colors.blue.withOpacity(.1),
                                      )),
                                ),
                                //
                                // password
                                space(h: AppSize.s20),
                                Text(
                                  AppStrings.password,
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black,
                                      font: FontConstants.ojuju,
                                      fontSize: FontSize.s16),
                                ),
                                space(h: AppSize.s10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: TextFormField(
                                      onChanged: (value) => context
                                          .read<SignUpBloc>()
                                          .add(PasswordChanged(value)),
                                      obscureText: state is SignUpTogglePassword
                                          ? state.isPasswordVisible
                                          : false,
                                      validator: (value) {
                                        return passwordValidator(value);
                                      },
                                      controller: passwordController,
                                      autofillHints: const [
                                        AutofillHints.newPassword
                                      ],
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                            Constant.passwordLength),
                                      ],
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Iconsax.lock,
                                        ),
                                        suffix: GestureDetector(
                                          onTap: () {
                                            context.read<SignUpBloc>().add(
                                                TogglePasswordVisibility(
                                                    isPasswordVisible: state
                                                        is! SignUpTogglePassword));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                              (state is SignUpTogglePassword &&
                                                      state.isPasswordVisible)
                                                  ? Iconsax.eye
                                                  : Iconsax.eye_slash,
                                            ),
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: AppPadding.p14),
                                        border: noOutlineInput,
                                        focusedBorder: noOutlineInput,
                                        enabledBorder: noOutlineInput,
                                        errorBorder: noOutlineInput,
                                        disabledBorder: noOutlineInput,
                                        focusedErrorBorder: noOutlineInput,
                                        filled: true,
                                        fillColor: Colors.blue.withOpacity(.1),
                                      )),
                                ),
                                space(h: AppSize.s40),
                                SizedBox(
                                  height: AppSize.s50,
                                  child: BlocBuilder<SignUpBloc, SignUpState>(
                                    builder: (context, state) {
                                      if (state is SignUpLoading) {
                                        return const ButtonLoadingWidget();
                                      }

                                      return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Colors.blue),
                                          onPressed: () {
                                            if (formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              context
                                                  .read<SignUpBloc>()
                                                  .add(SignUpSubmitted(
                                                      params: SignupParamsModel(
                                                    fullName:
                                                        fullNameController.text,
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                  )));
                                            }
                                          },
                                          child: Text(
                                            AppStrings.signUp,
                                            style: getSemiBoldStyle(
                                                color: ColorManager.white),
                                          ));
                                    },
                                  ),
                                ),
                                space(h: AppSize.s20),
                                GestureDetector(
                                  onTap: () => goto(context, Routes.loginPage),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                          AppStrings.alreadyHaveAnAccount),
                                      space(w: AppSize.s4),
                                      Text(
                                        AppStrings.logIn,
                                        style: getSemiBoldStyle(
                                            fontSize: FontSize.s14,
                                            color: ColorManager.black),
                                      ),
                                    ],
                                  ),
                                ),

                                space(h: AppSize.s40),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonLoadingWidget extends StatelessWidget {
  const ButtonLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0, backgroundColor: ColorManager.color2),
        onPressed: null,
        child: const LoadingWidget());
  }
}
