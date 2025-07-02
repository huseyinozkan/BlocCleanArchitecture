import 'package:bloc_clean_architecture/src/common/blocs/localization/bloc/localization_bloc.dart';
import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/theme/bloc/theme_bloc.dart';
import 'package:bloc_clean_architecture/src/common/theme/color_scheme.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/data/model/response/culture_dto.dart';
import 'package:bloc_clean_architecture/src/presentation/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SettingsBloc>()..add(const SettingsInitialEvent()),
      child: const Scaffold(
        appBar: _AppBar(),
        body: _Body(),
      ),
    );
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: Text(LocalizationKey.settings.tr(context)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          _ThemeList(),
          _CultureList(),
          Spacer(),
        ],
      ),
    );
  }
}

@immutable
final class _ThemeList extends StatelessWidget {
  const _ThemeList();

  @override
  Widget build(BuildContext context) {
    final colorSchemes = context.watch<SettingsBloc>().state.colorSchemes;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CoreText.titleMedium(LocalizationKey.themeSelection.tr(context)),
        ),
        const Divider(),
        SizedBox(
          height: 140,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _ThemeOptionListTile(colorScheme: colorSchemes[index]),
            itemCount: colorSchemes.length,
          ),
        ),
      ],
    );
  }
}

@immutable
final class _ThemeOptionListTile extends StatelessWidget {
  const _ThemeOptionListTile({
    required this.colorScheme,
  });

  final MyColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeBloc>().state.theme;
    return ListTile(
      enabled: theme.brightness != colorScheme.brightness,
      leading: colorScheme.brightness == Brightness.dark ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode),
      title: CoreText.bodyLarge(colorScheme.brightness == Brightness.dark ? LocalizationKey.darkMode.tr(context) : LocalizationKey.lightMode.tr(context)),
      trailing: theme.brightness == colorScheme.brightness ? const Icon(Icons.check) : null,
      onTap: () {
        if (theme.brightness != colorScheme.brightness) context.read<ThemeBloc>().add(const ThemeSwitchedEvent());
      },
    );
  }
}

@immutable
final class _CultureList extends StatelessWidget {
  const _CultureList();

  @override
  Widget build(BuildContext context) {
    final cultures = context.watch<SettingsBloc>().state.cultures;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CoreText.titleMedium(LocalizationKey.cultureSelection.tr(context)),
        ),
        const Divider(),
        SizedBox(
          height: 140,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _CultureListTile(culture: cultures![index]),
            itemCount: cultures?.length ?? 0,
          ),
        ),
      ],
    );
  }
}

@immutable
final class _CultureListTile extends StatelessWidget {
  const _CultureListTile({required this.culture});

  final CultureDto culture;

  @override
  Widget build(BuildContext context) {
    final selectedCulture = context.watch<LocalizationBloc>().state.localization?.culture;
    final isSelectedCulture = selectedCulture?.name == culture.name;
    return ListTile(
      title: CoreText.bodyLarge(culture.title ?? ''),
      enabled: !isSelectedCulture,
      onTap: () => context.read<LocalizationBloc>().add(CultureChanged(culture)),
      trailing: isSelectedCulture ? const Icon(Icons.check) : null,
    );
  }
}
