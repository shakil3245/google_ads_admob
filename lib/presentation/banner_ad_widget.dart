import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_providers.dart';

class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdProvider>();

    if (provider.bannerAd == null) {
      return const SizedBox();
    }

    return SizedBox(
      width: provider.bannerAd!.size.width.toDouble(),
      height: provider.bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: provider.bannerAd!),
    );
  }
}
