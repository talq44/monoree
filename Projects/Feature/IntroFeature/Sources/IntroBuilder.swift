import SwiftUI
import ComposableArchitecture
import VersionCheckDomainInterface

public struct IntroBuilder {
    public static func build(usecase: VersionCheckUsecase) -> some View {
        let store = Store(
            initialState: IntroFeature.State(),
            reducer: { IntroFeature(versionCheckUsecase: usecase) }
        )
        return IntroView(store: store)
    }
}
