import Foundation
import UserDefaultCoreInterface

struct CoinUseHistory: UserDefaultTargetType {
    typealias Value = [CoinUseHistoryItem]
    let key: String = "coinUseHistory"
}

struct CoinUseHistoryItem: Codable, Comparable {
    let date: Date
    let coin: Int
    
    static func < (lhs: CoinUseHistoryItem, rhs: CoinUseHistoryItem) -> Bool {
        lhs.date < rhs.date
    }
}

extension Array where Element == CoinUseHistoryItem {
    /// Returns items sorted by date ascending
    func sortedByDateAscending() -> [CoinUseHistoryItem] {
        self.sorted()
    }
    
    /// Returns items sorted by date descending
    func sortedByDateDescending() -> [CoinUseHistoryItem] {
        self.sorted(by: { $0.date > $1.date })
    }
}
