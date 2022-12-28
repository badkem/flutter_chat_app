import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      this.width = 40,
      this.height = 40,
      this.child,
      this.decoration,
      this.onPressed,
      this.borderRadius = 25})
      : super(key: key);

  final double width;
  final double height;

  final Widget? child;

  final Decoration? decoration;

  final double borderRadius;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onPressed,
      child: Ink(
        width: width,
        height: height,
        decoration: decoration,
        child: child,
      ),
    );
  }
}
