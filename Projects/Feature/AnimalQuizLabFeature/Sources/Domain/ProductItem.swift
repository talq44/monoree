import Foundation

struct ProductItem {
    struct Name {
        let language: String
        let name: String
    }
    
    let id: String
    let names: [Name]
    let category: String
    let itemCategory2: [String]
    let itemCategory3: [String]
}
