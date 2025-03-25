import Foundation

public enum GamePlayType: Equatable {
    case singleImage(url: String, answer: String)
    case singleText(text: String, answer: String)
}
