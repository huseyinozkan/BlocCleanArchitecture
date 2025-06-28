import 'package:bloc_clean_architecture/src/common/blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/indicator/bloc/indicator_bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/localization/bloc/localization_bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/network_manager/bloc/network_manager_bloc.dart';
import 'package:bloc_clean_architecture/src/common/blocs/sqflite_manager/bloc/sqflite_manager_bloc.dart';
import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
final class AppEntryMultiBlocProvider extends StatelessWidget {
  const AppEntryMultiBlocProvider({required this.builder, super.key});

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<NetworkManagerBloc>()..add(const NetworkManagerInitialEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<IndicatorBloc>()..add(const IndicatorInitializedEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<SqfliteManagerBloc>()..add(const SqfliteManagerInitialEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<ThemeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<LocalizationBloc>(),
        ),
      ],
      child: Builder(builder: builder),
    );
  }
}
