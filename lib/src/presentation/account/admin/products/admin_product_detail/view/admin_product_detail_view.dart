import 'dart:async';

import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/common/validators/validators.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/buttons.dart';
import 'package:bloc_clean_architecture/src/common/widgets/network_image/cached_network_image.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/data/model/key_value_model.dart';
import 'package:bloc_clean_architecture/src/presentation/account/admin/products/admin_product_detail/cubit/admin_product_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AdminProductDetailArguments {
  AdminProductDetailArguments({required this.productId});
  final int? productId;
}

@immutable
final class AdminProductDetailView extends StatelessWidget {
  const AdminProductDetailView({required this.arguments, super.key});

  final AdminProductDetailArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminProductDetailCubit>()..initialized(arguments: arguments),
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
    final productId = context.select((AdminProductDetailCubit cubit) => cubit.state.product?.id);
    return MyAppBar(title: CoreText(productId.isNull ? LocalizationKey.createProduct.tr(context) : LocalizationKey.editProduct.tr(context)));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final status = context.select((AdminProductDetailCubit cubit) => cubit.state.status);
    return switch (status) {
      AdminProductDetailStatus.initial => const Center(child: AdaptiveIndicator()),
      _ => SingleChildScrollView(
          child: Padding(
            padding: AppConstants.paddingConstants.pagePadding.add(const EdgeInsetsGeometry.only(bottom: 52)),
            child: Form(
              key: context.read<AdminProductDetailCubit>().formKey,
              child: const Column(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ProductImage(),
                  _SelectCategoryTextField(),
                  _NameTextField(),
                  _PriceTextField(),
                  _DescriptionTextField(),
                  _SaveButton(),
                ],
              ),
            ),
          ),
        ),
    };
  }
}

@immutable
final class _ProductImage extends StatelessWidget {
  const _ProductImage();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final source = await getIt<IMyPopupManager>().bottomSheets.showImageSourcePicker(context: context);

        if (source == null) return;

        final permissionManager = getIt<IMyRouterService>().permissionManager;
        final permissionStatus = switch (source) {
          ImageSourceType.camera => await permissionManager.requestPermission(permission: CorePermission.camera),
          ImageSourceType.gallery => await permissionManager.requestPermission(permission: CorePermission.photos),
        };
        if (permissionStatus != CorePermissionStatus.granted) return;

        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: source == ImageSourceType.camera ? ImageSource.camera : ImageSource.gallery);
        if (pickedFile == null) return;

        final cropper = ImageCropper();
        final croppedFile = await cropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
              cropStyle: CropStyle.circle,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
              ],
            ),
            IOSUiSettings(
              cropStyle: CropStyle.circle,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
              ],
            ),
          ],
        );
        if (croppedFile == null) return;

        if (context.mounted) {
          unawaited(context.read<AdminProductDetailCubit>().onChangedProductImage(croppedFile));
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Builder(
          builder: (context) {
            final productImage = context.select((AdminProductDetailCubit cubit) => cubit.state.productImage);
            return MyCachedNetworkImage(
              cacheKey: productImage?.lastModifiedDate?.millisecondsSinceEpoch.toString(),
              imageId: productImage?.id,
              height: context.width * 0.5,
              width: context.width * 0.5,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.05),
                ),
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 48,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SelectCategoryTextField extends StatelessWidget {
  const _SelectCategoryTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<AdminProductDetailCubit>().categoryControler,
      decoration: InputDecoration(
        hintText: LocalizationKey.selectCategory.tr(context),
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      readOnly: true,
      validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: () async {
        final categories = context.read<AdminProductDetailCubit>().state.categories;
        final selectedSelectedCategory = context.read<AdminProductDetailCubit>().state.selectedCategory;
        final newSelectedSelectedCategory = await getIt<IMyPopupManager>().bottomSheets.showSingleSelectBottomSheet(
              context: context,
              title: LocalizationKey.categories.tr(context, listen: false),
              list: categories.map((e) => KeyValueModel(key: e.id?.toString(), value: e.name)).toList(),
              selectedItem: KeyValueModel(key: selectedSelectedCategory?.id?.toString(), value: selectedSelectedCategory?.name),
            );

        if (newSelectedSelectedCategory.isNotNull && context.mounted) context.read<AdminProductDetailCubit>().onChangedSelectedCategory(categories.firstWhereOrNull((e) => e.id.toString() == newSelectedSelectedCategory?.key));
      },
    );
  }
}

@immutable
final class _NameTextField extends StatelessWidget {
  const _NameTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<AdminProductDetailCubit>().nameController,
      decoration: InputDecoration(hintText: LocalizationKey.productName.tr(context)),
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
final class _PriceTextField extends StatelessWidget {
  const _PriceTextField();

  @override
  Widget build(BuildContext context) {
    return CoreCurrencyTextField(
      controller: context.read<AdminProductDetailCubit>().priceController,
      hintText: LocalizationKey.price.tr(context),
      validator: (value) => Validators.currencyFieldValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      suffixIcon: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CoreText.bodyMedium('₺'),
        ],
      ),
      maxLength: 50,
      buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
    );
  }
}

@immutable
final class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<AdminProductDetailCubit>().descriptionController,
      decoration: InputDecoration(hintText: LocalizationKey.productDescription.tr(context)),
      validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      maxLength: 500,
      buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
      minLines: 2,
      maxLines: 4,
    );
  }
}

@immutable
final class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return MyFilledButton(
      onPressed: () => context.read<AdminProductDetailCubit>().onClickedSaveButton(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CoreText.bodyLarge(LocalizationKey.save.tr(context), textColor: context.colorScheme.onPrimary),
        ],
      ),
    );
  }
}
