import 'package:flutter/material.dart';

abstract class MyButtonBase extends StatelessWidget {
  const MyButtonBase({
    this.minSize = 50,
    super.key,
  });

  final double minSize;
}
