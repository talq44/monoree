import Foundation
import UIKit
import ComposableArchitecture
import VersionCheckDomainInterface

@Reducer
struct IntroFeature {
    private enum Constants {
        static let delayTimeInterval: TimeInterval = 2
    }
    
    @ObservableState
    struct State: Equatable {
        var backgroundImageURL: String?
        var title: String = "모놀이"
        var subTitle: String = "가족도, 친구도, 동료도 함께 즐기는 모두의 놀이"
        var isShowBanner: Bool = false
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    @CasePathable
    enum Action: Equatable {
        @CasePathable
        enum Alert: Equatable {
            case cancelTapped
            case updateConfirmTapped(url: String)
        }
        enum Delegate {
            case finished
        }
        case appear
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        case _internalVersionCheckResponse(AlertState<Action.Alert>?)
    }
    
    @Dependency(\.continuousClock) var clock
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
                    await send(._internalVersionCheckResponse(alert))
                }
                
            case ._internalVersionCheckResponse(let alert):
                state.alert = alert
                if alert == nil {
                    return .run { send in
                        try await self.clock.sleep(for: .seconds(Constants.delayTimeInterval))
                        await send(.delegate(.finished))
                    }
                }
                return .none
                
            case .alert(.presented(.updateConfirmTapped(let url))):
                if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
                }
                return .none
                
            case .alert(.presented(.cancelTapped)), .alert(.dismiss):
                 return .run { send in
                    try await self.clock.sleep(for: .seconds(Constants.delayTimeInterval))
                    await send(.delegate(.finished))
                }

            case .alert, .delegate:
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
                ButtonState(role: .cancel, action: .send(.cancelTapped)) {
                    TextState("나중에")
                }
                ButtonState(action: .send(.updateConfirmTapped(url: url))) {
                    TextState("업데이트")
                }
            } message: {
                TextState("최신 버전으로 업데이트하면 더 안정적으로 이용할 수 있어요.")
            }
        case .required(let url):
            return AlertState {
                TextState("업데이트 필요")
            } actions: {
                ButtonState(action: .send(.updateConfirmTapped(url: url))) {
                    TextState("업데이트")
                }
            } message: {
                TextState("최신 버전으로 반드시 업데이트해야 앱을 계속 사용할 수 있습니다.")
            }
        }
    }
}
