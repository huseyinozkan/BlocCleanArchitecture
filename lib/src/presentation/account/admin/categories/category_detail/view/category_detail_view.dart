import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/validators/validators.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/buttons.dart';
import 'package:bloc_clean_architecture/src/common/widgets/others/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/presentation/account/admin/categories/category_detail/cubit/category_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

class CategoryDetailArguments {
  CategoryDetailArguments({this.categoryId});
  final int? categoryId;
}

@immutable
final class CategoryDetailView extends StatelessWidget {
  const CategoryDetailView({required this.arguments, super.key});

  final CategoryDetailArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoryDetailCubit>()..initialized(arguments),
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
    final categoryId = context.read<CategoryDetailCubit>().arguments?.categoryId;
    return MyAppBar(
      title: categoryId.isNull ? CoreText(LocalizationKey.addCategory.tr(context)) : CoreText(LocalizationKey.editCategory.tr(context)),
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
    final status = context.select((CategoryDetailCubit cubit) => cubit.state.status);

    return switch (status) {
      CategoryDetailStatus.initial => const Center(child: AdaptiveIndicator()),
      _ => SingleChildScrollView(
          child: Form(
            key: context.read<CategoryDetailCubit>().formKey,
            child: Padding(
              padding: AppConstants.paddingConstants.pagePaddingHorizontal,
              child: const Column(
                spacing: 12,
                children: [
                  _NameTextField(),
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
      controller: context.read<CategoryDetailCubit>().nameController,
      decoration: InputDecoration(hintText: LocalizationKey.categoryName.tr(context)),
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
final class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return MyFilledButton(
      onPressed: () => context.read<CategoryDetailCubit>().saveButtonClick(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CoreText.bodyLarge(LocalizationKey.save.tr(context), textColor: context.colorScheme.onPrimary),
        ],
      ),
    );
  }
}
