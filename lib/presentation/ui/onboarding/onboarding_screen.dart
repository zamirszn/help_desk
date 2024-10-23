import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/core/constants/constant.dart';
import 'package:helpdesk/presentation/resources/asset_manager.dart';
import 'package:helpdesk/core/config/theme/color_manager.dart';
import 'package:helpdesk/presentation/resources/routes_manager.dart';
import 'package:helpdesk/presentation/resources/string_manager.dart';
import 'package:helpdesk/presentation/ui/onboarding/liquid_card_swipe.dart';
import 'package:helpdesk/presentation/ui/onboarding/liquid_swipe_view.dart';

class LiquidSwipeOnboarding extends StatefulWidget {
  const LiquidSwipeOnboarding({super.key});

  @override
  State<LiquidSwipeOnboarding> createState() => _LiquidSwipeOnboardingState();
}

class _LiquidSwipeOnboardingState extends State<LiquidSwipeOnboarding> {
  final _key = GlobalKey<LiquidSwipeState>();

  LiquidSwipeState? get liquidSwipeController => _key.currentState;

  @override
  void initState() {
    resetAnim();
    super.initState();
  }

  resetAnim() async {
    Future.delayed(const Duration(milliseconds: 50)).then(
      (value) => liquidSwipeController?.previous(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        key: _key,
        children: [
          /// First page
          LiquidSwipeCard(
            useCustomWidget: true,
            customWidget: Center(
              child: Blob.animatedFromID(
                id: Constant.blob,
                duration: const Duration(seconds: 4),
                size: 350,
                styles: BlobStyles(
                    fillType: BlobFillType.fill, color: Colors.blue.shade200),
                loop: true,
              ),
            ),
            onTapName: () => liquidSwipeController?.previous(),
            onSkip: () async {
              goToNextPage();
            },
            name: Constant.appName,
            action: AppStrings.skip,
            image: null,
            title: AppStrings.welcome,
            subtitle: "to Your Helpdesk",
            body: "Simplify your support experience and resolve issues faster.",
            buttonColor: ColorManager.black,
            titleColor: ColorManager.black,
            subtitleColor: Colors.blue.shade200,
            bodyColor: ColorManager.black,
            gradient: const LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          /// Second page
          LiquidSwipeCard(
            useCustomWidget: true,
            customWidget: Center(
              child: Blob.animatedFromID(
                id: Constant.blob,
                duration: const Duration(seconds: 4),
                size: 350,
                styles: BlobStyles(
                    fillType: BlobFillType.fill, color: ColorManager.black),
                loop: true,
              ),
            ),
            onTapName: () => liquidSwipeController?.previous(),
            onSkip: () async {
              goToNextPage();
            },
            name: AppStrings.back,
            action: AppStrings.done,
            image: null,
            title: "Manage Tickets",
            subtitle: "Effortlessly",
            body: "Track, prioritize, and resolve customer issues seamlessly.",
            buttonColor: ColorManager.black,
            titleColor: ColorManager.black,
            subtitleColor: ColorManager.grey,
            bodyColor: ColorManager.black,
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.blue],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ],
      ),
    );
  }

  void goToNextPage() async {
    goPush(context, Routes.loginOrRegisterPage);
  }
}
