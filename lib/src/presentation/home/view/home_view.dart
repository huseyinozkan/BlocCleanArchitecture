import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/presentation/home/cubit/home_cubit.dart';
import 'package:bloc_clean_architecture/src/presentation/home/widgets/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..initialized(context),
      child: Scaffold(
        appBar: _AppBar(),
        body: const _Body(),
        endDrawer: const HomeDrawer(),
      ),
    );
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  _AppBar();

  final popupManager = getIt<IMyPopupManager>();

  @override
  Widget build(BuildContext context) {
    return const MyAppBar(
      leading: emptyBox,
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
    final status = context.select((HomeCubit cubit) => cubit.state.status);
    return switch (status) {
      HomeStatus.loading => const AdaptiveIndicator(),
      HomeStatus.loaded => const Column(
          children: [
            emptyBox,
          ],
        )
    };
  }
}
