import SwiftUI
import ComposableArchitecture
import VersionCheckDomainInterface

public struct IntroView: View {
    let store: StoreOf<IntroFeature>
    
    public init(store: StoreOf<IntroFeature>) {
        self.store = store
    }
    
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
        .onAppear {
            store.send(.appear)
        }
    }
}

#Preview {
    struct VersionCheckUsecaseMock: VersionCheckUsecase {
        func checkVersion(_ currentVersion: String) async -> VersionUpdateResult {
            return .none
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
