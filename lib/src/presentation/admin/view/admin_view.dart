import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/presentation/admin/cubit/cubit/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminCubit>()..inialized(),
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
      title: CoreText(LocalizationKey.admin.tr(context)),
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
    final status = context.select((AdminCubit cubit) => cubit.state.status);
    return switch (status) {
      AdminStatus.loading => const AdaptiveIndicator(),
      AdminStatus.loaded => const _Content(),
    };
  }
}

@immutable
final class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return emptyBox;
  }
}
