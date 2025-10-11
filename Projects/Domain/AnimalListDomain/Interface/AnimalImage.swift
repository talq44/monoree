import Foundation

public protocol AnimalImage {
    var imageURL: String { get }
    var style: AnimalImageStyle { get }
}
