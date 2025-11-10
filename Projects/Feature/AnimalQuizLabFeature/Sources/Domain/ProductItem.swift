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

extension ProductItem {
    var imageURL: String {
        return "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/toy3D/\(id).webp"
    }
    
    var name: String {
        guard let langCode = Locale.current.language.languageCode?.identifier,
              let item = names.first(where: { $0.language == langCode }) else {
            let enName = names.first(where: { $0.language == "en" })?.name
            return enName ?? names.first?.name ?? ""
        }
        
        return item.name
    }
}
