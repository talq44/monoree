import Foundation

final class ProductListUseCase {
    private var cache: [ProductItem] = []
    
    func fetch(category: String?, itemCategory2: String?) async throws -> [ProductItem] {
        // Return from cache if already loaded, applying filters
        if !cache.isEmpty {
            return cache.filter { item in
                let matchCategory = category.map { $0 == item.category } ?? true
                let matchSub = itemCategory2.map { $0 == item.itemCategory2 } ?? true
                return matchCategory && matchSub
            }
        }
        
        let mock = mockData()
        
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

extension ProductListUseCase {
    private func mockData() -> [ProductItem] {
        let baseCategory = "동물"
        let mock: [ProductItem] = [
            ProductItem(
                id: "dog",
                names: [
                    ProductItem.Name(language: "en", name: "Dog"),
                    ProductItem.Name(language: "ko", name: "개"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "cat",
                names: [
                    ProductItem.Name(language: "en", name: "Cat"),
                    ProductItem.Name(language: "ko", name: "고양이"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "elephant",
                names: [
                    ProductItem.Name(language: "en", name: "Elephant"),
                    ProductItem.Name(language: "ko", name: "코끼리"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "lion",
                names: [
                    ProductItem.Name(language: "en", name: "Lion"),
                    ProductItem.Name(language: "ko", name: "사자"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "tiger",
                names: [
                    ProductItem.Name(language: "en", name: "Tiger"),
                    ProductItem.Name(language: "ko", name: "호랑이"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "giraffe",
                names: [
                    ProductItem.Name(language: "en", name: "Giraffe"),
                    ProductItem.Name(language: "ko", name: "기린"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "bear",
                names: [
                    ProductItem.Name(language: "en", name: "Bear"),
                    ProductItem.Name(language: "ko", name: "곰"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "wolf",
                names: [
                    ProductItem.Name(language: "en", name: "Wolf"),
                    ProductItem.Name(language: "ko", name: "늑대"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "dolphin",
                names: [
                    ProductItem.Name(language: "en", name: "Dolphin"),
                    ProductItem.Name(language: "ko", name: "돌고래"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "whale",
                names: [
                    ProductItem.Name(language: "en", name: "Whale"),
                    ProductItem.Name(language: "ko", name: "고래"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            
            ProductItem(
                id: "eagle",
                names: [
                    ProductItem.Name(language: "en", name: "Eagle"),
                    ProductItem.Name(language: "ko", name: "독수리"),
                ],
                category: baseCategory,
                itemCategory2: "조류"
            ),
            ProductItem(
                id: "sparrow",
                names: [
                    ProductItem.Name(language: "en", name: "Sparrow"),
                    ProductItem.Name(language: "ko", name: "참새"),
                ],
                category: baseCategory,
                itemCategory2: "조류"
            ),
            ProductItem(
                id: "penguin",
                names: [
                    ProductItem.Name(language: "en", name: "Penguin"),
                    ProductItem.Name(language: "ko", name: "펭귄"),
                ],
                category: baseCategory,
                itemCategory2: "조류"
            ),
            ProductItem(
                id: "owl",
                names: [
                    ProductItem.Name(language: "en", name: "Owl"),
                    ProductItem.Name(language: "ko", name: "부엉이"),
                ],
                category: baseCategory,
                itemCategory2: "조류"
            ),
            ProductItem(
                id: "flamingo",
                names: [
                    ProductItem.Name(language: "en", name: "Flamingo"),
                    ProductItem.Name(language: "ko", name: "플라밍고"),
                ],
                category: baseCategory,
                itemCategory2: "조류"
            ),
            
            ProductItem(
                id: "crocodile",
                names: [
                    ProductItem.Name(language: "en", name: "Crocodile"),
                    ProductItem.Name(language: "ko", name: "악어"),
                ],
                category: baseCategory,
                itemCategory2: "파충류"
            ),
            ProductItem(
                id: "snake",
                names: [
                    ProductItem.Name(language: "en", name: "Snake"),
                    ProductItem.Name(language: "ko", name: "뱀"),
                ],
                category: baseCategory,
                itemCategory2: "파충류"
            ),
            ProductItem(
                id: "turtle",
                names: [
                    ProductItem.Name(language: "en", name: "Turtle"),
                    ProductItem.Name(language: "ko", name: "거북이"),
                ],
                category: baseCategory,
                itemCategory2: "파충류"
            ),
            
            ProductItem(
                id: "frog",
                names: [
                    ProductItem.Name(language: "en", name: "Frog"),
                    ProductItem.Name(language: "ko", name: "개구리"),
                ],
                category: baseCategory,
                itemCategory2: "양서류"
            ),
            ProductItem(
                id: "salamander",
                names: [
                    ProductItem.Name(language: "en", name: "Salamander"),
                    ProductItem.Name(language: "ko", name: "도롱뇽"),
                ],
                category: baseCategory,
                itemCategory2: "양서류"
            ),
            
            ProductItem(
                id: "shark",
                names: [
                    ProductItem.Name(language: "en", name: "Shark"),
                    ProductItem.Name(language: "ko", name: "상어"),
                ],
                category: baseCategory,
                itemCategory2: "어류"
            ),
            ProductItem(
                id: "clownfish",
                names: [
                    ProductItem.Name(language: "en", name: "Clownfish"),
                    ProductItem.Name(language: "ko", name: "흰동가리"),
                ],
                category: baseCategory,
                itemCategory2: "어류"
            ),
            ProductItem(
                id: "salmon",
                names: [
                    ProductItem.Name(language: "en", name: "Salmon"),
                    ProductItem.Name(language: "ko", name: "연어"),
                ],
                category: baseCategory,
                itemCategory2: "어류"
            ),
            
            ProductItem(
                id: "butterfly",
                names: [
                    ProductItem.Name(language: "en", name: "Butterfly"),
                    ProductItem.Name(language: "ko", name: "나비"),
                ],
                category: baseCategory,
                itemCategory2: "곤충"
            ),
            ProductItem(
                id: "bee",
                names: [
                    ProductItem.Name(language: "en", name: "Bee"),
                    ProductItem.Name(language: "ko", name: "벌"),
                ],
                category: baseCategory,
                itemCategory2: "곤충"
            ),
            ProductItem(
                id: "ant",
                names: [
                    ProductItem.Name(language: "en", name: "Ant"),
                    ProductItem.Name(language: "ko", name: "개미"),
                ],
                category: baseCategory,
                itemCategory2: "곤충"
            ),
            
            ProductItem(
                id: "spider",
                names: [
                    ProductItem.Name(language: "en", name: "Spider"),
                    ProductItem.Name(language: "ko", name: "거미"),
                ],
                category: baseCategory,
                itemCategory2: "절지동물"
            ),
            ProductItem(
                id: "crab",
                names: [
                    ProductItem.Name(language: "en", name: "Crab"),
                    ProductItem.Name(language: "ko", name: "게"),
                ],
                category: baseCategory,
                itemCategory2: "절지동물"
            ),
            ProductItem(
                id: "lobster",
                names: [
                    ProductItem.Name(language: "en", name: "Lobster"),
                    ProductItem.Name(language: "ko", name: "바닷가재"),
                ],
                category: baseCategory,
                itemCategory2: "절지동물"
            ),
            
            ProductItem(
                id: "kangaroo",
                names: [
                    ProductItem.Name(language: "en", name: "Kangaroo"),
                    ProductItem.Name(language: "ko", name: "캥거루"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
        ]
        
        return mock
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
