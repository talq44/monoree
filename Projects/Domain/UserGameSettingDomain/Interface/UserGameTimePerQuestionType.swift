import Foundation

public enum UserGameTimePerQuestionType: Equatable {
    case second(Int)
    case unlimited
    
    public init?(second: Int?) {
        guard let second else { return nil }
        
        self = .second(second)
    }
    
    public init(second: Int) {
        self = .second(second)
    }
}
