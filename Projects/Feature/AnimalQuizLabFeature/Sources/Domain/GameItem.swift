import Foundation

struct GameItem: Equatable {
    let type: GameType
    let question: ProductItem
    let choices: [ProductItem]
}
