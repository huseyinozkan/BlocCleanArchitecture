import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/data_not_found_widget.dart';
import 'package:bloc_clean_architecture/src/data/model/response/address_dto.dart';
import 'package:bloc_clean_architecture/src/presentation/address/address_detail/view/address_detail_view.dart';
import 'package:bloc_clean_architecture/src/presentation/address/addresses/cubit/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';

@immutable
final class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddressCubit>()..initialized(),
      child: const Scaffold(
        appBar: _AppBar(),
        body: _Body(),
        bottomNavigationBar: _NewAddressButton(),
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
      title: Text(LocalizationKey.addresses.tr(context)),
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
    final status = context.select((AddressCubit cubit) => cubit.state.status);
    final addresses = context.select((AddressCubit cubit) => cubit.state.addresses);
    return status == AddressStatus.initial
        ? const AdaptiveIndicator()
        : addresses.isEmpty
            ? DataNotFoundWidget(description: LocalizationKey.noAddressFound.tr(context))
            : const _ListView();
  }
}

@immutable
final class _ListView extends StatelessWidget {
  const _ListView();

  @override
  Widget build(BuildContext context) {
    final addresses = context.select((AddressCubit cubit) => cubit.state.addresses);
    return CoreListView.separated(
      onRefresh: context.read<AddressCubit>().onRefresh,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 12, bottom: 48).add(AppConstants.paddingConstants.pagePaddingHorizontal),
      itemCount: addresses.length,
      separatorBuilder: (context, index) => verticalBox12,
      itemBuilder: (context, index) => _ListViewItem(address: addresses[index]),
    );
  }
}

@immutable
final class _ListViewItem extends StatelessWidget {
  const _ListViewItem({required this.address});

  final AddressDto address;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await context.pushNamed<bool>(RoutePaths.addressDetail.name, extra: AddressDetailArguments(addressId: address.id));
        if ((result ?? false) && context.mounted) await context.read<AddressCubit>().onRefresh();
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: CoreText.titleMedium(address.name, fontWeight: FontWeight.bold)),
                  CoreButton(
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: Icon(Icons.delete, color: context.colorScheme.onSurface),
                      ),
                    ),
                    onPressed: () async {
                      final result = await getIt<IMyPopupManager>().dialogs.showDeletionDialog(context: context);
                      if ((result ?? false) && context.mounted) await context.read<AddressCubit>().deleteAddress(address);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CoreText.labelLarge(
                      '${address.addressDescription}\n${address.district} / ${address.city}',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class _NewAddressButton extends StatelessWidget {
  const _NewAddressButton();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CoreButton(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.add, color: context.colorScheme.surfaceContainer),
              ),
              Expanded(
                child: CoreText.labelLarge(
                  LocalizationKey.newAddress.tr(context),
                  textColor: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        onPressed: () async {
          final result = await context.pushNamed<bool>(RoutePaths.addressDetail.name);
          if ((result ?? false) && context.mounted) await context.read<AddressCubit>().onRefresh();
        },
      ),
    );
  }
}
