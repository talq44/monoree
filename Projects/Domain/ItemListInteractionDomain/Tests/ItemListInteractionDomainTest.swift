import XCTest

@testable import ItemListInteractionDomain
@testable import ItemListInteractionDomainTesting

final class ItemListInteractionDomainTests: XCTestCase {
    
    private var repository: MockItemListInteractionRepository!
    private var sut: ItemListInteractionUseCaseImpl!
    
    override func setUpWithError() throws {
        self.repository = MockItemListInteractionRepository()
        self.sut = ItemListInteractionUseCaseImpl(repository: self.repository)
    }
    
    override func tearDownWithError() throws {
        self.sut = nil
        self.repository = nil
    }
    
    // MARK: - Test Cases

    // 1. selectItemEmpty
    func test_selectItemEmpty_when_send_then_no_send() {
        // given
        let input = StubItemListInteractionInput.selectItemEmpty

        // when
        self.sut.send(input)

        // then
        XCTAssertEqual(
            self.repository.sendSelectItemItemsCount, 0,
            "0개일 경우 전송이 일어나선 안됩니다."
        )
    }
    
    // 2. selectItemNormal
    func test_selectItemNormal_when_send_then_send_once() {
        // given
        let input = StubItemListInteractionInput.selectItemNormal
        
        // when
        self.sut.send(input)
        
        // then
        XCTAssertEqual(
            self.repository.sendSelectItemItemsCount, 1,
            "1개의 아이템이 전송되어야 합니다."
        )
    }
    
    // 3. selectItemMultiple
    func test_selectItemMultiple_when_send_then_send_correct_count() {
        // given
        let count = 5
        let input = StubItemListInteractionInput.selectItemMultiple(count: count)
        
        // when
        self.sut.send(input)
        
        // then
        XCTAssertEqual(
            self.repository.sendSelectItemItemsCount, count,
            "\(count)개의 아이템이 전송되어야 합니다."
        )
    }
    
    // 4. viewItemListEmpty
    func test_viewItemListEmpty_when_view_then_no_items() {
        // given
        let input = StubItemListInteractionInput.viewitemListEmpty
        
        // when
        self.sut.send(input)
        
        // then
        XCTAssertEqual(
            self.repository.sendViewItemListItemsCount, 0,
            "0개의 아이템이 전송되어야 합니다."
        )
    }
    
    // 5. viewItemListNormal
    func test_viewItemListNormal_when_view_then_view_once() {
        // given
        let input = StubItemListInteractionInput.viewItemListNormal
        
        // when
        self.sut.send(input)
        
        // then
        XCTAssertEqual(
            self.repository.sendViewItemListItemsCount, 1,
            "1개의 아이템이 전송되어야 합니다."
        )
    }
    
    // 6. viewItemListMultiple
    func test_viewItemListMultiple_when_view_then_view_correct_count() {
        // given
        let count = 3
        let input = StubItemListInteractionInput.viewItemListMultiple(count: count)
        
        // when
        self.sut.send(input)
        
        // then
        XCTAssertEqual(
            self.repository.sendViewItemListItemsCount, count,
            "\(count)개의 아이템이 전송되어야 합니다."
        )
    }
}
