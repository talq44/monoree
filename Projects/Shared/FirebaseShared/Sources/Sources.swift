import Foundation
import Firebase
import FirebaseSharedInterface

public class FirebaseService: FirebaseServiceProtocol {
    private var isConfiguredFlag = false
    
    public init() {}
    
    public func configure() {
        guard !isConfiguredFlag else { return }
        
        FirebaseApp.configure()
        isConfiguredFlag = true
        print("Firebase configured successfully")
    }
    
    public func isConfigured() -> Bool {
        return isConfiguredFlag
    }
}
