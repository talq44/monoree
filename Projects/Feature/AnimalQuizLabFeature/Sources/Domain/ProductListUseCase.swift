import Foundation
import GameEntityDomainInterface

final class ProductListUseCase {
    private let listUseCase: GameListUseCase
    private var cache: [ProductItem] = []
    
    init(listUseCase: GameListUseCase = AQLConstants.gameUseCase) {
        self.listUseCase = listUseCase
    }
    
    func fetch(category: String?, itemCategory2: String?) async throws -> [ProductItem] {
        // Return from cache if already loaded, applying filters
        if !cache.isEmpty {
            return cache.filter { item in
                let matchCategory = category.map { $0 == item.category } ?? true
                let matchSub = itemCategory2.map { $0 == item.itemCategory2 } ?? true
                return matchCategory && matchSub
            }
        }
        
        let mock = await listUseCase.fetch().map { $0.convert }
        
        // Cache and return filtered
        cache = mock
        return cache.filter { item in
            let matchCategory = category.map { $0 == item.category } ?? true
            let matchSub = itemCategory2.map { $0 == item.itemCategory2 } ?? true
            return matchCategory && matchSub
        }
    }
    
    func executePlay(
        withType: GameType,
        questionCount: Int,
        choicesCount: Int
    ) async throws -> [GameItem] {
        guard cache.count > 0 else {
            _ = try await fetch(category: nil, itemCategory2: nil)
            return try await executePlay(
                withType: withType,
                questionCount: questionCount,
                choicesCount: choicesCount
            )
        }
        
        switch withType {
        case .image, .text, .autoScroll:
            return executeCountStyle(
                withType: withType,
                items: cache,
                questionCount: questionCount,
                choicesCount: choicesCount
            )
        case .categoryDifferent:
            return executeCategory2Style(
                withType: withType,
                items: cache,
                questionCount: questionCount,
                choicesCount: choicesCount
            )
        }
    }
    
    private func executeCountStyle(
        withType: GameType,
        items: [ProductItem],
        questionCount: Int,
        choicesCount: Int
    ) -> [GameItem] {
        let selected: [ProductItem] = items.shuffled(count: questionCount)
        let choiceLimitedCount = max(0, min(choicesCount - 1, items.count - 1))
        var choices: [[ProductItem]] = []
        
        for index in 0..<questionCount {
            let answer = selected[index]
            let choicesFilter = items.filter { $0.id != answer.id }
            
            if choiceLimitedCount == choicesFilter.count {
                let shuffled = Array(choicesFilter.shuffled()) + [answer]
                choices.append(shuffled.shuffled())
            } else {
                let shuffled = Array(choicesFilter.shuffled().prefix(choiceLimitedCount)) + [answer]
                choices.append(shuffled.shuffled())
            }
        }
        
        return selected.enumerated().map {
            return GameItem(
                type: withType,
                question: $0.element,
                answer: $0.element,
                choices: choices[$0.offset]
            )
        }
    }
    
    private func executeCategory2Style(
        withType: GameType,
        items: [ProductItem],
        questionCount: Int,
        choicesCount: Int
    ) -> [GameItem] {
        let selected: [ProductItem] = items.shuffled(count: questionCount)
        var answers: [ProductItem] = []
        var choices: [[ProductItem]] = []
        
        for index in 0..<questionCount {
            let origin = selected[index]
            let originFilter = items.filter { $0.id != origin.id }
            
            let equals = originFilter.filter { $0.itemCategory2 == origin.itemCategory2 }
                .shuffled(count: choicesCount - 1)
            let notEqual = originFilter.filter { $0.itemCategory2 != origin.itemCategory2 }
                .shuffled()
                .first
            
            guard let notEqual else {
                answers.append(ProductItem(id: "", names: [], category: "", itemCategory2: ""))
                choices.append(equals)
                continue
            }
            
            answers.append(notEqual)
            choices.append((equals + [notEqual]).shuffled())
        }
        
        return selected.enumerated().map {
            return GameItem(
                type: withType,
                question: $0.element,
                answer: answers[$0.offset],
                choices: choices[$0.offset]
            )
        }
    }
}

extension Array where Element == ProductItem {
    func shuffled(count: Int) -> [ProductItem] {
        let limitedCount = Swift.max(0, Swift.min(count, self.count))
        let selected: [ProductItem]
        
        if limitedCount == self.count {
            selected = shuffled()
        } else {
            selected = Array(shuffled().prefix(limitedCount))
        }
        
        return selected
    }
}

extension GameEntity {
    var convert: ProductItem {
        return ProductItem(
            id: id,
            names: names.map({ entity in
                return .init(language: entity.languageCode, name: entity.name)
            }),
            category: categoryID,
            itemCategory2: itemCategory2ID
        )
    }
}
