import Foundation
import UIKit
import ComposableArchitecture
import VersionCheckDomainInterface

@Reducer
struct IntroFeature {
    @ObservableState
    struct State {
        var backgroundImageURL: String?
        var title: String = "모놀이"
        var subTitle: String = "가족도, 친구도, 동료도 함께 즐기는 모두의 놀이"
        var isShowBanner: Bool = false
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    @CasePathable
    enum Action {
        @CasePathable
        enum Alert: Equatable {
            case updateConfirmTapped(url: String)
        }
        case appear
        case alert(PresentationAction<Alert>)
        case versionCheckResponse(AlertState<Action.Alert>?)
    }
    
    private let versionCheckUsecase: VersionCheckUsecase
    
    init(
        versionCheckUsecase: VersionCheckUsecase
    ) {
        self.versionCheckUsecase = versionCheckUsecase
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .appear:
                return .run { send in
                    let alert = await handleVersionCheck()
                    await send(.versionCheckResponse(alert))
                }
                
            case .alert(.presented(.updateConfirmTapped(let url))):
                if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
                }
                return .none

            case .alert:
                return .none
                
            case .versionCheckResponse(let alert):
                state.alert = alert
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
    
    private var appVersion: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    private func handleVersionCheck() async -> AlertState<Action.Alert>? {
        guard let version = appVersion else { return nil }
        
        let type = await versionCheckUsecase.checkVersion(version)
        
        switch type {
        case .none:
            return nil
        case .optional(let url):
            return AlertState {
                TextState("업데이트가 있습니다")
            } actions: {
                ButtonState(role: .cancel) {
                    TextState("나중에")
                }
                ButtonState(action: .updateConfirmTapped(url: url)) {
                    TextState("업데이트")
                }
            } message: {
                TextState("최신 버전으로 업데이트하면 더 안정적으로 이용할 수 있어요.")
            }
        case .required(let url):
            return AlertState {
                TextState("업데이트 필요")
            } actions: {
                ButtonState(action: .updateConfirmTapped(url: url)) {
                    TextState("업데이트")
                }
            } message: {
                TextState("최신 버전으로 반드시 업데이트해야 앱을 계속 사용할 수 있습니다.")
            }
        }
    }
}
