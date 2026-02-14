import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Core/ad_service.dart';


class AdProvider extends ChangeNotifier {
  final AdService _adService;

  BannerAd? bannerAd;
  InterstitialAd? _interstitialAd;

  bool _isInterstitialLoading = false;

  AdProvider(this._adService) {
    loadBanner();
    loadInterstitial(); // Preload
  }

  void loadBanner() {
    bannerAd = _adService.createBannerAd();
    notifyListeners();
  }

  Future<void> loadInterstitial() async {
    if (_isInterstitialLoading) return;

    _isInterstitialLoading = true;
    _interstitialAd = await _adService.loadInterstitialAd();
    _isInterstitialLoading = false;
  }

  void showInterstitial() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      loadInterstitial(); // preload next
    } else {
      print("Interstitial not ready");
    }
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }
}
