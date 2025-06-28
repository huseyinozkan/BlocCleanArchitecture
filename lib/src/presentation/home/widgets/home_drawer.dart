import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/presentation/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';

@immutable
final class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.read<HomeCubit>().isAdmin;
    return Drawer(
      backgroundColor: context.colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: context.colorScheme.primary),
            child: Text(LocalizationKey.menuTitle.tr(context), style: const TextStyle(color: Colors.white, fontSize: 24)),
          ),
          if (isAdmin)
            ListTile(
              leading: const Icon(Icons.person_outlined),
              title: Text(LocalizationKey.admin.tr(context)),
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(RoutePaths.admin.name);
              },
            ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: Text(LocalizationKey.updatePassword.tr(context)),
            onTap: () {
              Navigator.pop(context);
              context.pushNamed(RoutePaths.updatePassword.name);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(LocalizationKey.signOut.tr(context)),
            onTap: () {
              Navigator.pop(context);
              context.read<HomeCubit>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
