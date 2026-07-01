import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final IconData? icon;
  final Color? iconColor;

  const AppLogo({
    Key? key,
    this.size = 80,
    this.backgroundColor,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        icon ?? Icons.assignment,
        size: size * 0.625,
        color: iconColor ?? Colors.blue.shade700,
      ),
    );
  }
}
