import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/validators/validators.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/buttons.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/forgot_password_send_otp_code/cubit/forgot_password_send_otp_code_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class ForgotPasswordSendOtpCodeView extends StatelessWidget {
  const ForgotPasswordSendOtpCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgotPasswordSendOtpCodeCubit>()..initialize(),
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
      title: CoreText(LocalizationKey.forgotPassword.tr(context)),
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
    return Padding(
      padding: AppConstants.paddingConstants.pagePaddingHorizontal,
      child: Form(
        key: context.read<ForgotPasswordSendOtpCodeCubit>().formKey,
        child: Column(
          spacing: 16,
          children: [
            verticalBox12,
            CoreText.labelMedium(LocalizationKey.forgotPasswordExplain.tr(context), textAlign: TextAlign.center),
            _PhoneCodeAndPhoneNumberTextField(),
            const _NextButton(),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _PhoneCodeAndPhoneNumberTextField extends StatelessWidget {
  _PhoneCodeAndPhoneNumberTextField();

  final popupManager = getIt<IMyPopupManager>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            onTap: () async {
              final country = await popupManager.bottomSheets.showSelectCountryCodeBottomSheet(context);
              final phoneCode = country?.phoneCode;
              if (phoneCode.isNullOrEmpty) return;
              if (context.mounted) context.read<ForgotPasswordSendOtpCodeCubit>().phoneCodeController.text = phoneCode ?? '';
            },
            readOnly: true,
            controller: context.read<ForgotPasswordSendOtpCodeCubit>().phoneCodeController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: LocalizationKey.code.tr(context),
            ),
          ),
        ),
        horizontalBox8,
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: context.read<ForgotPasswordSendOtpCodeCubit>().phoneNumberController,
            validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: LocalizationKey.phone.tr(context),
            ),
          ),
        ),
      ],
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MyFilledButton(
            onPressed: context.read<ForgotPasswordSendOtpCodeCubit>().nextButtonClick,
            child: Text(LocalizationKey.next.tr(context, listen: false), style: TextStyle(color: context.colorScheme.onPrimary)),
          ),
        ),
      ],
    );
  }
}
