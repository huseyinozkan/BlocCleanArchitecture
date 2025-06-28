part of '../appbar/my_app_bar.dart';

@immutable
final class _AppBarBackButton extends StatelessWidget {
  _AppBarBackButton();

  final routeService = getIt<IMyRouterService>();

  @override
  Widget build(BuildContext context) {
    return CoreButton(
      onPressed: routeService.rootRouter.pop,
      child: Icon(
        Icons.arrow_back_ios,
        color: context.colorScheme.primary,
      ),
    );
  }
}
