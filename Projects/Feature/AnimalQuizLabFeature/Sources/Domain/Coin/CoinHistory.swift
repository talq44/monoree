import Foundation
import UserDefaultCoreInterface

struct CoinHistory: UserDefaultTargetType {
    typealias Value = [CoinHistoryItem]
    let key: String = "coinHistory"
}

struct CoinHistoryItem: Codable, Comparable {
    let date: Date
    let coin: Int
    
    static func < (lhs: CoinHistoryItem, rhs: CoinHistoryItem) -> Bool {
        lhs.date < rhs.date
    }
}

extension Array where Element == CoinHistoryItem {
    /// Returns items sorted by date ascending
    func sortedByDateAscending() -> [CoinHistoryItem] {
        self.sorted()
    }
    
    /// Returns items sorted by date descending
    func sortedByDateDescending() -> [CoinHistoryItem] {
        self.sorted(by: { $0.date > $1.date })
    }
}
