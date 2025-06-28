import 'package:bloc_clean_architecture/src/common/blocs/localization/bloc/localization_bloc.dart';
import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/common/theme/bloc/theme_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

part '../buttons/appbar_back_button.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.showBackButton = true,
    this.bottom,
    this.flexibleSpace,
  });

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: kDebugMode ? () => onTapClicked(context) : null,
      onLongPress: kDebugMode ? () => onLongPressClicked(context) : null,
      child: AppBar(
        leading: leading != null
            ? leading!
            : showBackButton
                ? _AppBarBackButton()
                : null,
        title: title,
        actions: actions,
        bottom: bottom,
        flexibleSpace: flexibleSpace,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void onTapClicked(BuildContext context) {
    context.read<ThemeBloc>().add(const ThemeSwitchedEvent());
  }

  void onLongPressClicked(BuildContext context) {
    context.read<LocalizationBloc>().add(const LocalizationChangeToggleClicked());
  }
}
