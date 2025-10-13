import Foundation

public extension Int {
    var toString: String {
        return String(self)
    }
}

// MARK: - Formatter
public extension Int {
    /// 재사용 가능한 NumberFormatter (한 번만 생성)
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        // locale에 맞게 자동 처리하고 싶다면 위 groupingSeparator 설정을 제거하세요.
        return formatter
    }()
    
    var decimalString: String {
        return Self.numberFormatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
