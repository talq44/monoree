import XCTest

import LocalDataCoreInterface
@testable import LocalDataCore

final class LocalDataCoreTests: XCTestCase {
    
    private var sut: LocalDataProtocolImpl!
    
    override func setUpWithError() throws {
        self.sut = try LocalDataProtocolImpl()
    }
    
    override func tearDownWithError() throws {
        self.sut = nil
    }
}
