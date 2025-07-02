import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/presentation/account/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';

@immutable
final class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccountBloc>()..add(const AccountInitializedEvet()),
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
      leading: emptyBox,
      title: Text(LocalizationKey.myAccount.tr(context)),
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
            const _NameAndEmailArea(),
            verticalBox20,
            _MenuRow(onPressed: () {}, title: LocalizationKey.admin.tr(context)),
            _MenuRow(onPressed: () {}, title: LocalizationKey.orders.tr(context)),
            _MenuRow(onPressed: () {}, title: LocalizationKey.address.tr(context)),
            _MenuRow(onPressed: () => context.pushNamed(RoutePaths.updatePassword.name), title: LocalizationKey.updatePassword.tr(context)),
            _MenuRow(onPressed: () => context.pushNamed(RoutePaths.settings.name), title: LocalizationKey.settings.tr(context)),
            verticalBox20,
            const _LogoutButton(),
            verticalBox20,
            const _AppVersion(),
            verticalBox48,
          ],
        ),
      ),
    );
  }
}

@immutable
final class _NameAndEmailArea extends StatelessWidget {
  const _NameAndEmailArea();

  @override
  Widget build(BuildContext context) {
    final userCredentials = context.read<AccountBloc>().userCredentials;
    return Container(
      width: context.width,
      height: context.height * 0.1,
      decoration: BoxDecoration(
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          CoreText.titleLarge(userCredentials?.user?.name, textColor: context.colorScheme.onSecondary, fontWeight: FontWeight.bold, textAlign: TextAlign.center),
          CoreText.titleMedium(userCredentials?.user?.email, textColor: context.colorScheme.onSecondary, fontWeight: FontWeight.bold, textAlign: TextAlign.center),
        ],
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

@immutable
final class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return CoreFilledButton(
      borderRadius: BorderRadius.circular(24),
      onPressed: () async {
        final popupManager = getIt<IMyPopupManager>();
        final result = await popupManager.dialogs.showLogoutDialog(context: context);
        if (result != true || !context.mounted) return;
        context.read<AccountBloc>().add(const AccountLogoutButtonPressedEvet());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CoreText.bodyMedium(
          LocalizationKey.logout.tr(context),
          textColor: context.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

@immutable
final class _AppVersion extends StatelessWidget {
  const _AppVersion();

  @override
  Widget build(BuildContext context) {
    final version = context.select((AccountBloc bloc) => bloc.state.version);
    return CoreText.bodyMedium(version.isNull ? '' : '${LocalizationKey.version.value} $version', textColor: context.colorScheme.onSurface.withValues(alpha: 0.7));
  }
}
