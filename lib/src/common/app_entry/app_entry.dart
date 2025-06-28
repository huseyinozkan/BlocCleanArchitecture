import 'package:bloc_clean_architecture/src/common/blocs/localization/bloc/localization_bloc.dart';
import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/enums/app_environment.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/common/theme/bloc/theme_bloc.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/app_entry_multi_bloc_listener.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/app_entry_multi_bloc_provider.dart';
import 'package:bloc_clean_architecture/src/data/model/response/culture_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class VeresiyeDefteriApp extends StatelessWidget {
  const VeresiyeDefteriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEntryMultiBlocProvider(
      builder: (context) {
        return MaterialApp.router(
          routerConfig: getIt<IMyRouterService>().rootRouter,
          debugShowCheckedModeBanner: false,
          theme: context.watch<ThemeBloc>().state.theme,
          supportedLocales: supportedLocales,
          locale: context.watch<LocalizationBloc>().state.localization?.culture?.locale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            final multiBlocListener = AppEntryMultiBlocListener(
              builder: (context) => CoreBuilder(child: child),
            );

            if (AppEnvironment.selected == AppEnvironment.dev) {
              return Banner(
                message: 'DEV',
                location: BannerLocation.topEnd,
                child: multiBlocListener,
              );
            }
            return multiBlocListener;
          },
        );
      },
    );
  }
}
