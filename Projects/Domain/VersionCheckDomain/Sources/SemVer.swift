import Foundation

struct SemVer: Comparable {
    let major: Int
    let minor: Int
    let patch: Int

    init(_ string: String) {
        // Accept "1", "1.2", "1.2.3" and tolerate suffixes like "1.2.3-beta"
        let tokens = string.split(separator: ".")
        func number(from token: Substring?) -> Int {
            guard let token = token else { return 0 }
            let digits = token.prefix { $0.isNumber }
            return Int(digits) ?? 0
        }
        self.major = number(from: tokens.count > 0 ? tokens[0] : nil)
        self.minor = number(from: tokens.count > 1 ? tokens[1] : nil)
        self.patch = number(from: tokens.count > 2 ? tokens[2] : nil)
    }

    static func < (lhs: SemVer, rhs: SemVer) -> Bool {
        if lhs.major != rhs.major { return lhs.major < rhs.major }
        if lhs.minor != rhs.minor { return lhs.minor < rhs.minor }
        return lhs.patch < rhs.patch
    }
}
