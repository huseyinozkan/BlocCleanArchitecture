import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/gen/assets.gen.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/buttons.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SplashBloc>()..add(const SplashInitializedEvent()),
      child: const Scaffold(
        body: _Body(),
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.paddingConstants.pagePadding,
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return switch (state) {
            SplashError _ => const _SplashErrorBody(),
            _ => const _SplashProcessingBody(),
          };
        },
      ),
    );
  }
}

@immutable
final class _SplashErrorBody extends StatelessWidget {
  const _SplashErrorBody();

  @override
  Widget build(BuildContext context) {
    final errorMessage = (context.watch<SplashBloc>().state as SplashError).message;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CoreText.titleLarge(
                errorMessage,
                textAlign: TextAlign.center,
              ),
              verticalBox20,
              Row(
                children: [
                  Expanded(
                    child: MyFilledButton(
                      child: CoreText.labelLarge(
                        LocalizationKey.tryAgainLater.tr(context),
                        fontWeight: FontWeight.bold,
                        textColor: context.colorScheme.onPrimary,
                      ),
                      onPressed: () => context.read<SplashBloc>().add(const SplashInitializedEvent()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

@immutable
final class _SplashProcessingBody extends StatelessWidget {
  const _SplashProcessingBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Assets.images.launcherImage.image(
                width: context.width * 0.3,
                fit: BoxFit.contain,
              ),
            ),
            verticalBox20,
            CoreText.titleLarge(LocalizationKey.cleanArchitecture.tr(context), fontWeight: FontWeight.bold),
            verticalBox64,
          ],
        ),
      ),
    );
  }
}
