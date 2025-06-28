import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: inputDecorationTheme(context),
    );
  }

  InputDecoration inputDecorationTheme(BuildContext context) => InputDecoration(
        filled: true,
        fillColor: context.colorScheme.surfaceDim,
        hintText: LocalizationKey.search.tr(context),
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: context.theme.colorScheme.onSurface.withValues(alpha: 0.5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      );
}
