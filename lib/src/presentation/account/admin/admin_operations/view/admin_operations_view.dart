import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/presentation/account/admin/admin_operations/cubit/admin_operations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';

@immutable
final class AdminOperationsView extends StatelessWidget {
  const AdminOperationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminOperationsCubit>(),
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
      title: CoreText(LocalizationKey.adminOperations.tr(context)),
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
    return Padding(
      padding: AppConstants.paddingConstants.pagePaddingHorizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _MenuRow(onPressed: () => context.pushNamed(RoutePaths.adminOrders.name), title: LocalizationKey.orders.tr(context)),
            _MenuRow(onPressed: () => context.pushNamed(RoutePaths.categories.name), title: LocalizationKey.categories.tr(context)),
            _MenuRow(onPressed: () => context.pushNamed(RoutePaths.adminProducts.name), title: LocalizationKey.products.tr(context)),
            verticalBox48,
          ],
        ),
      ),
    );
  }
}

@immutable
final class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.onPressed, required this.title});

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CoreButton(
          onPressed: onPressed,
          child: Column(
            children: [
              verticalBox8,
              Row(
                children: [
                  Expanded(child: CoreText.titleMedium(title, fontWeight: FontWeight.bold)),
                  Icon(Icons.arrow_forward_ios, color: context.colorScheme.onSurface),
                ],
              ),
              verticalBox8,
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
