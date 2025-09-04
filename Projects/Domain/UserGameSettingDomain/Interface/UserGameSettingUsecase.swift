import Foundation

public protocol UserGameSettingUsecase {
    func getConfig() async -> UserGameSettingItem
    func setQuestionCount(_ count: Int) async
    func setTimePerQuestion(_ time: UserGameTimePerQuestionType) async
    func setTeamCount(_ count: Int) async
}
