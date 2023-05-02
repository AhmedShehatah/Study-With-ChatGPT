import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../enums/interstitial_enum.dart';
import '../enums/screens_enum.dart';

class AdsManger {
  static const bool _isTestMode = false;
  static String _bannerID(ScreensEnum screen) {
    if (_isTestMode) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    if (screen == ScreensEnum.chatScreen) {
      return "ca-app-pub-7453338056341647/4345936866";
    } else if (screen == ScreensEnum.notesScreen) {
      return "ca-app-pub-7453338056341647/7522441142";
    } else {
      return "ca-app-pub-7453338056341647/7347961574";
    }
  }

  static String get _rewardID {
    if (_isTestMode) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    return "ca-app-pub-7453338056341647/4848785159";
  }

  static String _interstitialID(InterStitialEnum pos) {
    if (_isTestMode) {
      return "ca-app-pub-3940256099942544/1033173712";
    }
    if (pos == InterStitialEnum.navigation) {
      return "ca-app-pub-7453338056341647/9873272310";
    } else if (pos == InterStitialEnum.notesAdd) {
      return "ca-app-pub-7453338056341647/6481602466";
    } else if (pos == InterStitialEnum.chatSend) {
      return "ca-app-pub-7453338056341647/7980223252";
    } else {
      //agenda
      return "ca-app-pub-7453338056341647/8689797556";
    }
  }

  static BannerAd loadBannerAd(ScreensEnum screen) {
    return BannerAd(
      adUnitId: _bannerID(screen),
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  static Future<RewardedAd?> loadRewardedAd() async {
    Completer<RewardedAd?> completer = Completer<RewardedAd?>();
    await RewardedAd.load(
        adUnitId: _rewardID,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            completer.complete(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            completer.complete(null);
          },
        ));
    return completer.future;
  }

  static Future<InterstitialAd?> loadInterstitialAd(
      InterStitialEnum pos) async {
    Completer<InterstitialAd?> completer = Completer<InterstitialAd?>();
    await InterstitialAd.load(
        adUnitId: _interstitialID(pos),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            completer.complete(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            completer.complete(null);
          },
        ));
    return completer.future;
  }
}
