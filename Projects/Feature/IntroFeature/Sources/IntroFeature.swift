import Foundation
import UIKit
import ComposableArchitecture
import VersionCheckDomainInterface
import RemoteConfigCoreInterface

@Reducer
struct IntroFeature {
    @ObservableState
    struct State {
        var backgroundImageURL: String?
        var title: String = "모놀이"
        var subTitle: String = "가족도, 친구도, 동료도 함께 즐길 수 있는\n모두의 놀이"
        var isShowBanner: Bool = false
        var alert: AlertState<Action>?
    }
    
    enum Action {
        case appear
        case updateAlertConfirmed(String)
        case alertDismissed
        case versionCheckResponse(AlertState<Action>?)
    }
    
    private let remoteConfig: RemoteConfigFetchManager
    private let versionCheckInteractor: VersionCheckUsecase
    
    init(
        remoteConfig: RemoteConfigFetchManager,
        versionCheckInteractor: VersionCheckUsecase
    ) {
        self.remoteConfig = remoteConfig
        self.versionCheckInteractor = versionCheckInteractor
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .appear:
                return .run { send in
                    let alert = await handleVersionCheck()
                    await send(.versionCheckResponse(alert))
                }
                
            case .updateAlertConfirmed(let url):
                if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
                }
                state.alert = nil
                return .none
                
            case .alertDismissed:
                state.alert = nil
                return .none
                
            case .versionCheckResponse(let alert):
                state.alert = alert
                return .none
            }
        }
    }
    
    private var appVersion: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    private func handleVersionCheck() async -> AlertState<Action>? {
        do {
            _ = try await remoteConfig.fetchAndActivate()
            
            guard let version = appVersion else { return nil }
            
            let type = versionCheckInteractor.checkVersion(version)
            switch type {
            case .none:
                return nil
            case .optional(let url):
                return AlertState {
                    TextState("업데이트가 있습니다")
                } actions: {
                    ButtonState(role: .cancel, action: .alertDismissed) {
                        TextState("나중에")
                    }
                    ButtonState(action: .updateAlertConfirmed(url)) {
                        TextState("업데이트")
                    }
                } message: {
                    TextState("최신 버전으로 업데이트하면 더 안정적으로 이용할 수 있어요.")
                }
            case .required(let url):
                return AlertState {
                    TextState("업데이트 필요")
                } actions: {
                    ButtonState(action: .updateAlertConfirmed(url)) {
                        TextState("업데이트")
                    }
                } message: {
                    TextState("최신 버전으로 반드시 업데이트해야 앱을 계속 사용할 수 있습니다.")
                }
            }
        } catch {
            return nil
        }
    }
}
