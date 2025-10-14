import UIKit

public extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        let cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
            .uppercased()

        func expand(short: String) -> String? {
            switch short.count {
            case 3: // RGB
                let chars = Array(short)
                return String([chars[0], chars[0], chars[1], chars[1], chars[2], chars[2]])
            case 4: // ARGB
                let chars = Array(short)
                return String([chars[0], chars[0], chars[1], chars[1], chars[2], chars[2], chars[3], chars[3]])
            default:
                return nil
            }
        }

        let hexString: String
        switch cleaned.count {
        case 3, 4:
            guard let expanded = expand(short: cleaned) else { return nil }
            hexString = expanded
        case 6, 8:
            hexString = cleaned
        default:
            return nil
        }

        var rgba: UInt64 = 0
        guard Scanner(string: hexString).scanHexInt64(&rgba) else { return nil }

        let r, g, b, a: CGFloat
        if hexString.count == 8 {
            a = CGFloat((rgba & 0xFF00_0000) >> 24) / 255.0
            r = CGFloat((rgba & 0x00FF_0000) >> 16) / 255.0
            g = CGFloat((rgba & 0x0000_FF00) >> 8) / 255.0
            b = CGFloat(rgba & 0x0000_00FF) / 255.0
        } else {
            a = alpha
            r = CGFloat((rgba & 0x00FF_0000) >> 16) / 255.0
            g = CGFloat((rgba & 0x0000_FF00) >> 8) / 255.0
            b = CGFloat(rgba & 0x0000_00FF) / 255.0
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
