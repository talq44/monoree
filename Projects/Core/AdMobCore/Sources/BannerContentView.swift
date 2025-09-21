import SwiftUI
import GoogleMobileAds

// [START create_banner_view]
struct BannerViewContainer: UIViewRepresentable {
    typealias UIViewType = BannerView
    let adSize: AdSize
    let adUnitID: String
    
    init(
        _ width: CGFloat,
        adUnitID: String
    ) {
        self.adSize = currentOrientationAnchoredAdaptiveBanner(width: width)
        self.adUnitID = adUnitID
    }
    
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: adSize)
        // [START load_ad]
        banner.adUnitID = adUnitID
        banner.load(Request())
        // [END load_ad]
        // [START set_delegate]
        banner.delegate = context.coordinator
        // [END set_delegate]
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}
    
    func makeCoordinator() -> BannerCoordinator {
        return BannerCoordinator(self)
    }
    // [END create_banner_view]
    
    class BannerCoordinator: NSObject, BannerViewDelegate {
        
        let parent: BannerViewContainer
        
        init(_ parent: BannerViewContainer) {
            self.parent = parent
        }
        
        // MARK: - GADBannerViewDelegate methods
        
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("DID RECEIVE AD.")
        }
        
        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("FAILED TO RECEIVE AD: \(error.localizedDescription)")
        }
    }
}

#Preview {
    BannerViewContainer(375, adUnitID: "ca-app-pub-3940256099942544/2435281174")
}
