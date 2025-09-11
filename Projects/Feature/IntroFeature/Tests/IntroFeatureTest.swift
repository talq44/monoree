import ComposableArchitecture
import Testing
import VersionCheckDomainInterface

@testable import IntroFeature

@MainActor
struct IntroFeatureTests {

    @Test
    func test_필수업데이트_화면전환되지않음() async {
        let store = TestStore(
            initialState: IntroFeature.State(),
            reducer: {
                IntroFeature(
                    versionCheckUsecase: MockVersionCheckUsecase(result: .required(url: "https://dummy.url"))
                )
            }
        )
        
        let alertState = AlertState<IntroFeature.Action.Alert> {
            TextState("업데이트 필요")
        } actions: {
            ButtonState(action: .send(.updateConfirmTapped(url: "https://dummy.url"))) {
                TextState("업데이트")
            }
        } message: {
            TextState("최신 버전으로 반드시 업데이트해야 앱을 계속 사용할 수 있습니다.")
        }
        
        await store.send(.appear)
        
        await store.receive(._internalVersionCheckResponse(alertState)) { state in
            state.alert = alertState
        }
    }
}


fileprivate final class MockVersionCheckUsecase: VersionCheckUsecase {
    private let result: VersionUpdateResult
    
    init(result: VersionUpdateResult) {
        self.result = result
    }
    
    func checkVersion(_ currentVersion: String) async -> VersionUpdateResult {
        return result
    }
}
