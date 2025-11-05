import Foundation

final class ProductListUseCase {
    private var cache: [GameItem] = []
    
    func fetch(category: String?, itemCategory2: String?) async throws -> [GameItem] {
        return []
    }
    
    func executePlay(withType: GameType, count: Int) async throws -> [GameItem] {
        guard cache.count > 0 else {
            _ = try await fetch(category: nil, itemCategory2: nil)
            return try await executePlay(withType: withType, count: count)
        }
        
        return []
    }
    
    private func executeImagePlay(items: [GameItem], count: Int) -> [GameItem] {
        
    }
}
