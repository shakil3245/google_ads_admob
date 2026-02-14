import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Core/ad_service.dart';


class AdProvider extends ChangeNotifier {
  final AdService _adService;

  BannerAd? bannerAd;
  InterstitialAd? _interstitialAd;

  bool _isInterstitialLoading = false;
  bool isInterstitialReady = false; // New flag

  AdProvider(this._adService) {
    loadBanner();
    loadInterstitial(); // preload
  }

  void loadBanner() {
    bannerAd = _adService.createBannerAd();
    notifyListeners();
  }

  Future<void> loadInterstitial() async {
    if (_isInterstitialLoading) return;
    _isInterstitialLoading = true;
    isInterstitialReady = false;

    _interstitialAd = await _adService.loadInterstitialAd();
    _isInterstitialLoading = false;

    if (_interstitialAd != null) {
      isInterstitialReady = true;
      notifyListeners();
    }
  }

  void showInterstitial() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      isInterstitialReady = false;
      notifyListeners();
      loadInterstitial(); // preload next
    } else {
      print("Interstitial not ready");
      loadInterstitial(); // try loading again
    }
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }
}
