import Foundation

public protocol SearchListUseCase {
    func execute(
        _ input: SearchListInput
    ) async -> Result<SearchListOutput, SearchListError>
}
