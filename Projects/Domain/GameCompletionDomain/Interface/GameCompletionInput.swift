import Foundation

public protocol GameCompletionInput {
    var score: Int { get }
    var gameName: String { get }
}

//public struct GameCompletionInput {
//    public let score: Int
//    public let gameName: String
//    
//    public init(score: Int, gameName: String) {
//        self.score = score
//        self.gameName = gameName
//    }
//}
