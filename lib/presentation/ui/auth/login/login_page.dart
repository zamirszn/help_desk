import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk/data/models/user_model.dart';
import 'package:helpdesk/presentation/widgets/snackbar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:helpdesk/core/constants/constant.dart';
import 'package:helpdesk/app/functions.dart';
import 'package:helpdesk/data/models/login_params_model.dart';
import 'package:helpdesk/presentation/resources/asset_manager.dart';
import 'package:helpdesk/core/config/theme/color_manager.dart';
import 'package:helpdesk/presentation/resources/font_manager.dart';
import 'package:helpdesk/presentation/resources/routes_manager.dart';
import 'package:helpdesk/presentation/resources/string_manager.dart';
import 'package:helpdesk/presentation/resources/styles_manager.dart';
import 'package:helpdesk/presentation/resources/values_manager.dart';
import 'package:helpdesk/presentation/ui/auth/login/bloc/login_bloc.dart';
import 'package:helpdesk/presentation/ui/auth/sign_up/sign_up_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: BlocProvider(
          create: (context) => LoginBloc(),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                showMessage(context, "Login Successful!");
                if (userModel != null &&
                    userModel!.userRole == Constant.admin) {
                  goPush(context, Routes.adminDashBoard);
                } else if (userModel != null &&
                    userModel!.userRole == Constant.support) {
                  goPush(context, Routes.supportPage);
                } else {
                  goPush(context, Routes.customerPage);
                }
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
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
                            AppStrings.helloWelcome,
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
                                  color: Colors.blue.shade100),
                              loop: true,
                            ),
                          ),
                          Center(
                              child: Text(
                            AppStrings.pleaseSignInHere,
                            style: getRegularStyle(
                                color: ColorManager.white,
                                font: FontConstants.poppins,
                                fontSize: FontSize.s16),
                          )),
                          space(h: AppSize.s20),
                          BlocBuilder<LoginBloc, LoginState>(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        space(h: AppSize.s40),
                                        Text(
                                          AppStrings.emailAddress,
                                          style: getSemiBoldStyle(
                                              color: ColorManager.black,
                                              font: FontConstants.ojuju,
                                              fontSize: FontSize.s16),
                                        ),
                                        space(h: AppSize.s10),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: TextFormField(
                                              validator: (value) {
                                                return emailNameValidator(
                                                    value);
                                              },
                                              controller: emailController,
                                              autofillHints: const [
                                                AutofillHints.email
                                              ],
                                              onChanged: (value) {
                                                context.read<LoginBloc>().add(
                                                    UsernameChanged(value));
                                              },
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    Constant.emailNameLength),
                                              ],
                                              decoration: InputDecoration(
                                                prefixIcon:
                                                    const Icon(Iconsax.sms),
                                                border: noOutlineInput,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical:
                                                            AppPadding.p14),
                                                focusedBorder: noOutlineInput,
                                                enabledBorder: noOutlineInput,
                                                errorBorder: noOutlineInput,
                                                disabledBorder: noOutlineInput,
                                                focusedErrorBorder:
                                                    noOutlineInput,
                                                filled: true,
                                                fillColor:
                                                    Colors.blue.withOpacity(.1),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: TextFormField(
                                              obscureText:
                                                  state is LoginFormUpdate
                                                      ? state.isPasswordValid
                                                      : false,
                                              validator: (value) {
                                                return passwordValidator(value);
                                              },
                                              controller: passwordController,
                                              autofillHints: const [
                                                AutofillHints.password
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
                                                    context.read<LoginBloc>().add(
                                                        TogglePasswordVisibility(
                                                            isPasswordVisible: state
                                                                is! LoginTogglePassword));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Icon(
                                                      (state is LoginFormUpdate &&
                                                              state
                                                                  .isPasswordVisible)
                                                          ? Iconsax.eye
                                                          : Iconsax.eye_slash,
                                                    ),
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical:
                                                            AppPadding.p14),
                                                border: noOutlineInput,
                                                focusedBorder: noOutlineInput,
                                                enabledBorder: noOutlineInput,
                                                errorBorder: noOutlineInput,
                                                disabledBorder: noOutlineInput,
                                                focusedErrorBorder:
                                                    noOutlineInput,
                                                filled: true,
                                                fillColor:
                                                    Colors.blue.withOpacity(.1),
                                              )),
                                        ),
                                        space(h: AppSize.s40),
                                        SizedBox(
                                          height: AppSize.s50,
                                          child: BlocBuilder<LoginBloc,
                                              LoginState>(
                                            builder: (context, state) {
                                              if (state is LoginLoading) {
                                                return const ButtonLoadingWidget();
                                              }
                                              return ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              Colors.blue),
                                                  onPressed: () {
                                                    if (formKey.currentState
                                                            ?.validate() ??
                                                        false) {
                                                      context
                                                          .read<LoginBloc>()
                                                          .add(LoginSubmitted(
                                                              params: LoginParamsModel(
                                                                  email:
                                                                      emailController
                                                                          .text,
                                                                  password:
                                                                      passwordController
                                                                          .text)));
                                                    }
                                                  },
                                                  child: Text(
                                                    AppStrings.logIn,
                                                    style: getSemiBoldStyle(
                                                        color:
                                                            ColorManager.white),
                                                  ));
                                            },
                                          ),
                                        ),
                                        space(h: AppSize.s20),
                                        GestureDetector(
                                          onTap: () =>
                                              goto(context, Routes.signUpPage),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                  AppStrings.needAnAccount),
                                              space(w: AppSize.s4),
                                              Text(
                                                AppStrings.signUp,
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
                            },
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ));
  }
}
