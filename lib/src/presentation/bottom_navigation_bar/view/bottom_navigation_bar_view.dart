import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/gen/assets.gen.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/presentation/bottom_navigation_bar/cubit/bottom_navigation_bar_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';

enum BottomNavigationBarItems {
  products,
  account,
  cart,
}

@immutable
final class BottomNavigationBarView extends StatelessWidget {
  const BottomNavigationBarView({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BottomNavigationBarCubit>()..initialized(),
      child: Scaffold(
        body: _Body(navigationShell: navigationShell),
        bottomNavigationBar: _BottomNavigationBar(navigationShell: navigationShell),
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BackButtonListener(
          child: navigationShell,
          onBackButtonPressed: () {
            final fullPath = GoRouterState.of(context).fullPath;
            if (fullPath == RoutePaths.products.asRoutePath || fullPath == RoutePaths.account.asRoutePath || fullPath == RoutePaths.basket.asRoutePath) {
              if (navigationShell.currentIndex == 0) return SynchronousFuture<bool>(false);
              navigationShell.goBranch(0);
              return SynchronousFuture<bool>(true);
            }
            return SynchronousFuture<bool>(false);
          },
        );
      },
    );
  }
}

@immutable
final class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomAppBar(
        padding: EdgeInsets.zero,
        color: context.theme.scaffoldBackgroundColor,
        height: 54,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                child: SizedBox.expand(
                  child: Center(
                    child: Assets.images.home.image(
                      width: 24,
                      height: 24,
                      color: currentIndex == BottomNavigationBarItems.products.index ? context.colorScheme.onSurface : context.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                onTap: () => navigationShell.goBranch(
                  BottomNavigationBarItems.products.index,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: SizedBox.expand(
                  child: Center(
                    child: Assets.images.user.image(
                      width: 24,
                      height: 24,
                      color: currentIndex == BottomNavigationBarItems.account.index ? context.colorScheme.onSurface : context.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                onTap: () => navigationShell.goBranch(
                  BottomNavigationBarItems.account.index,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: SizedBox.expand(
                  child: Center(
                    child: Badge.count(
                      isLabelVisible: context.select((BottomNavigationBarCubit cubit) => cubit.state.cartCount) != 0,
                      count: context.select((BottomNavigationBarCubit cubit) => cubit.state.cartCount),
                      backgroundColor: context.colorScheme.primary,
                      child: Assets.images.cart.image(
                        width: 24,
                        height: 24,
                        color: currentIndex == BottomNavigationBarItems.cart.index ? context.colorScheme.onSurface : context.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
                onTap: () => navigationShell.goBranch(
                  BottomNavigationBarItems.cart.index,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
