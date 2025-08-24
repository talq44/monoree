import FirebaseCore
import FirebaseSharedInterface
import Foundation

public class FirebaseService: FirebaseServiceProtocol {
    private var isConfiguredFlag = false
    
    public init() {}
    
    public func configure() {
        // 테스트 환경(XCTest)에서는 Firebase 초기화를 생략합니다.
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return
        }
        
        let firebaseService = FirebaseService()
        // 여러 인스턴스에서도 중복 초기화를 방지하도록 플래그 검사
        if !firebaseService.isConfigured() {
            firebaseService.configure()
        }
    }
    
    public func isConfigured() -> Bool {
        return isConfiguredFlag
    }
}
