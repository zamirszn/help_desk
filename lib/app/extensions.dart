import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}

class RedBox extends StatelessWidget {
  const RedBox({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.red,
      child: child,
    );
  }
}
