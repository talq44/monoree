import Foundation

public protocol GameCompletionUseCase {
    func completeGame(
        _ input: any GameCompletionInput
    ) async -> GameCompletionResultType
}
