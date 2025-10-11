import Foundation

public protocol Animal {
    var id: String { get }
    var nameKo: String { get }
    var nameEn: String { get }
    var category: Set<AnimalCategory> { get }
    var imageURL: String { get }
}
