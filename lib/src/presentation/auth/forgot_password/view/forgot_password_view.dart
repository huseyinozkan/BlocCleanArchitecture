import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/validators/validators.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/buttons.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

final class ForgotPasswordArguments {
  const ForgotPasswordArguments({
    required this.phoneCode,
    required this.phoneNumber,
  });

  final String phoneCode;
  final String phoneNumber;
}

@immutable
final class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({required this.arguments, super.key});
  final ForgotPasswordArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgotPasswordCubit>()..arguments = arguments,
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
      title: Text(LocalizationKey.forgotPassword.tr(context)),
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
    return Container(
      padding: AppConstants.paddingConstants.pagePaddingHorizontal,
      child: Form(
        key: context.read<ForgotPasswordCubit>().formKey,
        child: const Column(
          spacing: 12,
          children: <Widget>[
            verticalBox12,
            _ForgotPasswordExplainRow(),
            _SecurityCodeTextField(),
            _PasswordTextField(),
            _PasswordAgainTextField(),
            _NextButton(),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _ForgotPasswordExplainRow extends StatelessWidget {
  const _ForgotPasswordExplainRow();

  @override
  Widget build(BuildContext context) {
    return CoreText.bodySmall(
      LocalizationKey.forgotPasswordExplain.tr(context),
      textAlign: TextAlign.center,
      textColor: context.colorScheme.onSurface.withValues(alpha: 0.5),
    );
  }
}

@immutable
final class _SecurityCodeTextField extends StatelessWidget {
  const _SecurityCodeTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<ForgotPasswordCubit>().securityCodeController,
      validator: (value) => Validators.securityCodeFieldValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.security),
        hintText: LocalizationKey.securityCode.tr(context),
      ),
      keyboardType: TextInputType.number,
      maxLength: AppConstants.general.securityCodeLength,
      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => null,
    );
  }
}

@immutable
final class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return CorePasswordTextField(
      controller: context.read<ForgotPasswordCubit>().passwordController,
      validator: (value) => Validators.passwordFieldValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      prefixIcon: const Icon(Icons.lock_outlined),
      hintText: LocalizationKey.password.tr(context),
      keyboardType: TextInputType.number,
      maxLength: AppConstants.general.passwordLength,
      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => null,
    );
  }
}

@immutable
final class _PasswordAgainTextField extends StatelessWidget {
  const _PasswordAgainTextField();

  @override
  Widget build(BuildContext context) {
    return CorePasswordTextField(
      controller: context.read<ForgotPasswordCubit>().passwordAgainController,
      validator: (value) => Validators.passwordREFieldValidator(context: context, password: context.read<ForgotPasswordCubit>().passwordController.text, rePassword: value),
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
final class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MyFilledButton(
            onPressed: context.read<ForgotPasswordCubit>().nextButtonClick,
            child: Text(LocalizationKey.next.tr(context), style: TextStyle(color: context.colorScheme.onPrimary)),
          ),
        ),
      ],
    );
  }
}
