import SwiftUI
import AdMobCore

struct BannerContentView: View {
    private enum Metric {
        static let heightScale: CGFloat = 50 / 320
    }
    
    let navigationTitle: String
    
    // [START add_banner_to_view]
    var body: some View {
        GeometryReader { geometry in
            Spacer()
            BannerViewContainer(geometry.size.width, adUnitID: "ca-app-pub-3940256099942544/2435281174")
                .frame(width: geometry.size.width, height: geometry.size.width * Metric.heightScale)
                .navigationTitle(navigationTitle)
        }
        // [END_EXCLUDE]
    }
    // [END add_banner_to_view]
}

struct BannerContentView_Previews: PreviewProvider {
    static var previews: some View {
        BannerContentView(navigationTitle: "Banner")
    }
}
