import 'package:flutter/material.dart';

@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.green,
    required this.red,
    required this.lightGray,
  });

  final Color? green;
  final Color? red;
  final Color? lightGray;

  @override
  MyColors copyWith({Color? green, Color? red}) {
    return MyColors(
      green: green ?? this.green,
      red: red ?? this.red,
      lightGray: lightGray,
    );
  }

  @override
  MyColors lerp(MyColors? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      green: Color.lerp(green, other.green, t),
      red: Color.lerp(red, other.red, t),
      lightGray: Color.lerp(lightGray, other.lightGray, t),
    );
  }
}
