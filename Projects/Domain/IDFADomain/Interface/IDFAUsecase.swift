import Foundation

public protocol IDFAUsecase {
    func idfa() async -> String
}
