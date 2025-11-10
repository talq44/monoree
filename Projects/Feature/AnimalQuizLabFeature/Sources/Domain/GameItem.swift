import Foundation

struct GameItem: Equatable {
    let type: GameType
    let question: ProductItem
    let answer: ProductItem
    let choices: [ProductItem]
}
