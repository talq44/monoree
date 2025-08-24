import Foundation

public protocol FirebaseServiceProtocol {
  func configure()
  func isConfigured() -> Bool
}
