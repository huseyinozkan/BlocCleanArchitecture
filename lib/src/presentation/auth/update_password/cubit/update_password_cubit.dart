import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/common/routing/router_service.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_password_request.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'update_password_state.dart';

@injectable
final class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit(this._authRepository) : super(const UpdatePasswordState());

  final IAuthRepository _authRepository;

  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();

  Future<void> saveButtonClick() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final request = UpdatePasswordRequest(
      oldPassword: oldPasswordController.text.trim(),
      newPassword: passwordController.text.trim(),
    );

    final response = await _authRepository.updatePassword(request: request).intercept().withIndicator();
    if (response.isSuccess) getIt<IMyRouterService>().rootRouter.pop();
  }
}
