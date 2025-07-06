import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/validators/validators.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/buttons.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/presentation/account/address/address_detail/cubit/address_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

class AddressDetailArguments {
  AddressDetailArguments({this.addressId, this.fromPath});
  final int? addressId;
  final RoutePaths? fromPath;
}

@immutable
final class AddressDetailView extends StatelessWidget {
  const AddressDetailView({required this.arguments, super.key});

  final AddressDetailArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddressDetailCubit>()..initialized(arguments),
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
    final addressId = context.read<AddressDetailCubit>().arguments?.addressId;
    return MyAppBar(
      title: addressId.isNull ? CoreText(LocalizationKey.addAddress.tr(context)) : CoreText(LocalizationKey.editAddress.tr(context)),
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
    final status = context.select((AddressDetailCubit cubit) => cubit.state.status);

    return switch (status) {
      AddressDetailStatus.initial => const Center(child: AdaptiveIndicator()),
      _ => SingleChildScrollView(
          child: Form(
            key: context.read<AddressDetailCubit>().formKey,
            child: Padding(
              padding: AppConstants.paddingConstants.pagePaddingHorizontal,
              child: const Column(
                spacing: 12,
                children: [
                  _NameTextField(),
                  _CityTextField(),
                  _DistrictTextField(),
                  _AddressDescriptionTextField(),
                  _SaveButton(),
                  verticalBox64,
                ],
              ),
            ),
          ),
        ),
    };
  }
}

@immutable
final class _NameTextField extends StatelessWidget {
  const _NameTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<AddressDetailCubit>().nameController,
      decoration: InputDecoration(hintText: LocalizationKey.addressName.tr(context)),
      validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      maxLength: 50,
      buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
    );
  }
}

@immutable
final class _CityTextField extends StatelessWidget {
  const _CityTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<AddressDetailCubit>().cityController,
      decoration: InputDecoration(hintText: LocalizationKey.cityName.tr(context)),
      validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      maxLength: 50,
      buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
    );
  }
}

@immutable
final class _DistrictTextField extends StatelessWidget {
  const _DistrictTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<AddressDetailCubit>().districtController,
      decoration: InputDecoration(hintText: LocalizationKey.districtName.tr(context)),
      validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      maxLength: 50,
      buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
    );
  }
}

@immutable
final class _AddressDescriptionTextField extends StatelessWidget {
  const _AddressDescriptionTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<AddressDetailCubit>().addressDescriptionController,
      decoration: InputDecoration(hintText: LocalizationKey.addressDescription.tr(context)),
      validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      maxLength: 500,
      minLines: 2,
      maxLines: 4,
      buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
    );
  }
}

@immutable
final class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return MyFilledButton(
      onPressed: () => context.read<AddressDetailCubit>().saveButtonClick(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CoreText.bodyLarge(LocalizationKey.save.tr(context), textColor: context.colorScheme.onPrimary),
        ],
      ),
    );
  }
}
