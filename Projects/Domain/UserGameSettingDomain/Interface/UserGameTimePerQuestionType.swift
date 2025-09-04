import Foundation

public enum UserGameTimePerQuestionType: Equatable {
    case second(Int)
    case unlimited
    
    public init?(second: Int?) {
        guard let second else { return nil }
        guard second > 0 else {
            self = .unlimited
            return
        }
        
        self = .second(second)
    }
    
    public init(second: Int) {
        guard second > 0 else {
            self = .unlimited
            return
        }
        
        self = .second(second)
    }
}
