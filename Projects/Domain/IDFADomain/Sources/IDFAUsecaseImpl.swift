import Foundation
import IDFADomainInterface
import AnalyticsCoreInterface
import LocalDataCoreInterface
import Security
import AdSupport
import AppTrackingTransparency

/// 로컬 저장 키
private enum LocalKeys {
    static let idfaAllowedAt = "monoree.idfa.allowedAt"   // Date ISO8601 string
    static let gameCheckExemptUntil = "monoree.gamecheck.exemptUntil" // Date ISO8601 string
}

/// 단순 Date <-> String 포맷터
private let iso8601: ISO8601DateFormatter = {
    let f = ISO8601DateFormatter()
    f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return f
}()

/// GameCheck 면제 알림 브로드캐스트 (로컬 통신용)
public extension Notification.Name {
    static let gameCheckExemptUpdated = Notification.Name("monoree.gamecheck.exemptUpdated")
}

final actor IDFAUsecaseImpl: IDFAUsecase {
    private let keychainService = "com.monoree.idfa"
    private let keychainAccount = "advertisingIdentifier"
    private let localData: LocalDataCoreInterface.ConfigLocalDataManager
    
    public init(localData: LocalDataCoreInterface.ConfigLocalDataManager) {
        self.localData = localData
    }
    
    /// 기존 프로토콜 호환용: 허용 시 현재 IDFA, 미허용 시 빈 문자열
    func idfa() async -> IDFAResult {
        let allowed = await checkPermission()
        
        guard allowed, let idfa = getSystemIDFA() else {
            return .notAllowed
        }
        
        await localData.setIDFA(idfa)
        
        guard hasKeychainHistory(idfa: idfa) else {
            await localData.setFirstAllowedIDFADate()
            return .new(id: idfa)
        }
        
        return .before(id: idfa)
    }
    
    private func checkPermission() async -> Bool {
        let current = ATTrackingManager.trackingAuthorizationStatus
        if current == .authorized { return true }
        guard current == .notDetermined else { return false }

        let granted: Bool = await withCheckedContinuation { (cont: CheckedContinuation<Bool, Never>) in
            DispatchQueue.main.async {
                ATTrackingManager.requestTrackingAuthorization { status in
                    cont.resume(returning: status == .authorized)
                }
            }
        }
        
        return granted
    }
    
    private func getSystemIDFA() -> String? {
        let manager = ASIdentifierManager.shared()
        let id = manager.advertisingIdentifier.uuidString
        
        guard id != "00000000-0000-0000-0000-000000000000" else { return nil }
        
        return id
    }

    private func hasKeychainHistory(idfa: String) -> Bool {
        // 키체인에서 과거 값 확인
        let previous: String? = {
            guard let data = Keychain.read(service: keychainService, account: keychainAccount),
                  let str = String(data: data, encoding: .utf8),
                  str.isEmpty == false else { return nil }
            return str
        }()
        
        guard let previous else {
            Keychain.write(service: keychainService, account: keychainAccount, data: Data(idfa.utf8))
            return false
        }
        
        guard previous != "00000000-0000-0000-0000-000000000000" else {
            return false
        }
         
        return true
    }
}
