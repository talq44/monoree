import Foundation

struct HomeSection: Equatable, Identifiable {
    let id: String
    let title: String
    let subTitle: String
    /// hex
    let titleColor: String?
    /// hex
    let subTitleColor: String?
    let backgroundColor: String?
    let imageUrl: String?
    let imageName: String?
    let sectionType: HomeSectionType
    let items: [Item]
    
    struct Item: Equatable, Identifiable {
        let id: String
        let title: String
        let subtitle: String
        let emoji: String
        let imageURL: String?
        let itemType: HomeItemType
    }
}
