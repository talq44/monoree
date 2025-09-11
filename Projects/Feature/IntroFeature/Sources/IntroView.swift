import SwiftUI
import ComposableArchitecture
import VersionCheckDomainInterface

struct IntroView: View {
    @Bindable var store: StoreOf<IntroFeature>
    
    init(store: StoreOf<IntroFeature>) {
        self.store = store
    }
    
    var body: some View {
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
        .onAppear {
            store.send(.appear)
        }
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    struct VersionCheckUsecaseMock: VersionCheckUsecase {
        func checkVersion(_ currentVersion: String) async -> VersionUpdateResult {
            return .optional(url: "https://www.apple.com")
        }
    }
    
    return IntroView(
        store: .init(
            initialState: .init(),
            reducer: {
                IntroFeature(versionCheckUsecase: VersionCheckUsecaseMock())
            }
        )
    )
}
