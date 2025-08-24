import Foundation

public protocol FirebaseServiceProtocol {
    func configure()
    func isConfigured() -> Bool
}

public extension FirebaseServiceProtocol {
    func configure() {
        // Default implementation
    }
    
    func isConfigured() -> Bool {
        return false
    }
}
