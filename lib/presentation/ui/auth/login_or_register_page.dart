import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:helpdesk/app/functions.dart';
import 'package:helpdesk/core/constants/constant.dart';
import 'package:helpdesk/presentation/resources/asset_manager.dart';
import 'package:helpdesk/core/config/theme/color_manager.dart';
import 'package:helpdesk/presentation/resources/font_manager.dart';
import 'package:helpdesk/presentation/resources/routes_manager.dart';
import 'package:helpdesk/presentation/resources/string_manager.dart';
import 'package:helpdesk/presentation/resources/styles_manager.dart';
import 'package:helpdesk/presentation/resources/values_manager.dart';
import 'package:helpdesk/presentation/widgets/round_icon_text_button.dart';

class LoginOrRegisterPage extends StatelessWidget {
  const LoginOrRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ColoredBox(
        color: Colors.lightBlue,
        child: SizedBox(
          height: deviceHeight(context),
          width: deviceWidth(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Blob.animatedFromID(
                      id: Constant.blob,
                      duration: const Duration(seconds: 4),
                      size: 350,
                      styles: BlobStyles(
                          fillType: BlobFillType.fill,
                          color: ColorManager.white),
                      loop: true,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Organize, Prioritize, Succeed",
                          style: getSemiBoldStyle(
                              color: ColorManager.white,
                              font: FontConstants.ojuju,
                              fontSize: FontSize.s30),
                        ),
                        space(h: AppSize.s20),
                        Text(
                          "Resolve issues faster with a streamlined ticketing system",
                          style: getRegularStyle(
                              fontSize: FontSize.s14,
                              color: ColorManager.white,
                              font: FontConstants.poppins),
                        ),
                      ],
                    ),
                  ),
                  space(h: AppSize.s100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundIconTextButton(
                        bgColor: ColorManager.white,
                        textColor: Colors.lightBlue,
                        iconColor: ColorManager.white,
                        text: AppStrings.logIn,
                        onPressed: () {
                          goPush(context, Routes.loginPage);
                        },
                        iconData: Iconsax.key,
                      ),
                      RoundIconTextButton(
                        iconAlignment: IconAlignment.end,
                        bgColor: ColorManager.white,
                        textColor: Colors.lightBlue,
                        iconColor: ColorManager.white,
                        text: AppStrings.register,
                        onPressed: () {
                          goPush(context, Routes.signUpPage);
                        },
                        iconData: Iconsax.user,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
