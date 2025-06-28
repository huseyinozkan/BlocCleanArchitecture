import 'package:bloc_clean_architecture/src/common/widgets/buttons/button_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class MyFilledButton extends MyButtonBase {
  const MyFilledButton({
    required this.child,
    required this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    super.minSize = kMinInteractiveDimension,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    super.key,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return CoreFilledButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? context.theme.colorScheme.primary,
      borderRadius: borderRadius,
      padding: padding,
      minSize: minSize,
      child: child,
    );
  }
}

@immutable
final class MyOutlinedButton extends MyButtonBase {
  const MyOutlinedButton({
    required this.child,
    required this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    super.minSize,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    super.key,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final BorderRadius borderRadius;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return CoreOutlinedButton(
      onPressed: onPressed,
      borderColor: borderColor,
      borderRadius: borderRadius,
      padding: padding,
      minSize: minSize,
      child: child,
    );
  }
}
