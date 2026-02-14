import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  // Real production IDs
  static const String _bannerAdUnitIdProd =
      'ca-app-pub-6362707004035143/3675920775';
  static const String _interstitialAdUnitIdProd =
      'ca-app-pub-6362707004035143/7263811998';

  // Test IDs
  static const String _bannerAdUnitIdTest =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _interstitialAdUnitIdTest =
      'ca-app-pub-3940256099942544/1033173712';

  String get bannerAdUnitId =>
      kDebugMode ? _bannerAdUnitIdTest : _bannerAdUnitIdProd;

  String get interstitialAdUnitId =>
      kDebugMode ? _interstitialAdUnitIdTest : _interstitialAdUnitIdProd;

  /// Banner
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print('Banner loaded'),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Banner failed: $error');
        },
      ),
    )..load();
  }

  /// Interstitial
  Future<InterstitialAd?> loadInterstitialAd() async {
    InterstitialAd? interstitialAd;

    await InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (error) {
          print('Interstitial failed: $error');
          interstitialAd = null;
        },
      ),
    );

    return interstitialAd;
  }
}
