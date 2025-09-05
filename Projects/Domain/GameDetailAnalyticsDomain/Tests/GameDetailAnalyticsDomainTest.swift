import GameDetailAnalyticsDomainInterface
import Testing

@testable import GameDetailAnalyticsDomain
@testable import GameDetailAnalyticsDomainTesting

struct GameDetailAnalyticsDomainTests {
    private func makeItem() -> GameDetailItem {
        return GameDetailItem(
            item_id: "id-1",
            item_name: "name-1",
            item_list_id: "list-1",
            item_list_name: "list-name",
            item_category: "cat-1",
            item_category2: "cat-2",
            item_variant: "v1"
        )
    }
    
    @Test("action 이벤트 전송") func actionSendEvent() async {
        // given
        let mock = AnalyticsManagerMock()
        let usecase = GameDetailAnalyticsUsecaseImpl(analytics: mock)
        
        // when
        await usecase.sendEvent(.action(.categoryPlus))
        
        // then
        #expect(mock.sendEventCallCount == 1)
        #expect(mock.sendEventCalledWith?.name == "select_content")
    }
    
    @Test("add_to_wishlist 이벤트 전송") func addToWishlistSendEvent() async {
        // given
        let mock = AnalyticsManagerMock()
        let usecase = GameDetailAnalyticsUsecaseImpl(analytics: mock)
        let item = makeItem()
        
        // when
        await usecase.sendEvent(.add_to_wishlist(item))
        
        // then
        #expect(mock.sendEventCallCount == 1)
        #expect(mock.sendEventCalledWith?.name == "add_to_wishlist")
    }
    
    @Test("view_item 이벤트 전송") func viewItemSendEvent() async {
        // given
        let mock = AnalyticsManagerMock()
        let usecase = GameDetailAnalyticsUsecaseImpl(analytics: mock)
        let item = makeItem()
        
        // when
        await usecase.sendEvent(.view_item(item))
        
        // then
        #expect(mock.sendEventCallCount == 1)
        #expect(mock.sendEventCalledWith?.name == "view_item")
    }
    
    @Test("play_item 이벤트 전송") func playItemSendEvent() async {
        // given
        let mock = AnalyticsManagerMock()
        let usecase = GameDetailAnalyticsUsecaseImpl(analytics: mock)
        let item = makeItem()
        
        // when
        await usecase.sendEvent(.play_item(item))
        
        // then
        #expect(mock.sendEventCallCount == 1)
        #expect(mock.sendEventCalledWith?.name == "play_item")
    }
}
