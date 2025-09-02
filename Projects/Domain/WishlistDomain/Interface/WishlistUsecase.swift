import Foundation

public protocol WishlistUsecase {
    var changed: AsyncStream<WishlistUpdateType> { get }
    
    /// 우선은 ID만 돌려준다.
    func get() async throws(WishlistError) -> [String]
    func update(_ type: WishlistUpdateType) async throws(WishlistError)
}
