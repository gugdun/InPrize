import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:inprize/appodeal_key.dart';

class AdService {
  void showBanner() {
    Appodeal.show(Appodeal.BANNER_BOTTOM);
  }

  void showInterstitial() {
    Appodeal.cache(Appodeal.INTERSTITIAL);
  }

  static AdService? _instance;

  static AdService get instance => _instance!;

  static void initialize() {
    _instance ??= AdService();
    Appodeal.setAutoCache(Appodeal.INTERSTITIAL, false);
    Appodeal.setTesting(kDebugMode);
    Appodeal.setLogLevel(
      kDebugMode ? Appodeal.LogLevelDebug : Appodeal.LogLevelNone,
    );
    Appodeal.disableNetwork('notsy');
    Appodeal.disableNetwork('a4g');
    Appodeal.disableNetwork('my_target');
    Appodeal.setUseSafeArea(true);
    Appodeal.setInterstitialCallbacks(
      onInterstitialLoaded: (isPrecache) =>
          Appodeal.show(Appodeal.INTERSTITIAL),
    );
    Appodeal.initialize(
      appKey: appKey,
      adTypes: [Appodeal.INTERSTITIAL, Appodeal.BANNER],
      onInitializationFinished: (errors) => {},
    );
  }
}
