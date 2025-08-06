import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsService {
  static BannerAd? _bannerAd;
  static InterstitialAd? _interstitialAd;
  static AppOpenAd? _appOpenAd;

  static String bannerAdUnitId = 'ca-app-pub-2273231841018440/7668512461';
  static String interstitialAdUnitId = 'ca-app-pub-2273231841018440/1498674027';
  static String appOpenAdUnitId = 'ca-app-pub-2273231841018440/7229528764';

  /// Initialize AdMob
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  /// Load and show banner ad
  static BannerAd loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(),
    )..load();
    return _bannerAd!;
  }

  /// Load and show interstitial ad
  static void loadInterstitialAd({required Function() onAdClosed}) {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              onAdClosed();
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              onAdClosed();
              ad.dispose();
            },
          );
          _interstitialAd!.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          onAdClosed(); // Fallback if ad fails
        },
      ),
    );
  }

  /// Load App Open Ad
  static void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: appOpenAdUnitId,
      request: AdRequest(),
      orientation: AppOpenAd.orientationPortrait,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  /// Show App Open Ad
  static void showAppOpenAdIfAvailable() {
    if (_appOpenAd != null) {
      _appOpenAd!.show();
      _appOpenAd = null;
    }
  }
} 