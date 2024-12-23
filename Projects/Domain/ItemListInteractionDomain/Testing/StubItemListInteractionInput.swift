import Foundation

import ItemListInteractionDomainInterface

struct StubItemListInteractionInput: ItemListInteractionInput {
    var items: [any ItemListInteractionDomainInterface.ItemListItem]
    var itemList: ItemList
    var sendType: ItemListSendType
        
    static var selectItemNormal: StubItemListInteractionInput {
        StubItemListInteractionInput(
            items: [StubItemListItem.mock()],
            itemList: .category(ItemListInfo(id: nil, name: nil)),
            sendType: .selectItem
        )
    }
    
    static var selectItemEmpty: StubItemListInteractionInput {
        StubItemListInteractionInput(
            items: [],
            itemList: .category(ItemListInfo(id: nil, name: nil)),
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
            itemList: .category(ItemListInfo(id: nil, name: nil)),
            sendType: .viewItemList
        )
    }
    
    static var viewItemListNormal: StubItemListInteractionInput {
        StubItemListInteractionInput(
            items: [StubItemListItem.mock()],
            itemList: .category(ItemListInfo(id: nil, name: nil)),
            sendType: .viewItemList
        )
    }
    
    static var viewitemListEmpty: StubItemListInteractionInput {
        StubItemListInteractionInput(
            items: [],
            itemList: .category(ItemListInfo(id: nil, name: nil)),
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
            itemList: .category(ItemListInfo(id: nil, name: nil)),
            sendType: .viewItemList
        )
    }
}
