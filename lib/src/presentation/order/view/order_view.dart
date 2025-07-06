import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/validators/validators.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/buttons.dart';
import 'package:bloc_clean_architecture/src/data/model/enums/payment_method.dart';
import 'package:bloc_clean_architecture/src/data/model/key_value_model.dart';
import 'package:bloc_clean_architecture/src/data/model/response/address_dto.dart';
import 'package:bloc_clean_architecture/src/presentation/address/address_detail/view/address_detail_view.dart';
import 'package:bloc_clean_architecture/src/presentation/order/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';

@immutable
final class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrderCubit>()..initialized(context),
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
      title: CoreText(LocalizationKey.order.tr(context)),
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
    return SingleChildScrollView(
      child: Padding(
        padding: AppConstants.paddingConstants.pagePaddingHorizontal,
        child: Form(
          key: context.read<OrderCubit>().formKey,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              verticalBox12,
              _SelectAddressTextField(),
              _AddNewAddressButton(),
              _SelectPaymentMethodTextField(),
              _OrderNoteTextField(),
              _SendTheOrderButton(),
              verticalBox64,
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class _SelectAddressTextField extends StatelessWidget {
  const _SelectAddressTextField();

  @override
  Widget build(BuildContext context) {
    final selectedAddress = context.select((OrderCubit cubit) => cubit.state.selectedAddress);
    final addresses = context.select((OrderCubit cubit) => cubit.state.addresses);
    return selectedAddress.isNull
        ? emptyBox
        : TextFormField(
            controller: context.read<OrderCubit>().addressController,
            decoration: InputDecoration(hintText: LocalizationKey.selectAddress.tr(context), suffixIcon: addresses.length == 1 ? emptyBox : const Icon(Icons.arrow_drop_down_sharp)),
            validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: true,
            onTap: addresses.length == 1
                ? null
                : () async {
                    final addresses = context.read<OrderCubit>().state.addresses;
                    final selectedAddress = context.read<OrderCubit>().state.selectedAddress;
                    final newSelectedAddress = await getIt<IMyPopupManager>().bottomSheets.showSelectAddressBottomSheet(
                          context: context,
                          list: addresses,
                          selectedItem: selectedAddress,
                        );

                    if (newSelectedAddress.isNotNull && context.mounted) return context.read<OrderCubit>().onChangedAddress(newSelectedAddress);
                  },
          );
  }
}

@immutable
final class _AddNewAddressButton extends StatelessWidget {
  const _AddNewAddressButton();

  @override
  Widget build(BuildContext context) {
    return MyIconButton(
      icon: Container(
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
                LocalizationKey.addNewAddress.tr(context),
                textColor: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      onPressed: () async {
        final result = await context.pushNamed<AddressDto>(RoutePaths.addressDetail.name, extra: AddressDetailArguments(fromPath: RoutePaths.order));
        if (result.isNull) return;
        context.read<OrderCubit>().newAddressAdded(result!);
      },
    );
  }
}

@immutable
final class _SelectPaymentMethodTextField extends StatelessWidget {
  const _SelectPaymentMethodTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoreText.titleMedium(LocalizationKey.paymentMethod.tr(context), fontWeight: FontWeight.bold),
        TextFormField(
          controller: context.read<OrderCubit>().paymentMethodController,
          decoration: InputDecoration(
            hintText: LocalizationKey.paymentMethod.tr(context),
            suffixIcon: const Icon(Icons.arrow_drop_down),
          ),
          readOnly: true,
          validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTap: () async {
            final popupManager = getIt<IMyPopupManager>();
            const paymentMethods = PaymentMethod.values;
            final selectedPaymentMethod = context.read<OrderCubit>().state.selectedPaymentMethod;
            final newSelectedPaymentMethod = await popupManager.bottomSheets.showSingleSelectBottomSheet(
              context: context,
              title: LocalizationKey.paymentMethod.tr(context, listen: false),
              list: paymentMethods.map((e) => KeyValueModel(key: e.name, value: e.localizationKey.tr(context, listen: false))).toList(),
              selectedItem: KeyValueModel(key: selectedPaymentMethod?.name, value: selectedPaymentMethod?.localizationKey.tr(context, listen: false)),
            );

            if (newSelectedPaymentMethod.isNotNull && context.mounted) context.read<OrderCubit>().onChangePaymentMethod(context, PaymentMethod.values.firstWhere((e) => e.name == newSelectedPaymentMethod?.key));
          },
        ),
      ],
    );
  }
}

@immutable
final class _OrderNoteTextField extends StatelessWidget {
  const _OrderNoteTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoreText.titleMedium(LocalizationKey.orderNoteTitle.tr(context), fontWeight: FontWeight.bold),
        TextFormField(
          controller: context.read<OrderCubit>().orderNoteController,
          decoration: InputDecoration(hintText: LocalizationKey.orderNoteHintText.tr(context)),
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          minLines: 2,
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }
}

@immutable
final class _SendTheOrderButton extends StatelessWidget {
  const _SendTheOrderButton();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppConstants.paddingConstants.pagePaddingHorizontal,
        child: MyFilledButton(
          onPressed: () => context.read<OrderCubit>().sendTheOrderButtonPressed(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CoreText.bodyLarge(LocalizationKey.sendTheOrder.tr(context), fontWeight: FontWeight.w500, textColor: context.colorScheme.onPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
