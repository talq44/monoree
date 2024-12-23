import Foundation

public protocol ItemListInteractionRepository {
    func sendViewItemList(_ input: ItemListInteractionInput)
    func sendSelectItem(_ input: ItemListInteractionInput)
}
