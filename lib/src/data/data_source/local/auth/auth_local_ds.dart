import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_pref_keys.dart';
import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_prefences_manager.dart';
import 'package:bloc_clean_architecture/src/data/model/response/login_response.dart';
import 'package:injectable/injectable.dart';

abstract interface class IAuthLocalDS {
  LoginResponse? getUserCredentials();
  Future<bool> setUserCredentials({required LoginResponse userCredentials});
  Future<bool> deleteUserCredentials();

  String? getLoginPhoneCode();
  Future<bool> setLoginPhoneCode({required String phoneCode});
  Future<bool> deleteLoginPhoneCode();

  String? getLoginUsername();
  Future<bool> setLoginUsername({required String phone});
  Future<bool> deleteLoginUsername();
}

@LazySingleton(as: IAuthLocalDS)
final class AuthLocalDS implements IAuthLocalDS {
  const AuthLocalDS(this._pref);

  final SharedPreferencesManager _pref;

  @override
  LoginResponse? getUserCredentials() => _pref.getObject<LoginResponse>(key: SharedPrefKeys.userCredentials, model: const LoginResponse());
  @override
  Future<bool> setUserCredentials({required LoginResponse userCredentials}) => _pref.setObject<LoginResponse>(key: SharedPrefKeys.userCredentials, value: userCredentials);
  @override
  Future<bool> deleteUserCredentials() => _pref.remove(key: SharedPrefKeys.userCredentials);

  @override
  String? getLoginPhoneCode() => _pref.getString(key: SharedPrefKeys.loginPhoneCode);
  @override
  Future<bool> setLoginPhoneCode({required String phoneCode}) => _pref.setString(key: SharedPrefKeys.loginPhoneCode, value: phoneCode);
  @override
  Future<bool> deleteLoginPhoneCode() => _pref.remove(key: SharedPrefKeys.loginPhoneCode);

  @override
  String? getLoginUsername() => _pref.getString(key: SharedPrefKeys.username);
  @override
  Future<bool> setLoginUsername({required String phone}) => _pref.setString(key: SharedPrefKeys.username, value: phone);
  @override
  Future<bool> deleteLoginUsername() => _pref.remove(key: SharedPrefKeys.username);
}
