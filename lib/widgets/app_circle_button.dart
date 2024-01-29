import 'package:flutter/material.dart';

class AppCircleButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? onTap;
  const AppCircleButton(
      {Key? key, required this.child, this.color, this.width = 60, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      // shape: const CircleBorder(),
      child: InkWell(onTap: onTap, child: child),
    );
  }
}
