import 'package:flutter_core/flutter_core.dart';

final class RemoteConfigRetriable extends Retriable<void> {
  RemoteConfigRetriable({super.maxRetries, super.delayMultiplier});

  @override
  Future<void> retryCallback() {
    return FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: 1.minutes,
        minimumFetchInterval: 0.seconds,
      ),
    );
  }
}
