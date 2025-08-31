import Testing
import Foundation
@testable import LocalDataCore

struct LocalDataCoreTests {
    
    private let suiteName = "com.monoree.test"
    private var testDefaults: UserDefaults {
        UserDefaults(suiteName: suiteName)!
    }
    
    init() {
        testDefaults.removePersistentDomain(forName: suiteName)
    }
    
    @Test("광고키 초기값, 값변경, 값변경 확인") func firstSecondThirdSaveAndCall() async {
        // given
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
    }
    
    @Test("게임플레이 데이트 로그 값 확인") func gamePlayDateCheck() async {
        // given
        let sut = LocalDataUsecaseImpl(userDefault: testDefaults)
        
        // when
        let dates = await sut.getPlayDates()
        await sut.putPlayDate()
        let changeDates = await sut.getPlayDates()
        let todayDates = await sut.getPlayDatesToday()
        await sut.putPlayDate()
        await sut.putPlayDate()
        let todayDates2 = await sut.getPlayDatesToday()
        
        // then
        #expect(dates.count == 0, "최초 호출시 목록이 비어져 있어야 합니다.")
        #expect(changeDates.count == 1, "목록이 추가되어야 합니다.")
        #expect(todayDates.count == 1, "오늘이 추가되어야 합니다.")
        #expect(todayDates2.count == 3, "\(todayDates2.count) 오늘이 추가되어야 합니다.")
    }
}
