import 'package:bloc_clean_architecture/src/common/constants/env.dart';
import 'package:encrypt/encrypt.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class EncrytionManager {
  EncrytionManager() {
    _encrypter = Encrypter(AES(Key.fromUtf8(_encryptionKey), mode: AESMode.cbc));
  }

  late final Encrypter _encrypter;

  String get _encryptionKey => Env.encryptionKey;
  String get _encryptionIv => Env.encryptionIv;
  IV get _encIv => IV.fromBase64(_encryptionIv);

  Encrypted encryptBytes(List<int> input) => _encrypter.encryptBytes(input, iv: _encIv);

  Encrypted encrypt(String input) => _encrypter.encrypt(input, iv: _encIv);

  List<int> decryptBytes(Encrypted encrypted) => _encrypter.decryptBytes(encrypted, iv: _encIv);

  String decrypt(Encrypted input) => _encrypter.decrypt(input, iv: _encIv);

  String decrypt16(String input) => _encrypter.decrypt16(input, iv: _encIv);

  String decrypt64(String input) => _encrypter.decrypt64(input, iv: _encIv);
}
