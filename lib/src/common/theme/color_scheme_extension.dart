import 'package:bloc_clean_architecture/src/common/theme/color_scheme.dart';
import 'package:bloc_clean_architecture/src/common/theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

extension MyColorSchemeExtension on MyColorScheme {
  SystemUiOverlayStyle get lightOverlayStyle => SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: scaffoldBackgroundColor?.withValues(alpha: 0.002),
      );

  SystemUiOverlayStyle get darkOverlayStyle => SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: scaffoldBackgroundColor?.withValues(alpha: 0.002),
      );

  ThemeData get theme {
    SystemChrome.setSystemUIOverlayStyle(
      brightness == Brightness.light ? lightOverlayStyle : darkOverlayStyle,
    );

    return ThemeData(
      colorScheme: ThemeData().colorScheme.copyWith(
            brightness: brightness,
            primary: primary,
            primaryContainer: primaryContainer,
            onPrimary: onPrimary,
            secondary: secondary,
            onSecondary: onSecondary,
            error: error,
            onError: onError,
            surface: surface,
            onSurface: onSurface,
            surfaceContainer: surfaceContainer,
            surfaceDim: surfaceDim,
          ),
      extensions: <ThemeExtension<dynamic>>[
        MyColors(
          green: green,
          red: red,
          lightGray: lightGray,
        ),
      ],
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: _appBarTheme,
      textSelectionTheme: _textSelectionTheme,
      inputDecorationTheme: _inputDecorationTheme,
      dropdownMenuTheme: _dropdownMenuTheme,
      bottomSheetTheme: _bottomSheetTheme,
      cardTheme: _cardTheme,
      dialogTheme: _dialogTheme,
      listTileTheme: _listTileTheme,
      checkboxTheme: _checkboxTheme,
      radioTheme: _radioTheme,
    );
  }

  AppBarTheme get _appBarTheme {
    return AppBarTheme(
      backgroundColor: scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      systemOverlayStyle: brightness == Brightness.light ? lightOverlayStyle : darkOverlayStyle,
      titleTextStyle: TextStyle(
        color: onSurface,
        fontSize: 18,
      ),
    );
  }

  TextSelectionThemeData get _textSelectionTheme {
    return TextSelectionThemeData(
      cursorColor: onSurface?.withValues(alpha: 0.6),
    );
  }

  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: surfaceDim,
        hintStyle: TextStyle(color: onSurface?.withValues(alpha: 0.7)),
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
          borderSide: BorderSide(color: error ?? Colors.red, width: 0.8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: error ?? Colors.red, width: 0.8),
        ),
      );

  DropdownMenuThemeData get _dropdownMenuTheme {
    return DropdownMenuThemeData(
      inputDecorationTheme: _inputDecorationTheme,
      menuStyle: const MenuStyle(),
    );
  }

  BottomSheetThemeData get _bottomSheetTheme {
    return BottomSheetThemeData(
      backgroundColor: surface,
      dragHandleColor: onSurface?.withValues(alpha: 0.6),
    );
  }

  CardThemeData get _cardTheme {
    return CardThemeData(
      color: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  DialogThemeData get _dialogTheme {
    return DialogThemeData(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  ListTileThemeData get _listTileTheme {
    return ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      iconColor: onSurface,
      titleTextStyle: const TextTheme().copyWith().bodyLarge,
      subtitleTextStyle: const TextTheme().copyWith().labelLarge,
    );
  }

  CheckboxThemeData? get _checkboxTheme {
    return brightness == Brightness.light ? null : const CheckboxThemeData();
  }

  RadioThemeData? get _radioTheme {
    return brightness == Brightness.light ? null : const RadioThemeData();
  }
}
