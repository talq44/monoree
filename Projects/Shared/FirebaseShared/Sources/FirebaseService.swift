import Foundation
import FirebaseCore
import FirebaseSharedInterface

public class FirebaseService: FirebaseServiceProtocol {
    public init() {}
    
    public func configure() {
        // 테스트 환경(XCTest)에서는 Firebase 초기화를 생략합니다.
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return
        }
        
        // 이미 구성되어 있으면 즉시 반환 (외부에서 선행 구성된 경우 포함)
        guard FirebaseApp.app() == nil else { return }
        FirebaseApp.configure()
#if DEBUG
        print("Firebase configured successfully")
#endif
    }
}
