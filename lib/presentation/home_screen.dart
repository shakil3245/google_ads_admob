import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ad_providers.dart';
import 'banner_ad_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adProvider = context.read<AdProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Ads App")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Hello Flutter Ads",
              style: TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final adProvider = context.read<AdProvider>();
              adProvider.showInterstitial(); // only shows if already loaded
              // Optionally preload next interstitial inside showInterstitial
            },
            child: Text('Show Interstitial Ad'),
          ),
          const Spacer(),
          const BannerAdWidget(),
        ],
      ),
    );
  }
}
