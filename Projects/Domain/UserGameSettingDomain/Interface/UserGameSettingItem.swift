import Foundation

public struct UserGameSettingItem {
    /// 문제 갯수 (3, 5, 10, 20)
    public let questionCount: Int
    /// 문제 당 시간(1초, 3초, 5초, 10초, 제한없음)
    public let timePerQuestion: UserGameTimePerQuestionType
    /// 전체 문제 목록의 갯수
    public let teamCount: Int
    
    public init(
        questionCount: Int,
        timePerQuestion: UserGameTimePerQuestionType,
        teamCount: Int
    ) {
        self.questionCount = questionCount
        self.timePerQuestion = timePerQuestion
        self.teamCount = teamCount
    }
}
