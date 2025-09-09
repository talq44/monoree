import SwiftUI

public struct IntroView: View {
    public init() {}
    public var body: some View {
        ZStack {
            VStack {
                Image(asset: IntroFeatureAsset.intro)
                    .resizable(capInsets: EdgeInsets(top: 16.0, leading: 16.0, bottom: 16.0, trailing: 16.0))
                    .aspectRatio(contentMode: .fit)
                    .padding(.all)
            }            
            VStack {
                Spacer()
                Text("광고 영역")
                    .padding(50)
            }
        }
    }
}

#Preview {
    IntroView()
}
