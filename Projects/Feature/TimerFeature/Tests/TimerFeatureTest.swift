import ComposableArchitecture
import XCTest

@testable import TimerFeature

@MainActor
final class TimerFeatureTests: XCTestCase {
    override func setUpWithError() throws {}
    
    override func tearDownWithError() throws {}
    
    func testInitialState() {
        let store = TestStore(
            initialState: TimerReducer.State(totalTime: 3.0)
        ) {
            TimerReducer()
        }
        
        XCTAssertEqual(store.state.totalTime, 3.0)
        XCTAssertEqual(store.state.remainingTime, 3.0)
        XCTAssertEqual(store.state.currentTime, "3.0")
    }
    
    func testSetTime() async {
        let store = TestStore(
            initialState: TimerReducer.State(totalTime: 3.0)
        ) {
            TimerReducer()
        }
        
        await store.send(.setTime(5.0)) {
            $0.totalTime = 5.0
            $0.remainingTime = 5.0
            $0.currentTime = "5.0"
        }
        
        // 상태 검증
        XCTAssertEqual(store.state.totalTime, 5.0)
        XCTAssertEqual(store.state.remainingTime, 5.0)
        XCTAssertEqual(store.state.currentTime, "5.0")
    }
    
    func testStop() async {
        let store = TestStore(
            initialState: TimerReducer.State(totalTime: 3.0)
        ) {
            TimerReducer()
        }
        
        await store.send(.stop)
    }
}
