import 'package:bloc_clean_architecture/src/data/model/response/culture_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/response/user_dto.dart';
import 'package:flutter_core/flutter_core.dart';

enum SharedPrefKeys implements BaseSharedPrefKeys {
  /// This is [UserDto] Object and it is encrypted
  userCredentials(encrypt: true),

  /// This is [CultureDto]
  culture,

  /// This is [String]
  loginPhoneCode,

  /// This is [String]
  username,
  ;

  const SharedPrefKeys({this.encrypt = false});

  @override
  final bool encrypt;

  @override
  String get keyName => name;
}
