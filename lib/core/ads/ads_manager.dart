import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

class AdsManger {
  static const bool _isTestMode = true;
  static String get _bannerID {
    if (_isTestMode) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return "ca-app-pub-7453338056341647/4345936866";
  }

  static String get _rewardID {
    if (_isTestMode) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    return "ca-app-pub-7453338056341647/4848785159";
  }

  static BannerAd loadBannerAd() {
    return BannerAd(
      adUnitId: _bannerID,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {},
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    )..load();
  }

  static Future<RewardedAd?> loadRewardedAd() async {
    Completer<RewardedAd?> completer = Completer<RewardedAd?>();
    await RewardedAd.load(
        adUnitId: _rewardID,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            // Keep a reference to the ad so you can show it later.
            completer.complete(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            completer.complete(null);
          },
        ));
    return completer.future;
  }
}
