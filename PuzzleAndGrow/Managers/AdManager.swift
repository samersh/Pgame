
import Foundation
import GoogleMobileAds

class AdManager: NSObject, FullScreenContentDelegate {

    static let shared = AdManager()

    private var rewardedAd: RewardedAd?

    private override init() {
        super.init()
    }

    func loadRewardedAd() {
        let request = Request()
        RewardedAd.load(with: "ca-app-pub-3940256099942544/1712485313", // Test Ad Unit ID
                        request: request) { (ad, error) in
            if let error = error {
                print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                return
            }
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
    }

    func showRewardedAd(from viewController: UIViewController, rewardFunction: @escaping () -> Void) {
        if let ad = rewardedAd {
            ad.present(from: viewController) {
                rewardFunction()
            }
        } else {
            print("Rewarded ad is not ready yet.")
        }
    }

    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        loadRewardedAd()
    }
}
