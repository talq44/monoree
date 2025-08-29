import Foundation

public protocol GameConfigDTO: Decodable {
    var gamePlaysPerAd: Int { get }
}
