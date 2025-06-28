import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

abstract class Validators {
  static String? passwordFieldValidator({required BuildContext context, required String? value}) {
    if (value == null || value.isEmpty) {
      return LocalizationKey.fieldRequired.tr(context, listen: false);
    }
    if (value.length < 4) {
      return LocalizationKey.passwordMustBeAtLeastFourCharacters.tr(context, listen: false);
    }
    return null;
  }

  static String? passwordREFieldValidator({required BuildContext context, required String? password, required String? rePassword}) {
    if (rePassword == null || rePassword.isEmpty) {
      return LocalizationKey.fieldRequired.tr(context, listen: false);
    }
    if (password != rePassword) {
      return LocalizationKey.passwordsDoNotMatch.tr(context, listen: false);
    }
    return null;
  }

  static String? mustNotBeEmptyValidator({required BuildContext context, required String? value}) {
    if (value == null || value.isEmpty) {
      return LocalizationKey.fieldRequired.tr(context, listen: false);
    }
    return null;
  }

  static String? emailFieldValidator({required BuildContext context, required String? value}) {
    if (value.isNull || value!.isEmpty) {
      return LocalizationKey.fieldRequired.tr(context, listen: false);
    }
    if (!value.isEmail) {
      return LocalizationKey.enterValidEmail.tr(context, listen: false);
    }
    return null;
  }

  static String? mustNotBeEmptyAndNotBeZeroValidator({required BuildContext context, required String? value}) {
    if (value == null || value.isEmpty) {
      return LocalizationKey.thisFieldIsRequired.tr(context, listen: false);
    }

    if ((double.tryParse(value.replaceAll(',', '.')) ?? 0) == 0) {
      return LocalizationKey.validationMustBeGreaterThanZero.tr(context, listen: false);
    }
    return null;
  }

  static String? securityCodeFieldValidator({required BuildContext context, required String? value}) {
    if (value == null || value.isEmpty) {
      return LocalizationKey.fieldRequired.tr(context, listen: false);
    }
    if (value.length < 6) {
      return LocalizationKey.securityCodeMustBeAtLeastSixCharacters.tr(context, listen: false);
    }
    return null;
  }

  static String? currencyFieldValidator({required BuildContext context, required String? value}) {
    if (value == null || value.isEmpty) {
      return LocalizationKey.thisFieldIsRequired.tr(context, listen: false);
    }

    if ((double.tryParse(value.replaceAll(',', '.')) ?? 0) == 0) {
      return LocalizationKey.validationMustBeGreaterThanZero.tr(context, listen: false);
    }

    if ((double.tryParse(value.replaceAll(',', '.')) ?? 0) >= 100000000) {
      return LocalizationKey.validationMustBeLessThanOneHundredMillion.tr(context, listen: false);
    }
    return null;
  }
}
