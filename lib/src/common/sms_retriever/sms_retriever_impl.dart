import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

final class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl();

  @override
  Future<void> dispose() async {
    await SmartAuth.instance.removeUserConsentApiListener();
    await SmartAuth.instance.removeSmsRetrieverApiListener();
  }

  @override
  Future<String?> getSmsCode() async {
    await SmartAuth.instance.getAppSignature();
    final result = await SmartAuth.instance.getSmsWithUserConsentApi();
    return result.data?.code;
  }

  @override
  bool get listenForMultipleSms => false;
}
