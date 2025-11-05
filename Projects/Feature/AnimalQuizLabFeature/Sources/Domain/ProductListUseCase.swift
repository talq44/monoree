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
        
        let baseCategory = "동물"
        let mock: [ProductItem] = [
            ProductItem(
                id: "Dog",
                names: [
                    ProductItem.Name(language: "en", name: "Dog"),
                    ProductItem.Name(language: "ko", name: "개"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "Cat",
                names: [
                    ProductItem.Name(language: "en", name: "Cat"),
                    ProductItem.Name(language: "ko", name: "고양이"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "Elephant",
                names: [
                    ProductItem.Name(language: "en", name: "Elephant"),
                    ProductItem.Name(language: "ko", name: "코끼리"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "Lion",
                names: [
                    ProductItem.Name(language: "en", name: "Lion"),
                    ProductItem.Name(language: "ko", name: "사자"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "Tiger",
                names: [
                    ProductItem.Name(language: "en", name: "Tiger"),
                    ProductItem.Name(language: "ko", name: "호랑이"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "Giraffe",
                names: [
                    ProductItem.Name(language: "en", name: "Giraffe"),
                    ProductItem.Name(language: "ko", name: "기린"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "Bear",
                names: [
                    ProductItem.Name(language: "en", name: "Bear"),
                    ProductItem.Name(language: "ko", name: "곰"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "Wolf",
                names: [
                    ProductItem.Name(language: "en", name: "Wolf"),
                    ProductItem.Name(language: "ko", name: "늑대"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "Dolphin",
                names: [
                    ProductItem.Name(language: "en", name: "Dolphin"),
                    ProductItem.Name(language: "ko", name: "돌고래"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            ProductItem(
                id: "Whale",
                names: [
                    ProductItem.Name(language: "en", name: "Whale"),
                    ProductItem.Name(language: "ko", name: "고래"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
            
            ProductItem(
                id: "Eagle",
                names: [
                    ProductItem.Name(language: "en", name: "Eagle"),
                    ProductItem.Name(language: "ko", name: "독수리"),
                ],
                category: baseCategory,
                itemCategory2: "조류"
            ),
            ProductItem(
                id: "Sparrow",
                names: [
                    ProductItem.Name(language: "en", name: "Sparrow"),
                    ProductItem.Name(language: "ko", name: "참새"),
                ],
                category: baseCategory,
                itemCategory2: "조류"
            ),
            ProductItem(
                id: "Penguin",
                names: [
                    ProductItem.Name(language: "en", name: "Penguin"),
                    ProductItem.Name(language: "ko", name: "펭귄"),
                ],
                category: baseCategory,
                itemCategory2: "조류"
            ),
            ProductItem(
                id: "Owl",
                names: [
                    ProductItem.Name(language: "en", name: "Owl"),
                    ProductItem.Name(language: "ko", name: "부엉이"),
                ],
                category: baseCategory,
                itemCategory2: "조류"
            ),
            ProductItem(
                id: "Flamingo",
                names: [
                    ProductItem.Name(language: "en", name: "Flamingo"),
                    ProductItem.Name(language: "ko", name: "플라밍고"),
                ],
                category: baseCategory,
                itemCategory2: "조류"
            ),
            
            ProductItem(
                id: "Crocodile",
                names: [
                    ProductItem.Name(language: "en", name: "Crocodile"),
                    ProductItem.Name(language: "ko", name: "악어"),
                ],
                category: baseCategory,
                itemCategory2: "파충류"
            ),
            ProductItem(
                id: "Snake",
                names: [
                    ProductItem.Name(language: "en", name: "Snake"),
                    ProductItem.Name(language: "ko", name: "뱀"),
                ],
                category: baseCategory,
                itemCategory2: "파충류"
            ),
            ProductItem(
                id: "Turtle",
                names: [
                    ProductItem.Name(language: "en", name: "Turtle"),
                    ProductItem.Name(language: "ko", name: "거북이"),
                ],
                category: baseCategory,
                itemCategory2: "파충류"
            ),
            
            ProductItem(
                id: "Frog",
                names: [
                    ProductItem.Name(language: "en", name: "Frog"),
                    ProductItem.Name(language: "ko", name: "개구리"),
                ],
                category: baseCategory,
                itemCategory2: "양서류"
            ),
            ProductItem(
                id: "Salamander",
                names: [
                    ProductItem.Name(language: "en", name: "Salamander"),
                    ProductItem.Name(language: "ko", name: "도롱뇽"),
                ],
                category: baseCategory,
                itemCategory2: "양서류"
            ),
            
            ProductItem(
                id: "Shark",
                names: [
                    ProductItem.Name(language: "en", name: "Shark"),
                    ProductItem.Name(language: "ko", name: "상어"),
                ],
                category: baseCategory,
                itemCategory2: "어류"
            ),
            ProductItem(
                id: "Clownfish",
                names: [
                    ProductItem.Name(language: "en", name: "Clownfish"),
                    ProductItem.Name(language: "ko", name: "흰동가리"),
                ],
                category: baseCategory,
                itemCategory2: "어류"
            ),
            ProductItem(
                id: "Salmon",
                names: [
                    ProductItem.Name(language: "en", name: "Salmon"),
                    ProductItem.Name(language: "ko", name: "연어"),
                ],
                category: baseCategory,
                itemCategory2: "어류"
            ),
            
            ProductItem(
                id: "Butterfly",
                names: [
                    ProductItem.Name(language: "en", name: "Butterfly"),
                    ProductItem.Name(language: "ko", name: "나비"),
                ],
                category: baseCategory,
                itemCategory2: "곤충"
            ),
            ProductItem(
                id: "Bee",
                names: [
                    ProductItem.Name(language: "en", name: "Bee"),
                    ProductItem.Name(language: "ko", name: "벌"),
                ],
                category: baseCategory,
                itemCategory2: "곤충"
            ),
            ProductItem(
                id: "Ant",
                names: [
                    ProductItem.Name(language: "en", name: "Ant"),
                    ProductItem.Name(language: "ko", name: "개미"),
                ],
                category: baseCategory,
                itemCategory2: "곤충"
            ),
            
            ProductItem(
                id: "Spider",
                names: [
                    ProductItem.Name(language: "en", name: "Spider"),
                    ProductItem.Name(language: "ko", name: "거미"),
                ],
                category: baseCategory,
                itemCategory2: "절지동물"
            ),
            ProductItem(
                id: "Crab",
                names: [
                    ProductItem.Name(language: "en", name: "Crab"),
                    ProductItem.Name(language: "ko", name: "게"),
                ],
                category: baseCategory,
                itemCategory2: "절지동물"
            ),
            ProductItem(
                id: "Lobster",
                names: [
                    ProductItem.Name(language: "en", name: "Lobster"),
                    ProductItem.Name(language: "ko", name: "바닷가재"),
                ],
                category: baseCategory,
                itemCategory2: "절지동물"
            ),
            
            ProductItem(
                id: "Kangaroo",
                names: [
                    ProductItem.Name(language: "en", name: "Kangaroo"),
                    ProductItem.Name(language: "ko", name: "캥거루"),
                ],
                category: baseCategory,
                itemCategory2: "포유류"
            ),
        ]
        
        // Cache and return filtered
        cache = mock
        return cache.filter { item in
            let matchCategory = category.map { $0 == item.category } ?? true
            let matchSub = itemCategory2.map { $0 == item.itemCategory2 } ?? true
            return matchCategory && matchSub
        }
    }
    
    func executePlay(withType: GameType, questionCount: Int, choicesCount: Int) async throws
    -> [GameItem]
    {
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
                items: cache,
                questionCount: questionCount,
                choicesCount: choicesCount
            )
        case .categoryDifferent:
            return executeCategory2Style(
                items: cache,
                questionCount: questionCount,
                choicesCount: choicesCount
            )
        }
    }
    
    private func executeCountStyle(
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
                question: $0.element,
                choices: choices[$0.offset]
            )
        }
    }
    
    private func executeCategory2Style(
        items: [ProductItem],
        questionCount: Int,
        choicesCount: Int
    ) -> [GameItem] {
        let selected: [ProductItem] = items.shuffled(count: questionCount)
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
                choices.append(equals)
                continue
            }
            
            choices.append((equals + [notEqual]).shuffled())
        }
        
        return selected.enumerated().map {
            return GameItem(
                question: $0.element,
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
