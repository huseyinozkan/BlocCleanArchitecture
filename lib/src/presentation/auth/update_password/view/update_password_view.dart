import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/validators/validators.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/buttons.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/update_password/cubit/update_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class UpdatePasswordView extends StatelessWidget {
  const UpdatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UpdatePasswordCubit>(),
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
      title: Text(LocalizationKey.updatePassword.tr(context)),
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
        padding: const EdgeInsets.all(20),
        child: Form(
          key: context.read<UpdatePasswordCubit>().formKey,
          child: Column(
            children: [
              CoreText.labelMedium(
                LocalizationKey.updatePasswordDescription1.tr(context),
                textAlign: TextAlign.center,
              ),
              verticalBox20,
              const _OldPasswordTextField(),
              verticalBox20,
              CoreText.labelMedium(
                LocalizationKey.updatePasswordDescription2.tr(context),
                textAlign: TextAlign.center,
              ),
              verticalBox20,
              const _PasswordTextField(),
              verticalBox20,
              const _PasswordAgainTextField(),
              verticalBox20,
              const _SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class _OldPasswordTextField extends StatelessWidget {
  const _OldPasswordTextField();

  @override
  Widget build(BuildContext context) {
    return CorePasswordTextField(
      controller: context.read<UpdatePasswordCubit>().oldPasswordController,
      validator: (value) => Validators.passwordFieldValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      prefixIcon: const Icon(Icons.lock_outlined),
      hintText: LocalizationKey.currentPassword.tr(context),
      keyboardType: TextInputType.number,
      maxLength: AppConstants.general.passwordLength,
      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => null,
      textInputAction: TextInputAction.next,
    );
  }
}

@immutable
final class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return CorePasswordTextField(
      controller: context.read<UpdatePasswordCubit>().passwordController,
      validator: (value) => Validators.passwordFieldValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      prefixIcon: const Icon(Icons.lock_outlined),
      hintText: LocalizationKey.password.tr(context),
      keyboardType: TextInputType.number,
      maxLength: AppConstants.general.passwordLength,
      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => null,
      textInputAction: TextInputAction.next,
    );
  }
}

@immutable
final class _PasswordAgainTextField extends StatelessWidget {
  const _PasswordAgainTextField();

  @override
  Widget build(BuildContext context) {
    return CorePasswordTextField(
      controller: context.read<UpdatePasswordCubit>().passwordAgainController,
      validator: (value) => Validators.passwordREFieldValidator(context: context, password: context.read<UpdatePasswordCubit>().passwordController.text, rePassword: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      prefixIcon: const Icon(Icons.lock_outlined),
      hintText: LocalizationKey.passwordAgain.tr(context),
      keyboardType: TextInputType.number,
      maxLength: AppConstants.general.passwordLength,
      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => null,
    );
  }
}

@immutable
final class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MyFilledButton(
            child: Text(LocalizationKey.save.tr(context), style: TextStyle(color: context.theme.colorScheme.onPrimary)),
            onPressed: () => context.read<UpdatePasswordCubit>().saveButtonClick(),
          ),
        ),
      ],
    );
  }
}
