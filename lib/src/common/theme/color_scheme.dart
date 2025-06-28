import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
final class MyColorScheme extends Equatable {
  const MyColorScheme({
    this.brightness,
    this.primary,
    this.primaryContainer,
    this.onPrimary,
    this.secondary,
    this.onSecondary,
    this.error,
    this.onError,
    this.surface,
    this.onSurface,
    this.surfaceContainer,
    this.surfaceDim,
    this.scaffoldBackgroundColor,
    this.green,
    this.red,
    this.lightGray,
  });

  final Brightness? brightness;
  final Color? primary;
  final Color? primaryContainer;
  final Color? onPrimary;
  final Color? secondary;
  final Color? onSecondary;
  final Color? error;
  final Color? onError;
  final Color? surface;
  final Color? onSurface;
  final Color? surfaceContainer;
  final Color? surfaceDim;
  final Color? scaffoldBackgroundColor;
  final Color? green;
  final Color? red;
  final Color? lightGray;

  @override
  List<Object?> get props => [
        brightness,
        primary,
        primaryContainer,
        onPrimary,
        secondary,
        onSecondary,
        error,
        onError,
        surface,
        onSurface,
        surfaceContainer,
        surfaceDim,
        scaffoldBackgroundColor,
        green,
        red,
        lightGray,
      ];
}
