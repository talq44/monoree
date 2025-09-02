import Foundation

public protocol WishlistUsecase {
    func update(_ type: WishlistUpdateType) async
}
