import Testing
import Foundation
@testable import LocalDataCore

struct LocalDataCoreTests {
    @Test("초기값, 값변경, 값변경 확인") func firstSecondThirdSaveAndCall() async {
        // given
        let suiteName = "com.monoree.test"
        let testDefaults = UserDefaults(suiteName: suiteName)!
        let sut = LocalDataUsecaseImpl(userDefault: testDefaults)
        
        let saveData1 = "Test Data Save1"
        let saveData2 = "Test Data Save2"
        
        // when
        let result01 = await sut.getIDFA()
        await sut.setIDFA(saveData1)
        let result02 = await sut.getIDFA()
        await sut.setIDFA(saveData2)
        let result03 = await sut.getIDFA()
        
        // then
        #expect(result01 == nil, "최초 호출시, 내부 데이터는 비어있어야 합니다.")
        #expect(result02 == saveData1, "\(result02 ?? "") is not equal")
        #expect(result03 == saveData2, "\(result02 ?? "") is not equal")
        
        testDefaults.removePersistentDomain(forName: suiteName)
    }
}
