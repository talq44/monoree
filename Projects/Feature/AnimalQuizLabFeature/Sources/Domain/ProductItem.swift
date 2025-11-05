import Foundation

struct ProductItem: Equatable {
    struct Name: Equatable {
        let language: String
        let name: String
    }
    
    let id: String
    let names: [Name]
    let category: String
    let itemCategory2: String
}
