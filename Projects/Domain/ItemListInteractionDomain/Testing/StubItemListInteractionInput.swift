import Foundation

import DomainModelsDomainInterface
import ItemListInteractionDomainInterface

struct StubItemListInteractionInput: ItemListInteractionInput {
    var items: [any ItemListInteractionDomainInterface.ItemListItem]
    var itemList: any ItemList
    var sendType: ItemListSendType
        
    static var selectItemNormal: StubItemListInteractionInput {
        StubItemListInteractionInput(
            items: [StubItemListItem.mock()],
            itemList: ItemListType.tbd,
            sendType: .selectItem
        )
    }
    
    static var selectItemEmpty: StubItemListInteractionInput {
        StubItemListInteractionInput(
            items: [],
            itemList: ItemListType.tbd,
            sendType: .selectItem
        )
    }
    
    static func selectItemMultiple(
        count: Int
    ) -> StubItemListInteractionInput {
        let items = (0..<count).map { index in
            return StubItemListItem(
                id: "\(index)",
                name: "name_\(index)",
                index: index
            )
        }
        
        return StubItemListInteractionInput(
            items: items,
            itemList: ItemListType.tbd,
            sendType: .selectItem
        )
    }
    
    static var viewItemListNormal: StubItemListInteractionInput {
        StubItemListInteractionInput(
            items: [StubItemListItem.mock()],
            itemList: ItemListType.tbd,
            sendType: .viewItemList
        )
    }
    
    static var viewitemListEmpty: StubItemListInteractionInput {
        StubItemListInteractionInput(
            items: [],
            itemList: ItemListType.tbd,
            sendType: .viewItemList
        )
    }
    
    static func viewItemListMultiple(
        count: Int
    ) -> StubItemListInteractionInput {
        let items = (0..<count).map { index in
            return StubItemListItem(
                id: "\(index)",
                name: "name_\(index)",
                index: index
            )
        }
        
        return StubItemListInteractionInput(
            items: items,
            itemList: ItemListType.tbd,
            sendType: .viewItemList
        )
    }
}
