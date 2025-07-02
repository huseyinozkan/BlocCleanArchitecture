import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/gen/assets.gen.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/overlay_manager/overlay_manager.dart';
import 'package:bloc_clean_architecture/src/common/overlay_manager/toast_type.dart';
import 'package:bloc_clean_architecture/src/common/popup_manager/popup_manager.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/validators/validators.dart';
import 'package:bloc_clean_architecture/src/common/widgets/appbar/my_app_bar.dart';
import 'package:bloc_clean_architecture/src/common/widgets/buttons/buttons.dart';
import 'package:bloc_clean_architecture/src/presentation/auth/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';

@immutable
final class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>()..initialize(tabController: TabController(length: 2, vsync: this)),
      child: Builder(
        builder: (context) {
          return const Scaffold(
            appBar: _AppBar(),
            body: _Body(),
          );
        },
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: context.read<LoginCubit>().tabController,
      children: const [
        _LoginContent(),
        _RegisterContent(),
      ],
    );
  }
}

class _RegisterContent extends StatelessWidget {
  const _RegisterContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: context.read<LoginCubit>().registerFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalBox24,
              _RegisterPhoneTextField(),
              verticalBox12,
              const _RegisterUsernameTextField(),
              verticalBox12,
              const _RegisterPasswordTextField(),
              verticalBox12,
              const _RegisterPasswordAgainTextField(),
              verticalBox12,
              const _RegisterNameTextField(),
              verticalBox12,
              const _RegisterSurnameTextField(),
              verticalBox12,
              const _RegisterEmailTextField(),
              verticalBox12,
              _UserAgreementCheckBox(),
              _ConfidentialityAgreementCheckBox(),
              verticalBox24,
              _RegisterButton(),
              verticalBox24,
            ],
          ),
        ),
      ),
    );
  }
}

final class _UserAgreementCheckBox extends StatelessWidget {
  _UserAgreementCheckBox();

  final popupManager = getIt<IMyPopupManager>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: context.select((LoginCubit cubit) => cubit.state.userAgreementValue),
          onChanged: (bool? value) => context.read<LoginCubit>().userAgreementButtonClick(context),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => context.read<LoginCubit>().userAgreementButtonClick(context),
            child: CoreText.bodyMedium(LocalizationKey.userAgreementText.tr(context)),
          ),
        ),
      ],
    );
  }
}

final class _ConfidentialityAgreementCheckBox extends StatelessWidget {
  _ConfidentialityAgreementCheckBox();
  final popupManager = getIt<IMyPopupManager>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: context.select((LoginCubit cubit) => cubit.state.privacyAgreementValue),
          onChanged: (bool? value) => context.read<LoginCubit>().privacyAgreementButtonClick(context),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => context.read<LoginCubit>().privacyAgreementButtonClick(context),
            child: CoreText.bodyMedium(LocalizationKey.confidentialityAgreementText.tr(context)),
          ),
        ),
      ],
    );
  }
}

final class _RegisterNameTextField extends StatelessWidget {
  const _RegisterNameTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginCubit>().registerNameController,
      decoration: InputDecoration(
        hintText: LocalizationKey.name.tr(context),
        prefixIcon: const Icon(Icons.person_outline),
      ),
    );
  }
}

final class _RegisterSurnameTextField extends StatelessWidget {
  const _RegisterSurnameTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginCubit>().registerSurnameController,
      decoration: InputDecoration(
        hintText: LocalizationKey.surname.tr(context),
        prefixIcon: const Icon(Icons.person_outline),
      ),
    );
  }
}

final class _RegisterEmailTextField extends StatelessWidget {
  const _RegisterEmailTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginCubit>().registerEmailController,
      decoration: InputDecoration(
        hintText: LocalizationKey.email.tr(context),
        prefixIcon: const Icon(Icons.mail_outline),
      ),
    );
  }
}

final class _RegisterUsernameTextField extends StatelessWidget {
  const _RegisterUsernameTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginCubit>().registerUsernameController,
      validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: LocalizationKey.username.tr(context),
        prefixIcon: const Icon(Icons.person_outline),
      ),
    );
  }
}

final class _RegisterPhoneTextField extends StatelessWidget {
  _RegisterPhoneTextField();

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
              if (context.mounted) context.read<LoginCubit>().registerPhoneCodeController.text = phoneCode ?? '';
            },
            readOnly: true,
            controller: context.read<LoginCubit>().registerPhoneCodeController,
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
            controller: context.read<LoginCubit>().registerPhoneNumberController,
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

