import SwiftUI
import AdMobCore

struct BannerContentView: View {
    let navigationTitle: String
    
    // [START add_banner_to_view]
    var body: some View {
        Spacer()
        // Request an anchored adaptive banner with a width of 375.
        BannerViewContainer(375, adUnitID: "ca-app-pub-3940256099942544/2435281174")
            .navigationTitle(navigationTitle)
        // [END_EXCLUDE]
    }
    // [END add_banner_to_view]
}

struct BannerContentView_Previews: PreviewProvider {
    static var previews: some View {
        BannerContentView(navigationTitle: "Banner")
    }
}
