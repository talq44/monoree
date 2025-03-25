import Foundation

public enum GamePlayType {
    case singleImage(url: String, answer: String)
    case singleText(text: String, answer: String)
}