@immutable
final class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: context.read<LoginCubit>().loginFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalBox24,
              _LoginUsernameTextField(),
              verticalBox12,
              const _PasswordTextField(),
              verticalBox12,
              const _ForgotPasswordTextButton(),
              verticalBox12,
              const _LoginButton(),
              verticalBox24,
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MyFilledButton(
            child: Text(LocalizationKey.login.tr(context, listen: false), style: TextStyle(color: context.colorScheme.onPrimary)),
            onPressed: () => context.read<LoginCubit>().loginButtonClick(),
          ),
        ),
      ],
    );
  }
}

final class _RegisterButton extends StatelessWidget {
  _RegisterButton();

  final overlayManager = getIt<IMyOverlayManager>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MyFilledButton(
            child: Text(LocalizationKey.register.tr(context), style: TextStyle(color: context.colorScheme.onPrimary)),
            onPressed: () {
              if (context.read<LoginCubit>().state.userAgreementValue != true) {
                overlayManager.showToast(message: LocalizationKey.userAgreementValidationMessage.tr(context, listen: false), type: ToastType.warning);
                return;
              }

              if (context.read<LoginCubit>().state.privacyAgreementValue != true) {
                overlayManager.showToast(message: LocalizationKey.confidentialityAgreementValidationMessage.tr(context, listen: false), type: ToastType.warning);
                return;
              }

              context.read<LoginCubit>().registerButtonClick();
            },
          ),
        ),
      ],
    );
  }
}

class _ForgotPasswordTextButton extends StatelessWidget {
  const _ForgotPasswordTextButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CoreTextButton(
        child: CoreText.labelMedium(LocalizationKey.forgotPassword.tr(context), textColor: context.colorScheme.primary, fontWeight: FontWeight.bold),
        onPressed: () {
          context.goNamed(RoutePaths.forgotPassswordSendOtpCode.name);
        },
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField();

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool isSend = false;

  @override
  Widget build(BuildContext context) {
    return CorePasswordTextField(
      controller: context.read<LoginCubit>().loginPasswordController,
      validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      prefixIcon: const Icon(Icons.lock_outlined),
      hintText: LocalizationKey.password.tr(context),
      maxLength: AppConstants.general.passwordLength,
      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => null,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        if (!isSend && value.length == AppConstants.general.passwordLength) {
          isSend = true;
          context.read<LoginCubit>().loginButtonClick();
        }
      },
    );
  }
}

class _RegisterPasswordTextField extends StatelessWidget {
  const _RegisterPasswordTextField();

  @override
  Widget build(BuildContext context) {
    return CorePasswordTextField(
      controller: context.read<LoginCubit>().registerPasswordController,
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

class _RegisterPasswordAgainTextField extends StatelessWidget {
  const _RegisterPasswordAgainTextField();

  @override
  Widget build(BuildContext context) {
    return CorePasswordTextField(
      controller: context.read<LoginCubit>().registerPasswordAgainController,
      validator: (value) => Validators.passwordREFieldValidator(context: context, password: context.read<LoginCubit>().registerPasswordController.text, rePassword: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      prefixIcon: const Icon(Icons.lock_outlined),
      hintText: LocalizationKey.passwordAgain.tr(context),
      keyboardType: TextInputType.number,
      maxLength: AppConstants.general.passwordLength,
      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => null,
    );
  }
}

final class _LoginUsernameTextField extends StatelessWidget {
  _LoginUsernameTextField();

  final popupManager = getIt<IMyPopupManager>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginCubit>().loginUsernameController,
      validator: (value) => Validators.mustNotBeEmptyValidator(context: context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: LocalizationKey.username.tr(context),
        prefixIcon: const Icon(Icons.person_outline),
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
      showBackButton: false,
      bottom: TabBar(
        controller: context.read<LoginCubit>().tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: context.colorScheme.primary,
        unselectedLabelColor: context.colorScheme.onSurface,
        tabs: <Widget>[
          Tab(
            icon: CoreText(LocalizationKey.login.tr(context), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Tab(
            icon: CoreText(LocalizationKey.register.tr(context), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: Assets.images.loginHeaderBg.image(
                fit: BoxFit.fill,
              ),
            ),
            Positioned.fill(child: Container(color: context.colorScheme.surface.withValues(alpha: 0.6))),
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Assets.images.launcherImage.image(width: 40),
                  ),
                  horizontalBox8,
                  CoreText.titleMedium(LocalizationKey.cleanArchitecture.tr(context), fontWeight: FontWeight.bold),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
